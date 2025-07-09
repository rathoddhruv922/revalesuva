import 'package:get/get.dart';
import 'package:revalesuva/model/tools/my_achievements/my_achievements_model.dart'
    as my_achievements_model;
import 'package:revalesuva/repository/repository.dart';
import 'package:revalesuva/services/api_status.dart';
import 'package:revalesuva/utils/helper_method.dart';

class MyAchievementsViewModel extends GetxController {
  var listWeightAchievement = <my_achievements_model.Datum>[].obs;
  var listMeasurementsAchievement = <my_achievements_model.Datum>[].obs;
  var listFastingAchievement = <my_achievements_model.Datum>[].obs;
  var listDailyNutrition = <my_achievements_model.Datum>[].obs;
  var listTasks = <my_achievements_model.Datum>[].obs;
  var isLoading = false.obs;

  getAllAchievements() async {
    isLoading.value = true;
    var response = await Repository.instance.getMyAchievement();
    isLoading.value = false;
    if (response is Success) {
      var result = my_achievements_model.myAchievementsModelFromJson(response.response.toString());
      listWeightAchievement.clear();
      listMeasurementsAchievement.clear();
      listFastingAchievement.clear();
      listDailyNutrition.clear();
      listTasks.clear();
      for (my_achievements_model.Datum item in result.data ?? []) {
        if (item.successType?.toLowerCase() == "weight") {
          listWeightAchievement.add(item);
        } else if (item.successType?.toLowerCase() == "hip" ||
            item.successType?.toLowerCase() == "waist" ||
            item.successType?.toLowerCase() == "chest" ) {
          listMeasurementsAchievement.add(item);
        } else if (item.successType?.toLowerCase() == "fasting") {
          listFastingAchievement.add(item);
        } else if (item.successType?.toLowerCase() == "daily nutrition") {
          listDailyNutrition.add(item);
        } else if (item.successType?.toLowerCase() == "tasks") {
          listTasks.add(item);
        }
      }
      listWeightAchievement.refresh();
      listMeasurementsAchievement.refresh();
      listFastingAchievement.refresh();
      listDailyNutrition.refresh();
      listTasks.refresh();
    } else if (response is Failure) {
      showToast(msg: "${response.errorResponse ?? ""}");
    }
  }
}
