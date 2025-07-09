import 'package:get/get.dart';
import 'package:revalesuva/model/my_stars/stars_model.dart' as stars_model;
import 'package:revalesuva/repository/repository.dart';
import 'package:revalesuva/services/api_status.dart';
import 'package:revalesuva/utils/helper_method.dart';

class MyStarsViewModel extends GetxController {
  var listStars = <stars_model.Star>[].obs;
  var totalEarnedStar = 0.obs;
  var isLoading = false.obs;

  fetchStars() async {
    isLoading.value = true;
    var response = await Repository.instance.getMyStarsApi();
    isLoading.value = false;
    if (response is Success) {
      var result = stars_model.starsModelFromJson(response.response.toString());
      listStars.assignAll(result.data?.stars ?? []);
      totalEarnedStar.value = result.data?.getUserAchievements ?? 0;
    } else if (response is Failure) {
      showToast(msg: "${response.errorResponse ?? ""}");
    }
  }
}
