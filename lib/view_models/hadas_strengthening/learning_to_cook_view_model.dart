import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:revalesuva/model/hadas_strengthening/learning_to_cook_model.dart'
    as learning_to_cook_model;
import 'package:revalesuva/repository/repository.dart';
import 'package:revalesuva/services/api_status.dart';

class LearningToCookViewModel extends GetxController {
  var listCook = <learning_to_cook_model.Datum>[].obs;
  var perPage = "10";
  var currentPage = 1.obs;
  var total = 1.obs;

  var isLoading = false.obs;
  var isLoadingMore = false.obs;


  fetchCook({bool isLoadMore = false}) async {
    if (isLoadMore) {
      isLoadingMore.value = true;
    } else {
      isLoading.value = true;
    }
    var response = await Repository.instance.getLearningCookApi(
      perPage: perPage,
      page: currentPage.value.toString(),
    );
    if (response is Success) {
      var result = learning_to_cook_model.learningToCookModelFromJson(response.response.toString());
      if (isLoadMore) {
        listCook.addAll(result.data?.data ?? <learning_to_cook_model.Datum>[]);
      } else {
        listCook.value = result.data?.data ?? [];
      }
      total.value = result.data?.totalItems ?? 1;
    } else if (response is Failure) {
      listCook.clear();
    }
    if (isLoadMore) {
      isLoadingMore.value = false;
    } else {
      isLoading.value = false;
    }
  }
}
