import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:revalesuva/model/my_plan/libraries/content_libraries_model.dart' as content_libraries_model;
import 'package:revalesuva/repository/repository.dart';
import 'package:revalesuva/services/api_status.dart';
import 'package:revalesuva/model/my_plan/plans/user_plan_model.dart' as user_plan_model;


class ContentLibrariesViewModel extends GetxController {
  var listContent = <content_libraries_model.Datum>[].obs;
  var perPage = "10";
  var currentPage = 1.obs;
  var isLoading = false.obs;
  var total = 1.obs;
  ScrollController scrollController = ScrollController();
  var isLoadingMore = false.obs;
  var txtSearch = TextEditingController();
  Timer? debounce;
  Future<void>? _searchFuture;
  var planId = "".obs;

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
      _searchFuture = fetchContentLibraries();
    });
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
    if (listContent.length < total.value) {
      currentPage.value++;
      fetchContentLibraries(isLoadMore: true);
    }
  }

  fetchContentLibraries({
    bool isLoadMore = false,
  }) async {
    if (isLoadMore) {
      isLoadingMore.value = true;
    } else {
      isLoading.value = true;
    }

    var response = await Repository.instance.getContentLibrariesByPlan(
      perPage: perPage,
      page: currentPage.value.toString(),
      search: txtSearch.text,
      planId: planId.value,
    );

    if (response is Success) {
      var result = content_libraries_model.contentLibrariesModelFromJson(response.response.toString());
      if (isLoadMore) {
        listContent.addAll(result.data?.data ?? <content_libraries_model.Datum>[]);
      } else {
        listContent.value = result.data?.data ?? [];
      }
      total.value = result.data?.totalItems ?? 1;
    } else if (response is Failure) {
      listContent.clear();
    }
    if (isLoadMore) {
      isLoadingMore.value = false;
    } else {
      isLoading.value = false;
    }
  }
}
