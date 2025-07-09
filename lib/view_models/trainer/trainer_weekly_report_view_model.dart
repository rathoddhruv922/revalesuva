import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:revalesuva/model/medical_question/question_model.dart' as question_model;
import 'package:revalesuva/model/medical_question/user_ans_model.dart' as user_ans_model;
import 'package:revalesuva/model/personal_detail/user_model.dart' as user_model;
import 'package:revalesuva/model/tools/daily_report/daily_report_model.dart' as daily_report_model;
import 'package:revalesuva/repository/repository.dart';
import 'package:revalesuva/services/api_status.dart';
import 'package:revalesuva/utils/helper_method.dart';
import 'package:revalesuva/view_models/user_view_model.dart';

class TrainerWeeklyReportViewModel extends GetxController {
  var listReport = <daily_report_model.Datum>[].obs;
  var perPage = "10";
  var currentPage = 1.obs;
  var isLoadingMore = false.obs;
  var total = 1.obs;
  ScrollController scrollController = ScrollController();
  var userData = user_model.Data().obs;
  var listWeeklyQuestion = <question_model.Datum>[].obs;
  var listUserAns = <user_ans_model.Datum>[].obs;
  var isLoading = false.obs;

  setupScrollController({required String customerId}) {
    scrollController = ScrollController();
    scrollController.addListener(() {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent &&
          !isLoadingMore.value) {
        loadMore(customerId: customerId);
      }
    });
  }

  void loadMore({required String customerId}) {
    if (listReport.length < total.value) {
      currentPage.value++;
      fetchWeeklyReportList(
        isLoadMore: true,
        customerId: customerId,
      );
    }
  }

  getCustomerDetailById({required String customerId}) async {
    var response = await Repository.instance.getCustomerDetailByIdApi(
      customerId: customerId,
    );
    if (response is Success) {
      var result = user_model.userModelFromJson(response.response.toString());
      userData.value = result.data ?? user_model.Data();
    } else if (response is Failure) {
      showToast(msg: "${response.errorResponse ?? ""}");
    }
  }

  fetchWeeklyReportList({
    bool isLoadMore = false,
    required String customerId,
  }) async {
    try {
      if (isLoadMore) {
        isLoadingMore.value = true;
      } else {
        isLoading.value = true;
      }
      var response = await Repository.instance.getCustomerWeeklyReportListApi(
        perPage: perPage,
        customerId: customerId,
        page: currentPage.value.toString(),
      );
      if (response is Success) {
        var result = daily_report_model.dailyReportModelFromJson(response.response.toString());
        if (isLoadMore) {
          listReport.addAll(result.data?.data ?? <daily_report_model.Datum>[]);
        } else {
          listReport.assignAll(result.data?.data ?? []);
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

  fetchWeeklyReportQuestions() async {
    var response = await Repository.instance.getWeeklyReportQuestionApi(
      planId: "${Get.find<UserViewModel>().userPlanDetail.value.planId ?? ""}",
    );
    if (response is Success) {
      var result = question_model.questionModelFromJson(response.response.toString());
      listWeeklyQuestion.assignAll(result.data ?? []);
    } else if (response is Failure) {
      showToast(msg: "${response.errorResponse ?? ""}");
    }
  }

  fetchUserWeeklyReportAns({required String date, required String customerId}) async {
    var response = await Repository.instance.getCustomerWeeklyReportDataApi(
      date: date,
      customerId: customerId,
    );
    listUserAns.clear();
    if (response is Success) {
      var result = user_ans_model.userAnsModelFromJson(response.response.toString());
      if (result.status == 200) {
        listUserAns.assignAll(result.data ?? []);
      } else {
        listUserAns.clear();
      }
    } else if (response is Failure) {
      showToast(msg: "${response.errorResponse ?? ""}");
    }
  }
}
