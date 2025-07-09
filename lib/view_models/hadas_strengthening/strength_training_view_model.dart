import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:revalesuva/model/hadas_strengthening/strength_training_model.dart'
    as strength_training_model;
import 'package:revalesuva/repository/repository.dart';
import 'package:revalesuva/services/api_status.dart';

class StrengthTrainingViewModel extends GetxController {
  var listStrengthTraining = <strength_training_model.Datum>[].obs;
  var isLoading = false.obs;
  var perPage = "10";
  var currentPage = 1.obs;
  var total = 1.obs;
  var isLoadingMore = false.obs;


  fetchStrengthTraining({bool isLoadMore = false}) async {
    if (isLoadMore) {
      isLoadingMore.value = true;
    } else {
      isLoading.value = true;
    }
    var response = await Repository.instance.getStrengthTrainingApi(
      perPage: perPage,
      page: currentPage.value.toString(),
    );
    if (response is Success) {
      var result = strength_training_model.strengthTrainingModelFromJson(
        response.response.toString(),
      );
      if (isLoadMore) {
        listStrengthTraining.addAll(result.data?.data ?? <strength_training_model.Datum>[]);
      } else {
        listStrengthTraining.value = result.data?.data ?? [];
      }
      total.value = result.data?.totalItems ?? 1;
    } else if (response is Failure) {
      listStrengthTraining.clear();
    }
    if (isLoadMore) {
      isLoadingMore.value = false;
    } else {
      isLoading.value = false;
    }
  }
}
