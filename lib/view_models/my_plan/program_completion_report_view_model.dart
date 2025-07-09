import 'package:get/get.dart';
import 'package:revalesuva/model/empty_model/empty_model.dart';
import 'package:revalesuva/model/my_plan/program_completion_report/program_question_model.dart'
    as program_question_model;
import 'package:revalesuva/model/my_plan/program_completion_report/submit_program_answer_model.dart'
    as submit_program_answer_model;
import 'package:revalesuva/repository/repository.dart';
import 'package:revalesuva/services/api_status.dart';
import 'package:revalesuva/utils/helper_method.dart';

class ProgramCompletionReportViewModel extends GetxController {
  var isLoading = false.obs;
  var activeProgramCompletionReportId = 1.obs;
  var progressCounter = 0.0.obs;
  var totalCounter = 0.0.obs;

  var currentQuestion = 0.obs;
  var lisQuestionList = <program_question_model.Datum>[].obs;
  var listGeneralQuestionAnswer = <program_question_model.Datum>[].obs;
  var listFeedbackFormQuestion = <program_question_model.Datum>[].obs;
  var listAfterImageQuestion = <program_question_model.Datum>[].obs;

  var imgBackPath = "".obs;
  var imgSidePath = "".obs;
  var imgFrontPath = "".obs;

  getProgramCompletionReportQuestion() async {
    var response = await Repository.instance.getProgramCompletionReportQuestionApi();
    if (response is Success) {
      var result = program_question_model.programQuestionModelFromJson(response.response.toString());
      listGeneralQuestionAnswer.assignAll(
        result.data
                ?.where(
                  (element) => element.pageType == "general-question-answer-page",
                )
                .toList() ??
            [],
      );
      listFeedbackFormQuestion.assignAll(
        result.data
                ?.where(
                  (element) => element.pageType == "feedback-form-page",
                )
                .toList() ??
            [],
      );
      listAfterImageQuestion.assignAll(
        result.data
                ?.where(
                  (element) => element.pageType == "after-image-page",
                )
                .toList() ??
            [],
      );

      lisQuestionList.assignAll(result.data ?? []);
      totalCounter.value = double.tryParse("${lisQuestionList.length}") ?? 0;
    } else if (response is Failure) {
      showToast(msg: "${response.errorResponse ?? ""}");
    }
  }

  onNextStepClick() {
    if (activeProgramCompletionReportId < 3) {
      activeProgramCompletionReportId++;
      progressCounter.value++;
    }
  }

  onPreviousStepClick() {
    if (activeProgramCompletionReportId > 1) {
      activeProgramCompletionReportId--;
      progressCounter.value--;
    }
  }

  onNextQuestion() {
    currentQuestion.value++;
    progressCounter.value++;
  }

  onPreviousQuestion() {
    currentQuestion.value--;
    progressCounter.value--;
  }

  Future<bool> submitAllProgramCompletionReportAns() async {
    bool validateAnswers(List<program_question_model.Datum> questions) {
      return questions.any((element) =>
          (element.tempAns != null && element.tempAns != "") &&
          (element.tempAnsSub != null && element.tempAnsSub != ""));
    }

    if (validateAnswers(listGeneralQuestionAnswer) ||
        validateAnswers(listFeedbackFormQuestion) ||
        validateAnswers(listAfterImageQuestion)) {
      if (imgBackPath.value.isEmpty || imgSidePath.value.isEmpty || imgFrontPath.value.isEmpty) {
        showToast(msg: "Please Upload before and after image properly");
        return false;
      }
      List<program_question_model.Datum> mainList = [
        ...listGeneralQuestionAnswer,
        ...listFeedbackFormQuestion,
        ...listAfterImageQuestion
      ];

      if (await storeAfterBeforeUserImage()) {
        List<submit_program_answer_model.Answer> answerList = mainList.map((item) {
          return submit_program_answer_model.Answer(
            planSummaryReportId: item.id,
            answer: item.tempAns,
            subAnswer: item.tempAnsSub,
            answerType: item.answerType,
          );
        }).toList();

        var createUserReportAns =
            submit_program_answer_model.SubmitProgramAnswerModel(answers: answerList);
        var response = await Repository.instance.submitCompletionReportApi(
          submitAnswer: createUserReportAns,
        );

        if (response is Success) {
          var result = emptyModelFromJson(response.response.toString());
          if (await updatePlanStatus()) {
            showToast(msg: "Your report has been submitted successfully");
            return true;
          }
        } else if (response is Failure) {
          showToast(msg: "${response.errorResponse}");
        }
      } else {
        showToast(msg: "something went wrong on Upload before and after image");
      }
    } else {
      showToast(msg: "Please fill your feedback form properly");
    }
    return false;
  }

  Future<bool> updatePlanStatus() async {
    var response = await Repository.instance.updatePlanStatusApi(
      status: "completed",
    );
    if (response is Success) {
      var result = emptyModelFromJson(response.response.toString());
      return true;
    } else if (response is Failure) {
      showToast(msg: "${response.errorResponse}");
    }
    return false;
  }

  Future<bool> storeAfterBeforeUserImage() async {
    var response = await Repository.instance.uploadUserAfterBeforePhotosApi(
      backPicPath: imgBackPath.value,
      frontPicPath: imgFrontPath.value,
      pictureType: "after",
      sidePicPath: imgSidePath.value,
    );

    if (response is Success) {
      var result = emptyModelFromJson(response.response.toString());
      return true;
    } else if (response is Failure) {
      showToast(msg: "${response.errorResponse}");
    }
    return false;
  }
}
