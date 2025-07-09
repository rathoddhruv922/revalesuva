import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:revalesuva/model/empty_model/empty_model.dart';
import 'package:revalesuva/model/store/store_model.dart' as store_model;
import 'package:revalesuva/repository/repository.dart';
import 'package:revalesuva/services/api_status.dart';
import 'package:revalesuva/utils/helper_method.dart';

class StoreFavoritesViewModel extends GetxController {
  var listUserStoreFavourite = <store_model.Datum>[].obs;
  var perPage = "10";
  var currentPage = 1.obs;
  var isStoreLoading = false.obs;
  var total = 1.obs;
  var isStoreLoadMore = false.obs;
  ScrollController storeScrollController = ScrollController();

  setupScrollController() {
    storeScrollController = ScrollController();
    storeScrollController.addListener(() {
      if (storeScrollController.position.pixels == storeScrollController.position.maxScrollExtent &&
          !isStoreLoadMore.value) {
        loadMore();
      }
    });
  }

  void loadMore() {
    if (listUserStoreFavourite.length < total.value) {
      currentPage.value++;
      fetchFavouriteStore(
        isLoadMore: true,
      );
    }
  }

  fetchFavouriteStore({
    bool isLoadMore = false,
  }) async {
    if (isLoadMore) {
      isStoreLoadMore.value = true;
    } else {
      isStoreLoading.value = true;
    }

    var response = await Repository.instance.getFavouriteStoreProductApi(
      perPage: perPage,
      page: currentPage.value.toString(),
    );

    if (response is Success) {
      var result = store_model.storeModelFromJson(response.response.toString());
      if (isLoadMore) {
        listUserStoreFavourite.addAll(result.data?.data ?? <store_model.Datum>[]);
      } else {
        listUserStoreFavourite.value = result.data?.data ?? [];
      }
      total.value = result.data?.totalItems ?? 1;
    } else if (response is Failure) {
      listUserStoreFavourite.clear();
    }
    if (isLoadMore) {
      isStoreLoadMore.value = false;
    } else {
      isStoreLoading.value = false;
    }
  }

  Future<bool> addRemoveStoreFavourite({required int storeProductId}) async {
    showLoader();
    var response = await Repository.instance.addStoreFavouriteRecipesApi(
      storeProductId: storeProductId,
    );
    hideLoader();
    if (response is Success) {
      if (response.code == 200) {
        var result = emptyModelFromJson(response.response.toString());
        showToast(msg: result.message ?? "");
        return true;
      }
    } else if (response is Failure) {
      showToast(msg: "${response.errorResponse ?? ""}");
    }
    return false;
  }
}
