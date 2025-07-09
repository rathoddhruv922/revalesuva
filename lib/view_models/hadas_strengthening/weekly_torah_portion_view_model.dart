import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:revalesuva/model/hadas_strengthening/weekly_torah_portion_model.dart'
    as weekly_torah_portion_model;
import 'package:revalesuva/repository/repository.dart';
import 'package:revalesuva/services/api_status.dart';

class WeeklyTorahPortionViewModel extends GetxController {
  var listWeeklyPortion = <weekly_torah_portion_model.Datum>[].obs;
  var isLoading = false.obs;
  var perPage = "10";
  var currentPage = 1.obs;
  var total = 1.obs;
  var isLoadingMore = false.obs;



  fetchWeeklyPortion({bool isLoadMore = false}) async {
    if (isLoadMore) {
      isLoadingMore.value = true;
    } else {
      isLoading.value = true;
    }
    var response = await Repository.instance.getWeeklyPortionApi(
      perPage: perPage,
      page: currentPage.value.toString(),
    );
    if (response is Success) {
      var result =
          weekly_torah_portion_model.weeklyTorahPortionModelFromJson(response.response.toString());
      if (isLoadMore) {
        listWeeklyPortion.addAll(result.data?.data ?? <weekly_torah_portion_model.Datum>[]);
      } else {
        listWeeklyPortion.value = result.data?.data ?? [];
      }
      total.value = result.data?.totalItems ?? 1;
    } else if (response is Failure) {
      listWeeklyPortion.clear();
    }
    if (isLoadMore) {
      isLoadingMore.value = false;
    } else {
      isLoading.value = false;
    }
  }
}
