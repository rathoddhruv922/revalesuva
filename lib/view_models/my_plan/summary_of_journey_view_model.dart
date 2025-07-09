import 'package:get/get.dart';
import 'package:revalesuva/model/my_plan/program_summary_view/program_user_summary_model.dart'
    as program_user_summary_model;
import 'package:revalesuva/repository/repository.dart';
import 'package:revalesuva/services/api_status.dart';
import 'package:revalesuva/utils/helper_method.dart';

class SummaryOfJourneyViewModel extends GetxController {
  var formId = 1.obs;
  var isLoading = false.obs;
  var listFeedbackQuestion = <program_user_summary_model.Datum>[].obs;
  var listGeneralQuestion = <program_user_summary_model.Datum>[].obs;

  getUserProgramSummaryReport() async {
    var response = await Repository.instance.getUserProgramSummaryReport();
    if (response is Success) {
      var result =
          program_user_summary_model.programUserSummaryModelFromJson(response.response.toString());
      listFeedbackQuestion.assignAll(
        result.data?.where(
              (element) => element.planSummaryReport?.pageType == "feedback-form-page",
            ) ??
            [],
      );

      listGeneralQuestion.assignAll(
        result.data?.where(
              (element) =>
                  element.planSummaryReport?.pageType == "after-image-page" ||
                  element.planSummaryReport?.pageType == "general-question-answer-page",
            ) ??
            [],
      );
    } else if (response is Failure) {
      listFeedbackQuestion.clear();
      listGeneralQuestion.clear();
      showToast(msg: "${response.errorResponse ?? ""}");
    }
  }

  onNextPage(){
    if(formId.value < 2){
      formId.value++;
    }
  }

  onPreviousPage(){
    if(formId.value > 1){
      formId.value--;
    }
  }
}
