import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:revalesuva/generated/assets.dart';
import 'package:revalesuva/model/product_and_recipes/category_model.dart' as category_model;
import 'package:revalesuva/model/store/store_model.dart' as store_model;
import 'package:revalesuva/repository/repository.dart';
import 'package:revalesuva/services/api_status.dart';
import 'package:revalesuva/utils/helper_method.dart';
import 'package:revalesuva/utils/strings_constant.dart';

class StoreViewModel extends GetxController {
  var listCategory = <category_model.Datum>[].obs;
  var listStoreProduct = <store_model.Datum>[].obs;
  var perPage = "10";
  var currentPage = 1.obs;
  var isCategoryLoading = false.obs;
  var isStoreProductLoading = false.obs;
  var total = 1.obs;
  ScrollController scrollController = ScrollController();
  var isLoadingMore = false.obs;
  var selectedCategory = category_model.Datum().obs;
  var selectedTags = "".obs;
  var selectedTagForApi = "".obs;

  var txtSearch = TextEditingController();
  Timer? debounce;
  Future<void>? _searchFuture;

  @override
  void onInit() {
    super.onInit();
    txtSearch.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    if (debounce?.isActive ?? false) debounce?.cancel();
    debounce = Timer(const Duration(seconds: 1), () {
      if (_searchFuture != null) {
        _searchFuture = null;
      }
      currentPage.value = 1;
      _searchFuture = fetchStoreProduct();
    });
  }

  onCategorySelect({required int index}) async {
    for (var i = 0; i < listCategory.length; i++) {
      listCategory[i].isSelected = false;
    }
    selectedCategory.value = listCategory[index];
    listCategory[index].isSelected = true;
    listCategory.refresh();
    currentPage.value = 1;
    fetchStoreProduct();
  }

  onFilterSelect({String? value}) {
    if (value == StringConstants.mostRelevant) {
      selectedTagForApi.value = "relevant";
    } else if (value == StringConstants.mostPopular) {
      selectedTagForApi.value = "popular";
    } else if (value == StringConstants.priceHighToLow) {
      selectedTagForApi.value = "high_to_low";
    } else if (value == StringConstants.priceLowToHigh) {
      selectedTagForApi.value = "low_to_high";
    }
    selectedTags.value = value ?? "";
    fetchStoreProduct();
  }

  fetchAllCategories() async {
    isCategoryLoading.value = true;
    var response = await Repository.instance.getAllStoreCategoriesApi();
    if (response is Success) {
      var result = category_model.categoryModelFromJson(response.response.toString());
      var defaultCategory = category_model.Datum(
        id: -1,
        updatedAt: "",
        createdAt: "",
        isActive: 1,
        name: StringConstants.allProducts,
        image: Assets.iconsIcStoreAllProducts,
        isSelected: true,
      );

      listCategory.assignAll([defaultCategory, ...result.data ?? []]);
    } else if (response is Failure) {
      showToast(msg: "${response.errorResponse ?? ""}");
    }
    isCategoryLoading.value = false;
  }

  setupScrollController() {
    scrollController = ScrollController();
    scrollController.addListener(() {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent &&
          !isLoadingMore.value) {
        loadMore();
      }
    });
  }

  void loadMore() {
    if (listStoreProduct.length < total.value) {
      currentPage.value++;
      fetchStoreProduct(isLoadMore: true);
    }
  }

  fetchStoreProduct({
    bool isLoadMore = false,
  }) async {
    if (isLoadMore) {
      isLoadingMore.value = true;
    } else {
      isStoreProductLoading.value = true;
    }

    var response = await Repository.instance.getStoreProductApi(
      perPage: perPage,
      page: currentPage.value.toString(),
      categoryId: selectedCategory.value.id,
      sortBy: selectedTagForApi.value,
      search: txtSearch.text,
    );

    if (response is Success) {
      var result = store_model.storeModelFromJson(response.response.toString());
      if (isLoadMore) {
        listStoreProduct.addAll(result.data?.data ?? <store_model.Datum>[]);
      } else {
        listStoreProduct.value = result.data?.data ?? [];
      }
      total.value = result.data?.totalItems ?? 1;
    } else if (response is Failure) {
      listStoreProduct.clear();
    }
    if (isLoadMore) {
      isLoadingMore.value = false;
    } else {
      isStoreProductLoading.value = false;
    }
  }
}
