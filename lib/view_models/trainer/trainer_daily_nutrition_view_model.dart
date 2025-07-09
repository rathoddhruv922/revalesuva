import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:revalesuva/model/tools/nutrition_model/selected_nutrition_data.dart'
    as selected_nutrition_data;
import 'package:revalesuva/model/trainer/daily_nutrition/customer_daily_nutrition_model.dart'
    as customer_daily_nutrition_model;
import 'package:revalesuva/repository/repository.dart';
import 'package:revalesuva/services/api_status.dart';
import 'package:revalesuva/utils/date_format_helper.dart';
import 'package:revalesuva/utils/helper_method.dart';

class TrainerDailyNutritionViewModel extends GetxController {
  var txtDate = TextEditingController().obs;
  var isLoading = false.obs;
  var listDailyNutrition = <customer_daily_nutrition_model.Datum>[].obs;
  var userSelectedData = selected_nutrition_data.SelectedNutritionData().obs;

  getCustomerDailyReport({required String customerId}) async {

    var response = await Repository.instance.getCustomerDailyNutritionData(
      date: changeDateStringFormat(date: txtDate.value.text, format: DateFormatHelper.ymdFormat),
      customerId: customerId,
    );

    if (response is Success) {
      var result = customer_daily_nutrition_model
          .customerDailyNutritionModelFromJson(response.response.toString());
      listDailyNutrition.assignAll(result.data ?? []);
      selectedNutritionShow();
    } else if (response is Failure) {
      listDailyNutrition.clear();
      showToast(msg: "${response.errorResponse ?? ""}");
    }
  }

  selectedNutritionShow() {
    userSelectedData.value = selected_nutrition_data.SelectedNutritionData(
      breakfast: _getNutritionType("breakfast"),
      lunch: _getNutritionType("lunch"),
      dinner: _getNutritionType("dinner"),
      snacks: _getNutritionType("snacks"),
    );

    print(userSelectedData.value);
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
    var nutrition = listDailyNutrition
        .where((item) =>
            item.nutrition?.nutritionType?.toLowerCase() == nutritionType && item.foodType == mealType)
        .map((item) => item.nutrition?.name)
        .join(",");
    var status = "";
    var statusBuilder = listDailyNutrition
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

    List<int> nutritionId = listDailyNutrition
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
}
