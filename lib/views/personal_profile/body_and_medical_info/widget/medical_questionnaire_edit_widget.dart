part of '../body_and_medical_information_view.dart';

class MedicalQuestionnaireEditWidget extends StatelessWidget {
  MedicalQuestionnaireEditWidget({super.key, required this.title});

  final String title;
  final PersonalProfileViewModel personalProfileViewModel = Get.find<PersonalProfileViewModel>();
  final QueAndAnsViewModel queAndAnsViewModel = Get.find<QueAndAnsViewModel>();

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        personalProfileViewModel.isMedicalQuestionEditable.value = false;
      },
      child: Column(
        textDirection: Get.locale?.languageCode == "he" ? TextDirection.rtl : TextDirection.ltr,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
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
              crossAxisAlignment: CrossAxisAlignment.start,
              textDirection: Get.locale?.languageCode == "he" ? TextDirection.rtl : TextDirection.ltr,
              children: [
                Row(
                  children: [
                    const ImageIcon(
                      AssetImage(Assets.iconsIcQuestionnaire),
                      size: 20,
                    ),
                    const Gap(10),
                    Expanded(
                      child: TextTitleMedium(
                        text: StringConstants.medicalQuestionnaire,
                      ),
                    ),
                  ],
                ),
                const Gap(20),
                Obx(
                  () => ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.all(0),
                    itemBuilder: (context, index) {
                      var answer = queAndAnsViewModel.listCreateUserAns.indexWhere(
                        (element) =>
                            element.questionId == queAndAnsViewModel.listMedicalQuestion[index].id,
                      );
                      return ReportQuestionAnswerWidget(
                        question: queAndAnsViewModel.listMedicalQuestion[index],
                        answer: answer != -1 ? queAndAnsViewModel.listCreateUserAns[answer] : null,
                        index: index,
                        onChange: (value, subAns, index) {
                          queAndAnsViewModel.addUserAns(
                            currentQuestionIndex: index,
                            answer: value ?? "",
                            subAnswer: subAns,
                          );
                          queAndAnsViewModel.listMedicalQuestion.refresh();
                        },
                        onTextChange: (String? value) {
                          if (queAndAnsViewModel.listMedicalQuestion[index].answerType == "input_box") {
                            queAndAnsViewModel.addUserAns(
                              currentQuestionIndex: index,
                              answer: value ?? "",
                              subAnswer: value ?? "",
                            );
                          } else {
                            queAndAnsViewModel.addUserAns(
                              currentQuestionIndex: index,
                              answer: queAndAnsViewModel.listCreateUserAns[answer].answer ?? "",
                              subAnswer: value ?? "",
                            );
                          }
                        },
                      );
                    },
                    itemCount: queAndAnsViewModel.listMedicalQuestion.length,
                  ),
                ),
              ],
            ),
          ),
          const Gap(20),
          SimpleButton(
            text: StringConstants.saveChanges,
            onPressed: () async {
              var result = await queAndAnsViewModel.submitUserMedicalAns();
              if (result) {
                personalProfileViewModel.isMedicalQuestionEditable.value = false;
              }
            },
          )
        ],
      ),
    );
  }
}
