import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:revalesuva/model/empty_model/empty_model.dart';
import 'package:revalesuva/model/product_and_recipes/recipe_model.dart' as recipe_model;
import 'package:revalesuva/repository/repository.dart';
import 'package:revalesuva/services/api_status.dart';
import 'package:revalesuva/utils/helper_method.dart';

class RecipeFavoritesViewModel extends GetxController {
  var listUserFavourite = <recipe_model.Datum>[].obs;
  var perPage = "10";
  var currentPage = 1.obs;
  var isRecipeLoading = false.obs;
  var total = 1.obs;
  var isRecipeLoadMore = false.obs;
  ScrollController recipeScrollController = ScrollController();

  setupScrollController() {
    recipeScrollController = ScrollController();
    recipeScrollController.addListener(() {
      if (recipeScrollController.position.pixels == recipeScrollController.position.maxScrollExtent &&
          !isRecipeLoadMore.value) {
        loadMore();
      }
    });
  }

  void loadMore() {
    if (listUserFavourite.length < total.value) {
      currentPage.value++;
      fetchFavouriteRecipe(
        isLoadMore: true,
      );
    }
  }

  fetchFavouriteRecipe({
    bool isLoadMore = false,
  }) async {
    if (isLoadMore) {
      isRecipeLoadMore.value = true;
    } else {
      isRecipeLoading.value = true;
    }

    var response = await Repository.instance.getFavouriteRecipesApi(
      perPage: perPage,
      page: currentPage.value.toString(),
    );

    if (response is Success) {
      var result = recipe_model.recipeModelFromJson(response.response.toString());
      if (isLoadMore) {
        listUserFavourite.addAll(result.data?.data ?? <recipe_model.Datum>[]);
      } else {
        listUserFavourite.value = result.data?.data ?? [];
      }
      total.value = result.data?.totalItems ?? 1;
    } else if (response is Failure) {
      listUserFavourite.clear();
    }
    if (isLoadMore) {
      isRecipeLoadMore.value = false;
    } else {
      isRecipeLoading.value = false;
    }
  }

  Future<bool> addRemoveFavourite({required int recipeId}) async {
    showLoader();
    var response = await Repository.instance.addFavouriteRecipesApi(recipeId: recipeId);
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
