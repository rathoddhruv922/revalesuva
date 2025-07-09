import 'package:get/get.dart';
import 'package:revalesuva/model/tools/nutritional_information/nutritional_information_model.dart'
    as nutritional_information_model;
import 'package:revalesuva/repository/repository.dart';
import 'package:revalesuva/services/api_status.dart';
import 'package:revalesuva/utils/helper_method.dart';

class NutritionalInformationViewModel extends GetxController {
  var listNutritional = <nutritional_information_model.Datum>[].obs;
  var isLoading = false.obs;

  fetchNutritionalInformation() async {
    isLoading.value = true;
    var response = await Repository.instance.getNutritionalInformationApi();
    isLoading.value = false;
    if (response is Success) {
      var result = nutritional_information_model.nutritionalInformationModelFromJson(response.response.toString());
      listNutritional.assignAll(result.data ?? []);
    } else if (response is Failure) {
      showToast(msg: "${response.errorResponse ?? ""}");
    }
  }

  List<nutritional_information_model.Datum> getInnerList({required int nutritionId}) {
    return listNutritional.where((element) => element.id != nutritionId).toList();
  }
}
