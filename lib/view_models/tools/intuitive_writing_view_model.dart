import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:revalesuva/model/empty_model/empty_model.dart';
import 'package:revalesuva/model/tools/intuitive_writing/intuitive_writing_model.dart' as intuitive_writing_model;
import 'package:revalesuva/repository/repository.dart';
import 'package:revalesuva/services/api_status.dart';
import 'package:revalesuva/utils/helper_method.dart';

class IntuitiveWritingViewModel extends GetxController {
  var txtWriting = TextEditingController();
  var listWrite = <intuitive_writing_model.Datum>[].obs;
  var perPage = "10";
  var currentPage = 1.obs;
  var isLoading = false.obs;
  var isLoadingMore = false.obs;
  var total = 1.obs;
  ScrollController scrollController = ScrollController();

  setupScrollController() {
    scrollController = ScrollController();
    scrollController.addListener(() {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent && !isLoadingMore.value) {
        loadMore();
      }
    });
  }

  void loadMore() {
    if (listWrite.length < total.value) {
      currentPage.value++;
      fetchIntuitiveWriting(isLoadMore: true);
    }
  }

  fetchIntuitiveWriting({bool isLoadMore = false}) async {
    try {
      if (isLoadMore) {
        isLoadingMore.value = true;
      } else {
        isLoading.value = true;
      }
      var response = await Repository.instance.intuitiveWritingListApi(
        perPage: perPage,
        page: currentPage.value.toString(),
      );
      if (response is Success) {
        var result = intuitive_writing_model.intuitiveWritingModelFromJson(response.response.toString());
        if (isLoadMore) {
          listWrite.addAll(result.data?.data ?? <intuitive_writing_model.Datum>[]);
        } else {
          listWrite.value = result.data?.data ?? [];
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

  createUpdateIntuitiveWriting({required int id, required BuildContext context}) async {
    showLoader();
    var response = await Repository.instance.createUpdateIntuitiveWritingApi(
      description: txtWriting.text,
      id: id,
    );
    hideLoader();
    if (response is Success) {
      var result = emptyModelFromJson(response.response.toString());
      showToast(msg: result.message ?? "");
      txtWriting.clear();
      currentPage.value = 1;
      await fetchIntuitiveWriting();
      setupScrollController();
      Navigator.of(context).pop();
    } else if (response is Failure) {
      showToast(msg: "${response.errorResponse ?? ""}");
    }
  }

  deleteIntuitiveWriting({required int id}) async {
    showLoader();
    var response = await Repository.instance.deleteIntuitiveWritingApi(
      id: [id],
    );
    hideLoader();
    if (response is Success) {
      var result = emptyModelFromJson(response.response.toString());
      showToast(msg: result.message ?? "");
      txtWriting.clear();
      currentPage.value = 1;
      await fetchIntuitiveWriting();
      setupScrollController();
    } else if (response is Failure) {
      showToast(msg: "${response.errorResponse ?? ""}");
    }
  }
}
