part of 'personal_details_screen.dart';

class MedicalQuestion extends StatefulWidget {
  const MedicalQuestion({super.key});

  @override
  State<MedicalQuestion> createState() => _MedicalQuestionState();
}

class _MedicalQuestionState extends State<MedicalQuestion> {
  final PersonalDetailsViewModel personalDetailsViewModel = Get.find<PersonalDetailsViewModel>();
  final QueAndAnsViewModel queAndAnsViewModel = Get.find<QueAndAnsViewModel>();
  final TextEditingController txtSubAns = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      queAndAnsViewModel.isLoading.value = true;
      await queAndAnsViewModel.fetchMedicalQuestions();
      await Future.delayed(const Duration(seconds: 2));
      queAndAnsViewModel.isLoading.value = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => queAndAnsViewModel.isLoading.isTrue
          ? SizedBox(
              width: 100.w,
              height: 40.h,
              child: const CupertinoActivityIndicator(radius: 20),
            )
          : Column(
              children: [
                queAndAnsViewModel.listMedicalQuestion.isEmpty
                    ? TextHeadlineMedium(text: StringConstants.noDataFound)
                    : MedicalQuestionProgressbarWidget(
                        value:
                            double.tryParse(personalDetailsViewModel.currentQuestion.value.toString()) ??
                                0.0,
                        max: double.tryParse(queAndAnsViewModel.listMedicalQuestion.length.toString()) ??
                            0.0,
                      ),
                queAndAnsViewModel.listMedicalQuestion.isEmpty
                    ? Row(
                        textDirection:
                            Get.locale?.languageCode == "he" ? TextDirection.rtl : TextDirection.ltr,
                        children: [
                          Obx(
                            () => personalDetailsViewModel.currentQuestion.value == 0
                                ? CustomTextButton(
                                    onPressed: personalDetailsViewModel.onPreviousStepClick,
                                    text: StringConstants.previousStep,
                                    icon: Icons.arrow_back_ios,
                                    underline: false,
                                  )
                                : CustomTextButton(
                                    onPressed: personalDetailsViewModel.onPreviousQuestion,
                                    text: StringConstants.previousQuestion,
                                    icon: Icons.arrow_back_ios,
                                    underline: false,
                                  ),
                          ),
                          const Spacer(),
                          SimpleButton(
                            onPressed: () async {
                              personalDetailsViewModel.onNextStepClick();
                            },
                            text: StringConstants.nextStep,
                          ),
                        ],
                      )
                    : Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Column(
                          textDirection:
                              Get.locale?.languageCode == "he" ? TextDirection.rtl : TextDirection.ltr,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Gap(20),
                            TextLabelMedium(
                              text: queAndAnsViewModel
                                      .listMedicalQuestion[
                                          personalDetailsViewModel.currentQuestion.value]
                                      .question ??
                                  "",
                              textAlign: TextAlign.center,
                              color: AppColors.textPrimary,
                            ),
                            const Gap(30),
                            if (queAndAnsViewModel
                                    .listMedicalQuestion[personalDetailsViewModel.currentQuestion.value]
                                    .answerType !=
                                "input_box")
                              Row(
                                textDirection: Get.locale?.languageCode == "he"
                                    ? TextDirection.rtl
                                    : TextDirection.ltr,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Flexible(
                                    child: CustomButton(
                                      width: 20.w,
                                      text: StringConstants.no,
                                      backgroundColor: queAndAnsViewModel.listCreateUserAns.any(
                                              (element) =>
                                                  element.answer == "no" &&
                                                  element.questionId ==
                                                      queAndAnsViewModel
                                                          .listMedicalQuestion[personalDetailsViewModel
                                                              .currentQuestion.value]
                                                          .id)
                                          ? AppColors.surfaceBrand
                                          : AppColors.surfaceSecondary,
                                      onPressed: () {
                                        queAndAnsViewModel.addUserAns(
                                          currentQuestionIndex:
                                              personalDetailsViewModel.currentQuestion.value,
                                          answer: "no",
                                          subAnswer: "",
                                        );
                                      },
                                    ),
                                  ),
                                  const Gap(20),
                                  Flexible(
                                    child: CustomButton(
                                      width: 20.w,
                                      text: StringConstants.yes,
                                      backgroundColor: queAndAnsViewModel.listCreateUserAns.any(
                                              (element) =>
                                                  element.answer == "yes" &&
                                                  element.questionId ==
                                                      queAndAnsViewModel
                                                          .listMedicalQuestion[personalDetailsViewModel
                                                              .currentQuestion.value]
                                                          .id)
                                          ? AppColors.surfaceBrand
                                          : AppColors.surfaceSecondary,
                                      onPressed: () {
                                        queAndAnsViewModel.addUserAns(
                                          currentQuestionIndex:
                                              personalDetailsViewModel.currentQuestion.value,
                                          answer: "yes",
                                          subAnswer: "",
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            Obx(() => showInputBox()),
                            const Gap(30),
                            Row(
                              textDirection: Get.locale?.languageCode == "he"
                                  ? TextDirection.rtl
                                  : TextDirection.ltr,
                              children: [
                                Obx(
                                  () => personalDetailsViewModel.currentQuestion.value == 0
                                      ? CustomTextButton(
                                          onPressed: personalDetailsViewModel.onPreviousStepClick,
                                          text: StringConstants.previousStep,
                                          icon: Icons.arrow_back_ios,
                                          underline: false,
                                        )
                                      : CustomTextButton(
                                          onPressed: personalDetailsViewModel.onPreviousQuestion,
                                          text: StringConstants.previousQuestion,
                                          icon: Icons.arrow_back_ios,
                                          underline: false,
                                        ),
                                ),
                                const Spacer(),
                                Obx(
                                  () => personalDetailsViewModel.currentQuestion.value ==
                                          queAndAnsViewModel.listMedicalQuestion.length - 1
                                      ? SimpleButton(
                                          onPressed: () async {
                                            var result = await queAndAnsViewModel.submitUserMedicalAns();
                                            if (result) {
                                              personalDetailsViewModel.onNextStepClick();
                                            }
                                          },
                                          text: StringConstants.nextStep,
                                        )
                                      : CustomIconButton(
                                          onPressed: () {
                                            final question = queAndAnsViewModel.listMedicalQuestion[
                                                personalDetailsViewModel.currentQuestion.value];
                                            final answer =
                                                queAndAnsViewModel.listCreateUserAns.firstWhereOrNull(
                                              (item) => item.questionId == question.id,
                                            );
                                            if(question.answerType == "input_box"){
                                              queAndAnsViewModel.addUserAns(
                                                answer: txtSubAns.text,
                                                subAnswer: txtSubAns.text,
                                                currentQuestionIndex:
                                                personalDetailsViewModel.currentQuestion.value,
                                              );
                                            }else{
                                              queAndAnsViewModel.addUserAns(
                                                answer: answer?.answer ?? "",
                                                subAnswer: txtSubAns.text,
                                                currentQuestionIndex:
                                                personalDetailsViewModel.currentQuestion.value,
                                              );
                                            }

                                            personalDetailsViewModel.onNextQuestion();
                                          },
                                          text: StringConstants.nextQuestion,
                                          icon: Icons.arrow_forward_ios,
                                        ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
              ],
            ),
    );
  }

  Widget showInputBox() {
    final question =
        queAndAnsViewModel.listMedicalQuestion[personalDetailsViewModel.currentQuestion.value];
    final answer =
        queAndAnsViewModel.listCreateUserAns.firstWhereOrNull((item) => item.questionId == question.id);

    if (question.answerType == "input_box" ||
        (question.answerType == "yes_with_input" && answer?.answer == "yes") ||
        (question.answerType == "no_with_input" && answer?.answer == "no")) {
      txtSubAns.text = answer?.subAnswer ?? "";

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
