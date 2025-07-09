import 'package:get/get.dart';
import 'package:revalesuva/model/tools/nutrition_model/user_nutrition_model.dart'
    as user_nutrition_model;
import 'package:revalesuva/model/tools/vegetable_challenge/store_user_challenge_model.dart'
    as store_user_challenge_model;
import 'package:revalesuva/model/tools/vegetable_challenge/user_vegetable_challenge_model.dart'
    as user_vegetable_challenge_model;
import 'package:revalesuva/repository/repository.dart';
import 'package:revalesuva/services/api_status.dart';
import 'package:revalesuva/utils/helper_method.dart';

class TrainerVegetableChallengeViewModel extends GetxController {
  var userShowAllNutrition = <user_vegetable_challenge_model.Datum>[].obs;
  var userShowROPNutrition = <user_vegetable_challenge_model.Datum>[].obs;
  var userShowYWNutrition = <user_vegetable_challenge_model.Datum>[].obs;
  var userShowGNutrition = <user_vegetable_challenge_model.Datum>[].obs;
  var isLoading = false.obs;
  var userStoreNutrition = store_user_challenge_model.StoreUserChallengeModel().obs;
  var listUserNutrition = <user_nutrition_model.Datum>[].obs;
  var lastUpdateDayOfWeek = 0.obs;
  var isAllowToAttempt = false.obs;

  fetchUserNutrition({required String customerId}) async {
    var response = await Repository.instance.getVegetableChallengeNutritionByCustomerId(
      customerId: customerId,
    );
    if (response is Success) {
      var result = user_vegetable_challenge_model
          .userVegetableChallengeModelFromJson(response.response.toString());
      _clearUserLists();
      userShowAllNutrition.assignAll(result.data ?? []);
      for (user_vegetable_challenge_model.Datum item in result.data ?? []) {
        _addItemToUserList(item);
      }

      lastUpdateDayOfWeek.value = DateUtils.findMostRecentDate(userShowAllNutrition)?.weekday ?? 0;
    } else if (response is Failure) {
      showToast(msg: "${response.errorResponse ?? ""}");
    }
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
      return null;
    }
  }
}
