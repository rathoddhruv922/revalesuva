import 'package:get/get.dart';
import 'package:revalesuva/model/empty_model/empty_model.dart';
import 'package:revalesuva/model/tools/nutrition_model/change_nutrition_status_model.dart'
    as change_nutrition_status_model;
import 'package:revalesuva/model/tools/nutrition_model/nutrition_model.dart' as nutrition_model;
import 'package:revalesuva/model/tools/nutrition_model/selected_nutrition_data.dart'
    as selected_nutrition_data;
import 'package:revalesuva/model/tools/nutrition_model/store_nutrition_model.dart'
    as store_nutrition_model;
import 'package:revalesuva/model/tools/nutrition_model/user_nutrition_model.dart'
    as user_nutrition_model;
import 'package:revalesuva/repository/repository.dart';
import 'package:revalesuva/services/api_status.dart';
import 'package:revalesuva/utils/date_format_helper.dart';
import 'package:revalesuva/utils/helper_method.dart';
import 'package:revalesuva/view_models/user_view_model.dart';

class DailyNutritionViewModel extends GetxController {
  var listVegetableNutrition = <nutrition_model.Datum>[].obs;
  var listProteinNutrition = <nutrition_model.Datum>[].obs;
  var listCarbsNutrition = <nutrition_model.Datum>[].obs;
  var listFatsNutrition = <nutrition_model.Datum>[].obs;

  var listUserNutrition = <user_nutrition_model.Datum>[].obs;
  var listMainUserNutrition = <user_nutrition_model.Datum>[].obs;
  var userStoreNutrition = store_nutrition_model.StoreNutritionModel().obs;
  var userSelectedData = selected_nutrition_data.SelectedNutritionData().obs;
  var isAvailable = false.obs;

  onCreate() async {
    await fetchNutrition();
    await fetchUserDailyNutritionByDate();
  }

  fetchNutrition() async {
    showLoader();
    var response = await Repository.instance.getDailyNutritionApi();
    hideLoader();
    if (response is Success) {
      var result = nutrition_model.nutritionModelFromJson(response.response.toString());
      _clearLists();
      for (nutrition_model.Datum item in result.data ?? []) {
        _addItemToList(item);
      }
    } else if (response is Failure) {
      showToast(msg: "${response.errorResponse ?? ""}");
    }
  }

  fetchUserDailyNutritionByDate() async {
    showLoader();
    var response = await Repository.instance.getUserDailyNutritionByDateApi();
    hideLoader();
    if (response is Success) {
      var result = user_nutrition_model.userNutritionModelFromJson(response.response.toString());
      if(result.status == 200){
        listUserNutrition.assignAll(result.data ?? []);
        listMainUserNutrition.assignAll(result.data ?? []);
        selectedNutritionShow();
        isAvailable.value = false;
      }else{
        isAvailable.value = true;
      }
    } else if (response is Failure) {
      isAvailable.value = true;
      //showToast(msg: "${response.errorResponse ?? ""}");
    }
  }

  void _clearLists() {
    listVegetableNutrition.clear();
    listProteinNutrition.clear();
    listCarbsNutrition.clear();
    listFatsNutrition.clear();
  }

  void _addItemToList(nutrition_model.Datum item) {
    switch (item.nutritionType) {
      case "Proteins":
        listProteinNutrition.add(item);
        break;
      case "Vegetables":
        listVegetableNutrition.add(item);
        break;
      case "Carbohydrates":
        listCarbsNutrition.add(item);
        break;
      case "Fats":
        listFatsNutrition.add(item);
        break;
    }
  }

  selectedNutritionShow() {
    userSelectedData.value = selected_nutrition_data.SelectedNutritionData(
      breakfast: _getNutritionType("breakfast"),
      lunch: _getNutritionType("lunch"),
      dinner: _getNutritionType("dinner"),
      snacks: _getNutritionType("snacks")
    );
    List<store_nutrition_model.NutritionDatum> nutritionData = [];
    for (user_nutrition_model.Datum item in listUserNutrition) {
      nutritionData.add(
        store_nutrition_model.NutritionDatum(
          nutritionId: item.nutritionId,
          foodType: item.foodType,
        ),
      );
    }
    userStoreNutrition.value = store_nutrition_model.StoreNutritionModel(
      date: DateTime.now(),
      trainerId: Get.find<UserViewModel>().userPlanDetail.value.trainerId,
      nutritionData: nutritionData,
    );
  }

  selected_nutrition_data.NutritionType _getNutritionType(String mealType) {
    return selected_nutrition_data.NutritionType(
      vegetables: _getNutritionNames(mealType, "vegetables"),
      proteins: _getNutritionNames(mealType, "proteins"),
      carbohydrates: _getNutritionNames(mealType, "carbohydrates"),
      fats: _getNutritionNames(mealType, "fats"),
    );
  }

  selected_nutrition_data.Nutrition _getNutritionNames(String mealType, String nutritionType) {
    var nutrition = listUserNutrition
        .where((item) =>
            item.nutrition?.nutritionType?.toLowerCase() == nutritionType && item.foodType == mealType)
        .map((item) => item.nutrition?.name)
        .join(",");
    var status = "";
    var statusBuilder = listUserNutrition
        .where((item) =>
            item.nutrition?.nutritionType?.toLowerCase() == nutritionType && item.foodType == mealType)
        .map((item) => item.status);

    if (statusBuilder.any((element) => element == "pending" || element == "")) {
      status = "pending";
    } else if (statusBuilder.any((element) => element == "approved")) {
      status = "approved";
    } else if (statusBuilder.any((element) => element == "completed")) {
      status = "completed";
    } else {
      status = "pending";
    }

    List<int> nutritionId = listUserNutrition
        .where((item) =>
            item.nutrition?.nutritionType?.toLowerCase() == nutritionType && item.foodType == mealType)
        .map((item) => item.nutrition?.id ?? -1)
        .toList();

    return selected_nutrition_data.Nutrition(
      nutritionName: nutrition,
      status: status,
      nutritionId: nutritionId,
    );
  }

  nutritionSendToCoach() async {
    showLoader();
    var response =
        await Repository.instance.storeUserNutritionApi(userNutrition: userStoreNutrition.value);
    hideLoader();
    if (response is Success) {
      var result = emptyModelFromJson(response.response.toString());
      showToast(msg: result.message ?? "");
      await fetchUserDailyNutritionByDate();
    } else if (response is Failure) {
      showToast(msg: "${response.errorResponse ?? ""}");
    }
  }

  changeNutritionStatus(
      {required String status, required List<int> ids, required String mealType}) async {
    showLoader();
    var listId = <change_nutrition_status_model.NutritionDatum>[];
    for (var item in ids) {
      listId.add(
        change_nutrition_status_model.NutritionDatum(
          nutritionId: item,
          mealType: mealType,
        ),
      );
    }
    var data = change_nutrition_status_model.ChangeNutritionStatusModel(
      status: status,
      nutritionData: listId,
      date: changeDateStringFormat(
        date: DateTime.now().toString(),
        format: DateFormatHelper.ymdFormat,
      ),
    );
    var response = await Repository.instance.changeNutritionStatusApi(changeNutrition: data);
    hideLoader();
    if (response is Success) {
      var result = emptyModelFromJson(response.response.toString());
      showToast(msg: result.message ?? "");
      await fetchUserDailyNutritionByDate();
    } else if (response is Failure) {
      showToast(msg: "${response.errorResponse ?? ""}");
    }
  }
}
