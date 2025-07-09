import 'package:get/get.dart';
import 'package:revalesuva/model/empty_model/empty_model.dart';
import 'package:revalesuva/model/medical_question/create_user_answer_model.dart'
    as create_user_answer_model;
import 'package:revalesuva/model/medical_question/question_model.dart' as question_model;
import 'package:revalesuva/model/medical_question/user_ans_model.dart' as user_ans_model;
import 'package:revalesuva/repository/repository.dart';
import 'package:revalesuva/services/api_status.dart';
import 'package:revalesuva/utils/helper_method.dart';
import 'package:revalesuva/utils/strings_constant.dart';

class QueAndAnsViewModel extends GetxController {
  var listMedicalQuestion = <question_model.Datum>[].obs;
  var listCreateUserAns = <create_user_answer_model.Answer>[].obs;
  var listUserAns = <user_ans_model.Datum>[].obs;
  var isLoading = false.obs;

  fetchMedicalQuestions() async {
    var response = await Repository.instance.getMedicalQuestionApi();

    if (response is Success) {
      var result = question_model.questionModelFromJson(response.response.toString());
      listMedicalQuestion.assignAll(result.data ?? []);
    } else if (response is Failure) {
      showToast(msg: "${response.errorResponse ?? ""}");
    }
  }

  addUserAns({
    required int currentQuestionIndex,
    required String answer,
    required subAnswer,
  }) {
    final currentQuestion = listMedicalQuestion[currentQuestionIndex];

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

  Future<bool> submitUserMedicalAns() async {
    if (listMedicalQuestion.length == listCreateUserAns.length) {
      for (var item in listCreateUserAns) {
        if (item.answer?.isEmpty ??
            false ||
                (item.answerType == "input_box" && (item.subAnswer?.isEmpty ?? false)) ||
                (item.answerType == "yes_with_input" && (item.subAnswer?.isEmpty ?? false)) ||
                (item.answerType == "no_with_input" && (item.subAnswer?.isEmpty ?? false))) {
          showToast(msg: StringConstants.pleaseCompleteAllTheAnswers);
          return false;
        }
      }
      showLoader();
      var status = false;

      var response = await Repository.instance.createUserAnswerApi(
          createAnswerModel: create_user_answer_model.CreateUserAnswerModel(answers: listCreateUserAns));
      hideLoader();
      if (response is Success) {
        var result = emptyModelFromJson(response.response.toString());
        showToast(msg: result.message ?? "");
        status = true;
      } else if (response is Failure) {
        showToast(msg: "${response.errorResponse ?? ""}");
        status = false;
      }
      return status;
    } else {
      showToast(msg: StringConstants.pleaseCompleteAllTheAnswers);
      return false;
    }
  }

  fetchUserMedicalAns() async {
    var response = await Repository.instance.getUserAns();
    if (response is Success) {
      var result = user_ans_model.userAnsModelFromJson(response.response.toString());
      listUserAns.assignAll(result.data ?? []);
      listCreateUserAns.clear();
      for (var item in listUserAns) {
        listCreateUserAns.add(create_user_answer_model.Answer(
          answer: item.answer,
          questionId: item.questionId,
          answerType: item.answerType,
          subAnswer: item.subAnswer,
        ));
      }
    } else if (response is Failure) {
      if (response.code != 404) {
        showToast(msg: "${response.errorResponse ?? ""}");
      }
    }
  }
}
