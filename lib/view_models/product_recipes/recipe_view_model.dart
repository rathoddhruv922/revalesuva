import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:revalesuva/generated/assets.dart';
import 'package:revalesuva/model/product_and_recipes/category_model.dart' as category_model;
import 'package:revalesuva/model/product_and_recipes/filter_tags_model.dart' as filter_tags_model;
import 'package:revalesuva/model/product_and_recipes/recipe_model.dart' as recipe_model;
import 'package:revalesuva/repository/repository.dart';
import 'package:revalesuva/services/api_status.dart';
import 'package:revalesuva/utils/helper_method.dart';
import 'package:revalesuva/utils/strings_constant.dart';

class RecipeViewModel extends GetxController {
  var listCategory = <category_model.Datum>[].obs;
  var listRecipe = <recipe_model.Datum>[].obs;
  var perPage = "10";
  var currentPage = 1.obs;
  var isCategoryLoading = false.obs;
  var isRecipeLoading = false.obs;
  var total = 1.obs;
  ScrollController scrollController = ScrollController();
  var isLoadingMore = false.obs;
  var selectedCategory = category_model.Datum().obs;
  var selectedTags = <String>[].obs;
  var tagList = <String>[].obs;
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
      _searchFuture = fetchRecipe();
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
    fetchRecipe();
  }

  onFilterSelect({List<String>? value}) {
    if(value?.isNotEmpty ?? false){
      selectedTags.assignAll(value ?? []);
      selectedTagForApi.value = selectedTags.join(",");
    }else{
      selectedTagForApi.value = "";
    }
    fetchRecipe();
  }

  fetchAllCategories() async {
    isCategoryLoading.value = true;
    var response = await Repository.instance.getAllRecipeCategoriesApi();
    if (response is Success) {
      var result = category_model.categoryModelFromJson(response.response.toString());
      var defaultCategory = category_model.Datum(
        id: -1,
        updatedAt: "",
        createdAt: "",
        isActive: 1,
        name: StringConstants.allRecipes,
        image: Assets.iconsIcAllProduct,
        isSelected: true,
      );

      listCategory.assignAll([defaultCategory, ...result.data ?? []]);
    } else if (response is Failure) {
      showToast(msg: "${response.errorResponse ?? ""}");
    }
    isCategoryLoading.value = false;
  }

  fetchFilterTags() async {
    var response = await Repository.instance.getAllFilterTagsApi();
    if (response is Success) {
      var result = filter_tags_model.filterTagsModelFromJson(response.response.toString());
      tagList.assignAll(result.data?.tags ?? []);
      tagList.refresh();
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
    if (listRecipe.length < total.value) {
      currentPage.value++;

      fetchRecipe(isLoadMore: true);
    }
  }

  fetchRecipe({
    bool isLoadMore = false,
  }) async {
    if (isLoadMore) {
      isLoadingMore.value = true;
    } else {
      isRecipeLoading.value = true;
    }

    var response = await Repository.instance.getRecipesApi(
      perPage: perPage,
      page: currentPage.value.toString(),
      categoryId: selectedCategory.value.id,
      tags: selectedTagForApi.value,
      search: txtSearch.text,
    );

    if (response is Success) {
      var result = recipe_model.recipeModelFromJson(response.response.toString());
      if (isLoadMore) {
        listRecipe.addAll(result.data?.data ?? <recipe_model.Datum>[]);
      } else {
        listRecipe.value = result.data?.data ?? [];
      }
      total.value = result.data?.totalItems ?? 1;
    } else if (response is Failure) {
      listRecipe.clear();
    }
    if (isLoadMore) {
      isLoadingMore.value = false;
    } else {
      isRecipeLoading.value = false;
    }
  }
}
