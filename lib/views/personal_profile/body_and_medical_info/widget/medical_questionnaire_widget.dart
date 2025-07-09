part of '../body_and_medical_information_view.dart';

class MedicalQuestionnaireWidget extends StatefulWidget {
  const MedicalQuestionnaireWidget({super.key});

  @override
  State<MedicalQuestionnaireWidget> createState() => _MedicalQuestionnaireWidgetState();
}

class _MedicalQuestionnaireWidgetState extends State<MedicalQuestionnaireWidget> {
  final PersonalProfileViewModel personalProfileViewModel = Get.find<PersonalProfileViewModel>();
  final QueAndAnsViewModel queAndAnsViewModel = Get.find<QueAndAnsViewModel>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      queAndAnsViewModel.isLoading.value = true;
      queAndAnsViewModel.listCreateUserAns.clear();
      await queAndAnsViewModel.fetchMedicalQuestions();
      await queAndAnsViewModel.fetchUserMedicalAns();
      queAndAnsViewModel.isLoading.value = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => queAndAnsViewModel.isLoading.isTrue || queAndAnsViewModel.listMedicalQuestion.isEmpty
          ? SizedBox(
              width: 100.w,
              height: 40.h,
              child: const CupertinoActivityIndicator(radius: 20),
            )
          : Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: AppColors.surfaceTertiary,
                borderRadius: BorderRadiusDirectional.only(
                  bottomStart: Radius.circular(
                    AppCorner.editCard,
                  ),
                  topEnd: Radius.circular(
                    AppCorner.editCard,
                  ),
                ),
              ),
              child: Column(
                textDirection: Get.locale?.languageCode == "he" ? TextDirection.rtl : TextDirection.ltr,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  EditButtonWidget(
                    title: StringConstants.medicalQuestionnaire,
                    onTab: () {
                      queAndAnsViewModel.listCreateUserAns.clear();
                      for (var items in queAndAnsViewModel.listUserAns) {
                        queAndAnsViewModel.listCreateUserAns.add(
                          create_user_answer_model.Answer(
                            questionId: items.questionId,
                            answerType: items.answerType,
                            subAnswer: items.subAnswer,
                            answer: items.answer,
                          ),
                        );
                      }
                      personalProfileViewModel.isMedicalQuestionEditable.value = true;
                    },
                    icon: Assets.iconsIcQuestionnaire,
                  ),
                  const Gap(20),
                  Obx(
                    () => ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.all(0),
                      itemBuilder: (context, index) {
                        var answer = queAndAnsViewModel.listUserAns.firstWhereOrNull(
                          (element) => element.questionId == queAndAnsViewModel.listMedicalQuestion[index].id,
                        );
                        return QuestionAnsItemWidget(
                          question: "${index + 1}. ${queAndAnsViewModel.listMedicalQuestion[index].question}",
                          ans: getAnsByType(index),
                        );
                      },
                      itemCount: queAndAnsViewModel.listMedicalQuestion.length,
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  // String getAns(index) {
  //   final question = queAndAnsViewModel.listMedicalQuestion[index];
  //   final answer = queAndAnsViewModel.listCreateUserAns.firstWhereOrNull((item) => item.questionId == question.id);
  //
  //   if ((question.answerType == "yes_with_input") || (question.answerType == "no_with_input")) {
  //     return "${answer?.answer?.capitalize ?? ""}${(answer?.subAnswer?.isNotEmpty == true && answer?.answer?.isNotEmpty == true) ? "." : ""} ${answer?.subAnswer ?? ""}";
  //   } else {
  //     return answer?.subAnswer ?? "";
  //   }
  // }


  String getAnsByType(index) {
    final question = queAndAnsViewModel.listMedicalQuestion[index];
    final answer = queAndAnsViewModel.listCreateUserAns.firstWhereOrNull((item) => item.questionId == question.id);

    switch (answer?.answerType ?? "") {
      case "input_box":
        {
          return answer?.answer?.capitalize ?? "";
        }
      case "yes_with_input":
        {
          if (answer?.answer == "yes") {
            return "${answer?.answer?.capitalize ?? ""}. ${answer?.subAnswer ?? ""}";
          } else {
            return answer?.answer?.capitalize ?? "";
          }
        }
      case "no_with_input":
        {
          if (answer?.answer == "no") {
            return "${answer?.answer?.capitalize ?? ""}. ${answer?.subAnswer ?? ""}";
          } else {
            return answer?.answer?.capitalize ?? "";
          }
        }
      case "yes_no":
        {
          return answer?.answer?.capitalize ?? "";
        }
      default:
        {
          return "Not Answer found";
        }
    }
  }
}
