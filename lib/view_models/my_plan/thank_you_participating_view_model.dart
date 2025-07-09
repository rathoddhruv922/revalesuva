import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:revalesuva/model/empty_model/empty_model.dart';
import 'package:revalesuva/model/my_plan/plans/all_plan_model.dart' as all_plan_model;
import 'package:revalesuva/repository/repository.dart';
import 'package:revalesuva/services/api_status.dart';
import 'package:revalesuva/utils/helper_method.dart';
import 'package:revalesuva/utils/strings_constant.dart';

class ThankYouParticipatingViewModel extends GetxController {
  var isLoading = false.obs;
  var selectedPlan = "".obs;
  var txtDetail = TextEditingController();
  var listPlan = <all_plan_model.Datum>[].obs;

  getAllPlanList() async {
    var response = await Repository.instance.getAllPlansApi();
    if (response is Success) {
      var result = all_plan_model.allPlanModelFromJson(response.response.toString());
      listPlan.assignAll(result.data ?? []);
    } else if (response is Failure) {
      listPlan.clear();
      showToast(msg: "${response.errorResponse ?? ""}");
    }
  }

  Future<bool> submitUserAdvice() async {
    if (selectedPlan.value.isEmpty) {
      showToast(msg: StringConstants.pleaseSelectPlan);
    } else {
      showLoader();
      var planId = listPlan.firstWhereOrNull((element) => element.name == selectedPlan.value)?.id ?? "";
      var response = await Repository.instance.createUserAdviceApi(
        planId: "$planId",
        adviceDetail: txtDetail.text,
      );
      hideLoader();
      if (response is Success) {
        var result = emptyModelFromJson(response.response.toString());
        selectedPlan.value = "";
        txtDetail.clear();
        return true;
      } else if (response is Failure) {
        showToast(msg: "${response.errorResponse ?? ""}");
      }
    }
    return false;
  }
}
