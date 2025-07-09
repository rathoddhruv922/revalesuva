import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:revalesuva/model/empty_model/empty_model.dart';
import 'package:revalesuva/model/general_message/general_message_model.dart' as general_message_model;
import 'package:revalesuva/repository/repository.dart';
import 'package:revalesuva/services/api_status.dart';
import 'package:revalesuva/utils/helper_method.dart';

class GeneralMessageViewModel extends GetxController {
  var listMessage = <general_message_model.Datum>[].obs;
  var perPage = "10";
  var currentPage = 1.obs;
  var isLoading = false.obs;
  var isLoadingMore = false.obs;
  var total = 1.obs;
  ScrollController scrollController = ScrollController();
  var listAction = <int>[].obs;
  var checkAll = false.obs;

  setupScrollController() {
    scrollController = ScrollController();
    scrollController.addListener(() {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent && !isLoadingMore.value) {
        loadMore();
      }
    });
  }

  fetchGeneralMessage({bool isLoadMore = false}) async {
    try {
      if (isLoadMore) {
        isLoadingMore.value = true;
      } else {
        isLoading.value = true;
      }
      var response = await Repository.instance.generalMessageListApi(
        perPage: perPage,
        page: currentPage.value.toString(),
      );
      if (response is Success) {
        var result = general_message_model.generalMessageModelFromJson(response.response.toString());
        if (isLoadMore) {
          listMessage.addAll(result.data?.data ?? <general_message_model.Datum>[]);
        } else {
          listMessage.value = result.data?.data ?? [];
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

  deleteGeneralMessage({required int id}) async {
    showLoader();
    late APIStatus response;
    response = await Repository.instance.generalMessageDeleteApi(id: id == 0 ? listAction : [id]);
    hideLoader();
    if (response is Success) {
      var result = emptyModelFromJson(response.response.toString());
      showToast(msg: result.message ?? "");
      fetchGeneralMessage();
      listAction.clear();
      checkAll.value = false;
    } else if (response is Failure) {
      showToast(msg: "${response.errorResponse ?? ""}");
    }
  }

  markGeneralMessageRead({required int id, required bool status}) async {
    showLoader();
    late APIStatus response;
    response = await Repository.instance.generalMessageReadApi(
      id: id == 0 ? listAction : [id],
      status: status,
    );
    hideLoader();
    if (response is Success) {
      var result = emptyModelFromJson(response.response.toString());
      // showToast(msg: result.message ?? "");
      fetchGeneralMessage();
      listAction.clear();
      checkAll.value = false;
    } else if (response is Failure) {
      showToast(msg: "${response.errorResponse ?? ""}");
    }
  }

  checkMessage({required int? id}) {
    if (listAction.contains(id)) {
      listAction.remove(id);
    } else {
      if (id != null) {
        listAction.add(id);
      }
    }
    if(listAction.isEmpty){
      checkAll.value = false;
    }else{
      checkAll.value = true;
    }
    listAction.refresh();
  }

  void loadMore() {
    if (listMessage.length < total.value) {
      currentPage.value++;
      fetchGeneralMessage(isLoadMore: true);
    }
  }
}
