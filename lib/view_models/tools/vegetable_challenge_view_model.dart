import 'package:get/get.dart';
import 'package:revalesuva/model/empty_model/empty_model.dart';
import 'package:revalesuva/model/tools/nutrition_model/nutrition_model.dart' as nutrition_model;
import 'package:revalesuva/model/tools/nutrition_model/selected_nutrition_data.dart'
    as selected_nutrition_data;
import 'package:revalesuva/model/tools/nutrition_model/user_nutrition_model.dart'
    as user_nutrition_model;
import 'package:revalesuva/model/tools/vegetable_challenge/store_user_challenge_model.dart'
    as store_user_challenge_model;
import 'package:revalesuva/model/tools/vegetable_challenge/user_vegetable_challenge_model.dart'
    as user_vegetable_challenge_model;
import 'package:revalesuva/repository/repository.dart';
import 'package:revalesuva/services/api_status.dart';
import 'package:revalesuva/utils/date_format_helper.dart';
import 'package:revalesuva/utils/helper_method.dart';
import 'package:revalesuva/view_models/user_view_model.dart';

class VegetableChallengeViewModel extends GetxController {
  var listROPNutrition = <nutrition_model.Datum>[].obs;
  var listYWNutrition = <nutrition_model.Datum>[].obs;
  var listGNutrition = <nutrition_model.Datum>[].obs;
  var listAllNutrition = <nutrition_model.Datum>[].obs;

  var userSelectedROPNutrition = selected_nutrition_data.Nutrition().obs;
  var userSelectedYWNutrition = selected_nutrition_data.Nutrition().obs;
  var userSelectedGNutrition = selected_nutrition_data.Nutrition().obs;

  var userShowAllNutrition = <user_vegetable_challenge_model.Datum>[].obs;
  var userShowROPNutrition = <user_vegetable_challenge_model.Datum>[].obs;
  var userShowYWNutrition = <user_vegetable_challenge_model.Datum>[].obs;
  var userShowGNutrition = <user_vegetable_challenge_model.Datum>[].obs;

  var isLoading = false.obs;

  var userStoreNutrition = store_user_challenge_model.StoreUserChallengeModel().obs;

  var listUserNutrition = <user_nutrition_model.Datum>[].obs;
  var listMainUserNutrition = <user_nutrition_model.Datum>[].obs;

  var lastUpdateDayOfWeek = 0.obs;
  var isAllowToAttempt = false.obs;
  var daysFromPlanStartToCurrent = 0.obs;
  var remainStartDay = 0.obs;

  fetchNutrition() async {
    var response = await Repository.instance.getDailyNutritionApi();
    if (response is Success) {
      var result = nutrition_model.nutritionModelFromJson(response.response.toString());
      listAllNutrition.assignAll(result.data ?? []);
      _clearLists();
      for (nutrition_model.Datum item in result.data ?? []) {
        _addItemToList(item);
      }
      listROPNutrition.refresh();
      listYWNutrition.refresh();
      listGNutrition.refresh();
    } else if (response is Failure) {
      showToast(msg: "${response.errorResponse ?? ""}");
    }
  }

  void checkAllowToAttempt() {
    if (Get.find<UserViewModel>().userPlanDetail.value.id != null) {
      DateTime? startDateTime = DateTime.tryParse(
          "${Get.find<UserViewModel>().userPlanDetail.value.plan?.planCycles?.first.startDate}");

      if (startDateTime != null) {
        DateTime startDate = startDateTime.add(
          Duration(
            days: (int.tryParse(Get.find<UserViewModel>()
                            .userPlanDetail
                            .value
                            .plan
                            ?.settings
                            ?.vegetablesChallenge
                            ?.day ??
                        "") ??
                    7) -
                1,
          ),
        );
        DateTime endDate = startDate.add(const Duration(days: 7));

        DateTime currentDate = DateTime.now();
        bool isWithinRange = currentDate.isAfter(startDate) && currentDate.isBefore(endDate);

        if (isWithinRange) {
          isAllowToAttempt.value = true;
        } else {
          isAllowToAttempt.value = false;
        }
        daysFromPlanStartToCurrent.value = DateTime.now().difference(startDate).inDays;
        remainStartDay.value = 0;
        if (daysFromPlanStartToCurrent.value < 0) {
          daysFromPlanStartToCurrent.value = 0;
          remainStartDay.value = DateTime.now().difference(startDate).inDays.abs();
        }
        if (daysFromPlanStartToCurrent.value > 7) {
          daysFromPlanStartToCurrent.value = 7;
        }
      }
    }
  }

  fetchUserNutrition() async {
    var response = await Repository.instance.getUserVegetableChallengeNutritionByDate(
        // date: DateTime.now().toString(),
        );
    if (response is Success) {
      var result = user_vegetable_challenge_model
          .userVegetableChallengeModelFromJson(response.response.toString());
      _clearUserLists();
      userShowAllNutrition.assignAll(result.data ?? []);
      for (user_vegetable_challenge_model.Datum item in result.data ?? []) {
        _addItemToUserList(item);
      }

      lastUpdateDayOfWeek.value =
          DateUtils.findMostRecentDate(userShowAllNutrition)?.difference(DateTime.now()).inDays.abs() ??
              0;

      listROPNutrition.refresh();
      listYWNutrition.refresh();
      listGNutrition.refresh();
      fillOutCurrentDateData();
    } else if (response is Failure) {
      showToast(msg: "${response.errorResponse ?? ""}");
    }
  }

