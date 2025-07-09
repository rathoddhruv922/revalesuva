import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:revalesuva/components/custom_button.dart';
import 'package:revalesuva/components/custom_text_field.dart';
import 'package:revalesuva/utils/app_colors.dart';
import 'package:revalesuva/utils/helper_method.dart';
import 'package:revalesuva/utils/strings_constant.dart';
import 'package:revalesuva/view_models/my_plan/program_completion_report_view_model.dart';
import 'package:revalesuva/views/my_plan/program_completion_report/widget/completion_report_question_widget.dart';

class GeneralQuestionView extends StatelessWidget {
  GeneralQuestionView({super.key});

  final TextEditingController txtSubAns = TextEditingController();

  final ProgramCompletionReportViewModel programCompletionReportViewModel =
      Get.find<ProgramCompletionReportViewModel>();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Flexible(
          child: programCompletionReportViewModel.listGeneralQuestionAnswer.isEmpty
              ? const SizedBox()
              : ListView(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  children: [
                    Obx(
                      () {
                        var index = programCompletionReportViewModel.currentQuestion.value;
                        return CustomCard2(
                          color: AppColors.surfaceTertiary,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                            child: Obx(
                              () => CompletionReportQuestionWidget(
                                index: index,
                                onChange: (value, subAns, index) {
                                  var question = programCompletionReportViewModel
                                      .listGeneralQuestionAnswer[index];
                                  programCompletionReportViewModel
                                      .listGeneralQuestionAnswer[index].tempAns = value;

                                  bool isNoWithInput = question.answerType == "no_with_input";
                                  bool isYesWithInput = question.answerType == "yes_with_input";

                                  if ((isNoWithInput && question.tempAns == "yes") ||
                                      (isYesWithInput && question.tempAns == "no")) {
                                    programCompletionReportViewModel
                                        .listGeneralQuestionAnswer[index].tempAnsSub = value;
                                  } else if (isNoWithInput || isYesWithInput) {
                                    programCompletionReportViewModel
                                        .listGeneralQuestionAnswer[index].tempAnsSub = "";
                                  } else {
                                    programCompletionReportViewModel
                                        .listGeneralQuestionAnswer[index].tempAnsSub = value;
                                  }

                                  programCompletionReportViewModel.listGeneralQuestionAnswer.refresh();
                                },
                                onTextChange: (value) {
                                  var question = programCompletionReportViewModel
                                      .listGeneralQuestionAnswer[index];
                                  if (question.answerType == "input_box" ||
                                      question.answerType == "text_area") {
                                    programCompletionReportViewModel
                                        .listGeneralQuestionAnswer[index].tempAns = value;
                                  }
                                  programCompletionReportViewModel
                                      .listGeneralQuestionAnswer[index].tempAnsSub = value;
                                  programCompletionReportViewModel.listGeneralQuestionAnswer.refresh();
                                },
                                question:
                                    programCompletionReportViewModel.listGeneralQuestionAnswer[index],
                                subAns: programCompletionReportViewModel
                                        .listGeneralQuestionAnswer[index].tempAnsSub ??
                                    "",
                              ),
                            ),
                          ),
                        );
                      },
                    )
                  ],
                ),
        ),
        const Gap(20),
        Row(
          textDirection: Get.locale?.languageCode == "he" ? TextDirection.rtl : TextDirection.ltr,
          children: [
            Obx(
              () {
                var index = programCompletionReportViewModel.currentQuestion.value;
                return index == 0
                    ? CustomTextButton(
                        onPressed: programCompletionReportViewModel.onPreviousStepClick,
                        text: StringConstants.previousStep,
                        icon: Icons.arrow_back_ios,
                        underline: false,
                      )
                    : CustomTextButton(
                        onPressed: programCompletionReportViewModel.onPreviousQuestion,
                        text: StringConstants.previousQuestion,
                        icon: Icons.arrow_back_ios,
                        underline: false,
                      );
              },
            ),
            const Spacer(),
            Obx(
              () {
                var index = programCompletionReportViewModel.currentQuestion.value;
                return index == programCompletionReportViewModel.listGeneralQuestionAnswer.length - 1
                    ? SimpleButton(
                        onPressed: () async {
                          programCompletionReportViewModel.onNextStepClick();
                        },
                        text: StringConstants.nextStep,
                      )
                    : CustomIconButton(
                        onPressed: () {
                          var question =
                              programCompletionReportViewModel.listGeneralQuestionAnswer[index];
                          if ((question.tempAns?.isEmpty ?? true) ||
                              (question.tempAnsSub?.isEmpty ?? true)) {
                            showToast(msg: "Please fill your feedback");
                          } else {
                            programCompletionReportViewModel.onNextQuestion();
                          }
                        },
                        text: StringConstants.nextQuestion,
                        icon: Icons.arrow_forward_ios,
                      );
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget showInputBox() {
    var index = programCompletionReportViewModel.currentQuestion.value;
    final question = programCompletionReportViewModel.listGeneralQuestionAnswer[index];

    if (question.answerType == "input_box" ||
        (question.answerType == "yes_with_input" && question.tempAns == "yes") ||
        (question.answerType == "no_with_input" && question.tempAns == "no")) {
      txtSubAns.text = question.tempAnsSub ?? "";
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        child: CustomTextField(
          hint: StringConstants.description,
          maxLine: 3,
          controller: txtSubAns,
        ),
      );
    } else {
      txtSubAns.text = "";
      return const SizedBox();
    }
  }
}
