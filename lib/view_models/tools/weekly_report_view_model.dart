import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:revalesuva/model/empty_model/empty_model.dart';
import 'package:revalesuva/model/medical_question/create_user_answer_model.dart' as create_user_answer_model;
import 'package:revalesuva/model/medical_question/question_model.dart' as question_model;
import 'package:revalesuva/model/medical_question/user_ans_model.dart' as user_ans_model;
import 'package:revalesuva/model/tools/daily_report/daily_report_model.dart' as daily_report_model;
import 'package:revalesuva/repository/repository.dart';
import 'package:revalesuva/services/api_status.dart';
import 'package:revalesuva/utils/helper_method.dart';
import 'package:revalesuva/view_models/user_view_model.dart';

class WeeklyReportViewModel extends GetxController {
  var listReport = <daily_report_model.Datum>[].obs;
  var perPage = "10";
  var currentPage = 1.obs;
  var isLoadingMore = false.obs;
  var total = 1.obs;
  ScrollController scrollController = ScrollController();

  var listWeeklyQuestion = <question_model.Datum>[].obs;
  var listCreateUserAns = <create_user_answer_model.Answer>[].obs;
  var listUserAns = <user_ans_model.Datum>[].obs;
  var isLoading = false.obs;

  setupScrollController() {
    scrollController = ScrollController();
    scrollController.addListener(() {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent && !isLoadingMore.value) {
        loadMore();
      }
    });
  }

  void loadMore() {
    if (listReport.length < total.value) {
      currentPage.value++;
      fetchWeeklyReportList(isLoadMore: true);
    }
  }

  fetchWeeklyReportList({bool isLoadMore = false}) async {
    try {
      if (isLoadMore) {
        isLoadingMore.value = true;
      } else {
        isLoading.value = true;
      }
      var response = await Repository.instance.getWeeklyReportListApi(
        perPage: perPage,
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

  addUserAns({
    required int currentQuestionIndex,
    required String answer,
    required subAnswer,
  }) {
    final currentQuestion = listWeeklyQuestion[currentQuestionIndex];

    final ansIndex = listCreateUserAns.indexWhere(
      (element) => element.questionId == currentQuestion.id,
    );

    final newAnswer = create_user_answer_model.Answer(
      answer: answer,
      questionId: currentQuestion.id,
      answerType: currentQuestion.answerType,
      subAnswer: subAnswer,
    );

    if (ansIndex < 0) {
      listCreateUserAns.add(newAnswer);
    } else {
      listCreateUserAns[ansIndex] = newAnswer;
    }
    listCreateUserAns.refresh();
  }

  submitUserWeeklyReportAns() async {
    if (listWeeklyQuestion.length == listCreateUserAns.length) {
      for (var item in listCreateUserAns) {
        if (item.answer?.isEmpty ??
            false ||
                (item.answerType == "input_box" && (item.subAnswer?.isEmpty ?? false)) ||
                (item.answerType == "yes_with_input" && (item.subAnswer?.isEmpty ?? false)) ||
                (item.answerType == "no_with_input" && (item.subAnswer?.isEmpty ?? false))) {
          showToast(msg: "Fill all answer");
          return;
        }
      }
      showLoader();
      var createUserAns = create_user_answer_model.CreateUserAnswerModel(
        answers: listCreateUserAns,
      );
      var response = await Repository.instance.createWeeklyReportUserAnswerApi(
        createAnswerModel: createUserAns,
      );

      hideLoader();
      if (response is Success) {
        var result = emptyModelFromJson(response.response.toString());
        showToast(msg: result.message ?? "");
      } else if (response is Failure) {
        showToast(msg: "${response.errorResponse ?? ""}");
      }
    } else {
      showToast(msg: "Fill all answer");
    }
  }

  fetchUserWeeklyReportAns({required String date}) async {
    var response = await Repository.instance.getUserWeeklyReportListApi(date: date);
    listUserAns.clear();
    listCreateUserAns.clear();
    if (response is Success) {
      var result = user_ans_model.userAnsModelFromJson(response.response.toString());
      listUserAns.assignAll(result.data ?? []);
      for (var item in listUserAns) {
        listCreateUserAns.add(
          create_user_answer_model.Answer(
            answer: item.answer,
            questionId: item.questionId,
            answerType: item.answerType,
            subAnswer: item.subAnswer,
          ),
        );
      }
    } else if (response is Failure) {
      //showToast(msg: "${response.errorResponse ?? ""}");
    }
  }
}