  void _clearLists() {
    listROPNutrition.clear();
    listYWNutrition.clear();
    listGNutrition.clear();
  }

  void _clearUserLists() {
    userShowROPNutrition.clear();
    userShowYWNutrition.clear();
    userShowGNutrition.clear();
  }

  void _addItemToUserList(user_vegetable_challenge_model.Datum item) {
    switch (item.nutrition?.color?.toLowerCase()) {
      case "red" || "orange" || "purple":
        userShowROPNutrition.add(item);
        break;
      case "yellow" || "white":
        userShowYWNutrition.add(item);
        break;
      case "green":
        userShowGNutrition.add(item);
        break;
    }
  }

  void _addItemToList(nutrition_model.Datum item) {
    if (item.nutritionType?.toLowerCase() == "vegetables") {
      switch (item.color?.toLowerCase()) {
        case "red" || "orange" || "purple":
          listROPNutrition.add(item);
          break;
        case "yellow" || "white":
          listYWNutrition.add(item);
          break;
        case "green":
          listGNutrition.add(item);
          break;
      }
    }
  }

  fillOutCurrentDateData() {
    listUserNutrition.clear();
    for (var item in userShowAllNutrition) {
      nutrition_model.Datum selectedItem =
          listAllNutrition.firstWhere((element) => element.id == item.nutritionId);

      if (changeDateStringFormat(date: item.date.toString(), format: DateFormatHelper.ymdFormat) ==
          changeDateStringFormat(date: DateTime.now().toString(), format: DateFormatHelper.ymdFormat)) {
        listUserNutrition.add(
          user_nutrition_model.Datum(
            nutritionId: selectedItem.id,
            status: "pending",
            nutrition: user_nutrition_model.Nutrition(
              id: selectedItem.id,
              nutritionType: selectedItem.nutritionType,
              color: selectedItem.color,
              name: selectedItem.name,
              isActive: selectedItem.isActive,
              createdAt: selectedItem.createdAt,
              updatedAt: selectedItem.updatedAt,
            ),
          ),
        );
      }
    }
    selectedNutritionShow();
  }

  selectedNutritionShow() {
    userSelectedROPNutrition.value = _getNutritionNames(["red", "orange", "purple"]);
    userSelectedYWNutrition.value = _getNutritionNames(["yellow", "white"]);
    userSelectedGNutrition.value = _getNutritionNames(["green"]);

    List<store_user_challenge_model.NutritionDatum> nutritionData = [];
    for (user_nutrition_model.Datum item in listUserNutrition) {
      nutritionData.add(
        store_user_challenge_model.NutritionDatum(
          nutritionId: item.nutritionId,
        ),
      );
    }
    userStoreNutrition.value = store_user_challenge_model.StoreUserChallengeModel(
      date: changeDateStringFormat(date: DateTime.now().toString(), format: DateFormatHelper.dmyFormat)
          .replaceAll(".", "-"),
      nutritionData: nutritionData,
    );
  }

  selected_nutrition_data.Nutrition _getNutritionNames(List<String> color) {
    var nutrition = listUserNutrition
        .where((item) => color.contains(item.nutrition?.color?.toLowerCase()))
        .map((item) => item.nutrition?.name)
        .join(",");
    var status = "";
    var statusBuilder = listUserNutrition
        .where((item) => color.contains(item.nutrition?.color?.toLowerCase()))
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
        .where((item) => color.contains(item.nutrition?.color?.toLowerCase()))
        .map((item) => item.nutrition?.id ?? -1)
        .toList();

    return selected_nutrition_data.Nutrition(
      nutritionName: nutrition,
      status: status,
      nutritionId: nutritionId,
    );
  }

  submitUserWeeklySummary() async {
    showLoader();
    var response = await Repository.instance.storeUserChallengeNutritionApi(
      userNutrition: userStoreNutrition.value,
    );
    hideLoader();
    if (response is Success) {
      var result = emptyModelFromJson(response.response.toString());
      showToast(msg: result.message ?? "");
      await fetchUserNutrition();
    } else if (response is Failure) {
      showToast(msg: "${response.errorResponse ?? ""}");
    }
  }
}

class DateUtils {
  static DateTime? findMostRecentDate(List<user_vegetable_challenge_model.Datum> userShowAllNutrition) {
    try {
      List<DateTime> dates =
          userShowAllNutrition.map((element) => element.date).whereType<DateTime>().toList();

      if (dates.isEmpty) {
        return null;
      }

      dates.sort((a, b) => b.compareTo(a));
      return dates.first;
    } catch (e) {
      // Log the error or handle it as needed
      return null;
    }
  }
}
