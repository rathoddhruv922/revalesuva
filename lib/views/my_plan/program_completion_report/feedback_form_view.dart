import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:revalesuva/components/custom_button.dart';
import 'package:revalesuva/components/custom_text.dart';
import 'package:revalesuva/model/my_plan/program_completion_report/program_question_model.dart'
    as program_question_model;
import 'package:revalesuva/utils/app_colors.dart';
import 'package:revalesuva/utils/strings_constant.dart';
import 'package:revalesuva/view_models/my_plan/program_completion_report_view_model.dart';
import 'package:revalesuva/views/my_plan/program_completion_report/widget/feedback_item_widget.dart';

class FeedbackFormView extends StatelessWidget {
  const FeedbackFormView({super.key, required this.listQuestion});

  final List<program_question_model.Datum> listQuestion;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Gap(10),
        TextBodyMedium(
          text: StringConstants.moveYourHeartOnTheScaleAccordingToYourFeelings,
          color: AppColors.textPrimary,
          textAlign: TextAlign.start,
        ),
        Expanded(
          child: ListView.separated(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(vertical: 10),
            itemBuilder: (context, index) {
              return FeedbackItemWidget(
                value: double.tryParse(listQuestion[index].tempAns ?? "5"),
                question1: listQuestion[index].question1 ?? "",
                question2: listQuestion[index].question2 ?? "",
                onChanged: (value) {
                  listQuestion[index].answerType = "yes_with_input";
                  listQuestion[index].tempAns = "${value ?? 5}";
                  listQuestion[index].tempAnsSub = "${value ?? 5}";
                },
              );
            },
            separatorBuilder: (context, index) => const Gap(10),
            itemCount: listQuestion.length,
          ),
        ),
        const Gap(10),
        Row(
          textDirection: Get.locale?.languageCode == "he" ? TextDirection.rtl : TextDirection.ltr,
          children: [
            // CustomTextButton(
            //   onPressed: () {},
            //   text: StringConstants.previousStep,
            //   icon: Icons.arrow_back_ios,
            //   textColor: AppColors.textSecondary,
            //   underline: false,
            // ),
            const Spacer(),
            CustomIconButton(
              onPressed: () {
                Get.find<ProgramCompletionReportViewModel>().onNextStepClick();
              },
              text: StringConstants.nextStep,
              icon: Icons.arrow_forward_ios,
            )
          ],
        ),
        const Gap(10),
        const Gap(70)
      ],
    );
  }
}
