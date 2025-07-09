import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:revalesuva/model/empty_model/empty_model.dart';
import 'package:revalesuva/model/making_contact/get_support_service_model.dart'
    as get_support_service_model;
import 'package:revalesuva/model/making_contact/support_service_model.dart' as support_service_model;
import 'package:revalesuva/model/trainer_chat/get_trainer_model.dart' as get_trainer_model;
import 'package:revalesuva/repository/repository.dart';
import 'package:revalesuva/services/api_status.dart';
import 'package:revalesuva/utils/helper_method.dart';

class MakingContactViewModel extends GetxController {
  var txtTitle = TextEditingController();
  var txtDetail = TextEditingController();
  var listMessage = <get_support_service_model.Datum>[].obs;
  var perPage = "10";
  var currentPage = 1.obs;
  var isLoading = false.obs;
  var isLoadingMore = false.obs;
  var total = 1.obs;
  ScrollController scrollController = ScrollController();
  var listDelete = <int>[].obs;
  var checkAll = false.obs;
  var listTrainer = <get_trainer_model.Datum>[];

  setupScrollController() {
    scrollController.addListener(() {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent &&
          !isLoadingMore.value) {
        loadMore();
      }
    });
  }

  fetchAllTrainer() async {
    isLoading.value = true;
    var response = await Repository.instance.getTrainerApi();
    isLoading.value = false;
    if (response is Success) {
      var result = get_trainer_model.getTrainerModelFromJson(response.response.toString());
      listTrainer.assignAll(result.data ?? []);
    } else if (response is Failure) {
      showToast(msg: "${response.errorResponse ?? ""}");
    }
  }

  callTechnicalSupport({required BuildContext context}) async {
    showLoader();
    var response = await Repository.instance.technicalSupportApi(
      title: txtTitle.text,
      detail: txtDetail.text,
    );
    hideLoader();
    if (response is Success) {
      if (response.code == 200) {
        var result = support_service_model.supportServiceModelFromJson(response.response.toString());
        showToast(msg: result.message ?? "");
        checkAll.value = false;
        isLoading.value = false;
        isLoadingMore.value = false;
        listMessage.clear();
        listDelete.clear();
        currentPage.value = 1;
        total.value = 1;
        scrollController = ScrollController();
        await fetchTechnicalSupport();
        setupScrollController();
        if (context.mounted) {
          Navigator.of(context).pop();
        }
      }
    } else if (response is Failure) {
      showToast(msg: "${response.errorResponse ?? ""}");
    }
  }

  fetchTechnicalSupport({bool isLoadMore = false}) async {
    try {
      if (isLoadMore) {
        isLoadingMore.value = true;
      } else {
        isLoading.value = true;
      }
      var response = await Repository.instance.technicalSupportListApi(
        perPage: perPage,
        page: currentPage.value.toString(),
      );
      if (response is Success) {
        var result =
            get_support_service_model.getSupportServiceModelFromJson(response.response.toString());
        if (isLoadMore) {
          listMessage.addAll(result.data?.data ?? <get_support_service_model.Datum>[]);
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

  deleteMessageSupport({required int id, required String messageType}) async {
    showLoader();
    late APIStatus response;
    if (messageType == "technical") {
      response = await Repository.instance.technicalSupportDeleteApi(id: id == 0 ? listDelete : [id]);
    } else {
      response = await Repository.instance.serviceInquiryDeleteApi(id: id == 0 ? listDelete : [id]);
    }
    hideLoader();
    if (response is Success) {
      var result = emptyModelFromJson(response.response.toString());
      showToast(msg: result.message ?? "");
      if (messageType == "technical") {
        fetchTechnicalSupport();
      } else {
        fetchInquiryService();
      }
      checkAll.value = false;
    } else if (response is Failure) {
      showToast(msg: "${response.errorResponse ?? ""}");
    }
  }

  callInquiryService({required BuildContext context}) async {
    showLoader();
    var response = await Repository.instance.inquirySupportApi(
      title: txtTitle.text,
      detail: txtDetail.text,
    );
    hideLoader();
    if (response is Success) {
      if (response.code == 200) {
        var result = support_service_model.supportServiceModelFromJson(response.response.toString());
        showToast(msg: result.message ?? "");

        checkAll.value = false;
        isLoading.value = false;
        isLoadingMore.value = false;
        listMessage.clear();
        listDelete.clear();
        currentPage.value = 1;
        total.value = 1;
        await fetchInquiryService();
        scrollController = ScrollController();
        setupScrollController();

        if (context.mounted) {
          Navigator.of(context).pop();
        }
      }
    } else if (response is Failure) {
      showToast(msg: "${response.errorResponse ?? ""}");
    }
  }

  fetchInquiryService({bool isLoadMore = false}) async {
    try {
      if (isLoadMore) {
        isLoadingMore.value = true;
      } else {
        isLoading.value = true;
      }
      var response = await Repository.instance.serviceInquiryListApi(
        perPage: perPage,
        page: currentPage.value.toString(),
      );
      if (response is Success) {
        var result =
            get_support_service_model.getSupportServiceModelFromJson(response.response.toString());
        if (isLoadMore) {
          listMessage.addAll(result.data?.data ?? <get_support_service_model.Datum>[]);
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

  checkMessage({required int? id}) {
    if (listDelete.contains(id)) {
      listDelete.remove(id);
    } else {
      if (id != null) {
        listDelete.add(id);
      }
    }

    if (listDelete.length == listMessage.length) {
      checkAll.value = true;
    } else {
      checkAll.value = false;
    }
    listDelete.refresh();
  }

  void loadMore() {
    if (listMessage.length < total.value) {
      currentPage.value++;
      fetchTechnicalSupport(isLoadMore: true);
    }
  }
}
