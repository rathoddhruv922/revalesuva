import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:revalesuva/model/hadas_strengthening/flexibility_category_model.dart'
    as flexibility_category_model;
import 'package:revalesuva/model/hadas_strengthening/flexibility_model.dart' as flexibility_model;
import 'package:revalesuva/repository/repository.dart';
import 'package:revalesuva/services/api_status.dart';

class FlexibilityViewModel extends GetxController {
  var listCategory = <flexibility_category_model.Datum>[].obs;
  var categoryPerPage = "10";
  var categoryCurrentPage = 1.obs;
  var categoryTotal = 1.obs;

  var listFlexibility = <flexibility_model.Datum>[].obs;
  var flexibilityPerPage = "10";
  var flexibilityCurrentPage = 1.obs;
  var flexibilityTotal = 1.obs;

  var isLoadingCategory = false.obs;
  var isLoadingItem = false.obs;
  var isLoadingMore = false.obs;

  // setupFlexibilityScrollController({required String id}) {
  //   flexibilityScrollController.dispose();
  //   flexibilityScrollController = ScrollController();
  //
  //   flexibilityScrollController.addListener(() {
  //     if (flexibilityScrollController.position.pixels ==
  //             flexibilityScrollController.position.maxScrollExtent &&
  //         !isLoadingMore.value) {
  //       loadMoreFlexibility(id: id);
  //     }
  //   });
  // }

  // void loadMoreFlexibility({required String id}) {
  //   if (listFlexibility.length < flexibilityTotal.value) {
  //     flexibilityCurrentPage.value++;
  //     fetchFlexibility(isLoadMore: true, categoryId: id);
  //   }
  // }

  fetchFlexibility({bool isLoadMore = false, required String categoryId}) async {
    if (isLoadMore) {
      isLoadingMore.value = true;
    } else {
      isLoadingItem.value = true;
    }

    var response = await Repository.instance.getFlexibilityApi(
      perPage: flexibilityPerPage,
      page: flexibilityCurrentPage.value.toString(),
      categoryId: categoryId,
    );

    if (response is Success) {
      var result = flexibility_model.flexibilityModelFromJson(response.response.toString());
      if (isLoadMore) {
        listFlexibility.addAll(result.data?.data ?? <flexibility_model.Datum>[]);
      } else {
        listFlexibility.value = result.data?.data ?? [];
      }
      flexibilityTotal.value = result.data?.totalItems ?? 1;
    } else if (response is Failure) {
      listFlexibility.clear();
    }
    if (isLoadMore) {
      isLoadingMore.value = false;
    } else {
      isLoadingItem.value = false;
    }
  }


  fetchCategory({bool isLoadMore = false}) async {
    if (isLoadMore) {
      isLoadingMore.value = true;
    } else {
      isLoadingCategory.value = true;
    }

    var response = await Repository.instance.getFlexibilityCategoryApi(
      perPage: categoryPerPage,
      page: categoryCurrentPage.value.toString(),
    );

    if (response is Success) {
      var result =
          flexibility_category_model.flexibilityCategoryModelFromJson(response.response.toString());
      if (isLoadMore) {
        listCategory.addAll(result.data?.data ?? <flexibility_category_model.Datum>[]);
      } else {
        listCategory.value = result.data?.data ?? [];
      }
      categoryTotal.value = result.data?.totalItems ?? 1;
    } else if (response is Failure) {
      listCategory.clear();
    }
    if (isLoadMore) {
      isLoadingMore.value = false;
    } else {
      isLoadingCategory.value = false;
    }
  }
}
