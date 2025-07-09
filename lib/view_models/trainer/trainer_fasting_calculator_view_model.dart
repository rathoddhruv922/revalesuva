import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:revalesuva/model/trainer/fasting_calculator/fasting_calculator_model.dart'
    as fasting_calculator_model;
import 'package:revalesuva/repository/repository.dart';
import 'package:revalesuva/services/api_status.dart';
import 'package:revalesuva/utils/helper_method.dart';

class TrainerFastingCalculatorViewModel extends GetxController {
  var isLoading = false.obs;
  var listFasting = <fasting_calculator_model.Datum>[].obs;
  var perPage = "20";
  var currentPage = 1.obs;
  var isLoadingMore = false.obs;
  var total = 1.obs;
  ScrollController scrollController = ScrollController();

  setupScrollController({required String customerId}) {
    scrollController = ScrollController();
    scrollController.addListener(() {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent &&
          !isLoadingMore.value) {
        loadMore(customerId: customerId);
      }
    });
  }

  void loadMore({required String customerId}) {
    if (listFasting.length < total.value) {
      currentPage.value++;
      getHistoryFastingData(
        isLoadMore: true,
        customerId: customerId,
      );
    }
  }

  getHistoryFastingData({bool isLoadMore = false, required String customerId}) async {
    try {
      if (isLoadMore) {
        isLoadingMore.value = true;
      } else {
        isLoading.value = true;
      }
      var response = await Repository.instance.getFastingCalculatorApi(
        customerId: customerId,
      );

      if (response is Success) {
        var result =
            fasting_calculator_model.fastingCalculatorModelFromJson(response.response.toString());
        if (isLoadMore) {
          listFasting.addAll(result.data?.data ?? <fasting_calculator_model.Datum>[]);
        } else {
          listFasting.value = result.data?.data ?? [];
        }
        total.value = result.data?.totalItems ?? 1;
      } else if (response is Failure) {
        showToast(msg: "${response.errorResponse ?? ""}");
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      if (isLoadMore) {
        isLoadingMore.value = false;
      } else {
        isLoading.value = false;
      }
    }
  }
}
