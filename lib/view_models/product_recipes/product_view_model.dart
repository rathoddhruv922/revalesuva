import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:revalesuva/generated/assets.dart';
import 'package:revalesuva/model/product_and_recipes/category_model.dart' as category_model;
import 'package:revalesuva/model/product_and_recipes/product_model.dart' as product_model;
import 'package:revalesuva/repository/repository.dart';
import 'package:revalesuva/services/api_status.dart';
import 'package:revalesuva/utils/helper_method.dart';
import 'package:revalesuva/utils/strings_constant.dart';

class ProductViewModel extends GetxController {
  var listCategory = <category_model.Datum>[].obs;
  var listProduct = <product_model.Datum>[].obs;
  var perPage = "10";
  var currentPage = 1.obs;
  var isCategoryLoading = false.obs;
  var isProductLoading = false.obs;
  var total = 1.obs;
  ScrollController scrollController = ScrollController();
  var isLoadingMore = false.obs;
  var selectedCategory = category_model.Datum().obs;
  var isRecommended = false.obs;

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
      _searchFuture = fetchProduct();
    });
  }

  onCategorySelect({required int index}) async {


    if (listCategory[index].isSelected == true) {
      listCategory[index].isSelected = false;
      selectedCategory.value = category_model.Datum();
    } else {
      for (var i = 0; i < listCategory.length; i++) {
        listCategory[i].isSelected = false;
      }
      listCategory[index].isSelected = true;
      selectedCategory.value = listCategory[index];
    }

    listCategory.refresh();
    currentPage.value = 1;

    fetchProduct();
  }

  onDefaultSelect({required bool value}) {
    listCategory.refresh();
    isRecommended.value = value;
    currentPage.value = 1;
    fetchProduct();
  }

  fetchAllCategories() async {
    isCategoryLoading.value = true;
    var response = await Repository.instance.getAllProductCategoriesApi();
    if (response is Success) {
      var result = category_model.categoryModelFromJson(response.response.toString());

      var allProduct = category_model.Datum(
        id: -1,
        updatedAt: "",
        createdAt: "",
        isActive: 1,
        name: StringConstants.allProducts,
        image: Assets.iconsIcAllProduct,
        isSelected: true,
      );
      var recommended = category_model.Datum(
        id: -2,
        updatedAt: "",
        createdAt: "",
        isActive: 1,
        name: StringConstants.recommended,
        image: Assets.iconsIcRecipe,
      );
      listCategory.assignAll([allProduct, recommended, ...result.data ?? []]);
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
    if (listProduct.length < total.value) {
      currentPage.value++;
      fetchProduct(isLoadMore: true);
    }
  }

  fetchProduct({
    bool isLoadMore = false,
  }) async {
    if (isLoadMore) {
      isLoadingMore.value = true;
    } else {
      isProductLoading.value = true;
    }

    var response = await Repository.instance.getProductsApi(
      perPage: perPage,
      page: currentPage.value.toString(),
      categoryId: selectedCategory.value.id,
      recommended: isRecommended.value,
      search: txtSearch.text,
    );

    if (response is Success) {
      var result = product_model.productModelFromJson(response.response.toString());
      if (isLoadMore) {
        listProduct.addAll(result.data?.data ?? <product_model.Datum>[]);
      } else {
        listProduct.value = result.data?.data ?? [];
      }
      total.value = result.data?.totalItems ?? 1;
    } else if (response is Failure) {
      listProduct.clear();
    }
    if (isLoadMore) {
      isLoadingMore.value = false;
    } else {
      isProductLoading.value = false;
    }
  }
}
