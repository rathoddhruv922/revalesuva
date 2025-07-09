import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:revalesuva/components/custom_text.dart';
import 'package:revalesuva/model/my_plan/program_summary_view/program_user_summary_model.dart'
    as program_user_summary_model;
import 'package:revalesuva/utils/app_colors.dart';

class SummaryGeneralItemWidget extends StatelessWidget {
  const SummaryGeneralItemWidget({
    super.key,
    this.data,
    required this.isShowDivider,
  });

  final program_user_summary_model.Datum? data;
  final bool isShowDivider;

  @override
  Widget build(BuildContext context) {
    return Column(
      textDirection: Get.locale?.languageCode == "he" ? TextDirection.rtl : TextDirection.ltr,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextTitleSmall(
          text: data?.planSummaryReport?.question1 ?? "",
          maxLine: 10,
        ),
        const Gap(5),
        Padding(
          padding: const EdgeInsetsDirectional.only(start: 10),
          child: getOptionByType(),
        ),
        const Gap(10),
        if (!isShowDivider) const Divider(),
      ],
    );
  }

  Widget getOptionByType() {
    switch (data?.planSummaryReport?.answerType ?? "") {
      case "input_box":
        {
          return TextBodySmall(
            text: data?.answer?.capitalize ?? "",
            color: AppColors.textPrimary,
          );
        }
      case "yes_with_input":
        {
          if (data?.answer == "yes") {
            return TextBodySmall(
              text: "${data?.answer?.capitalize ?? ""}. ${data?.subAnswer ?? ""}",
              color: AppColors.textPrimary,
            );
          } else {
            return TextBodySmall(
              text: data?.answer?.capitalize ?? "",
              color: AppColors.textPrimary,
            );
          }
        }
      case "no_with_input":
        {
          if (data?.answer == "no") {
            return TextBodySmall(
              text: "${data?.answer?.capitalize ?? ""}. ${data?.subAnswer ?? ""}",
              color: AppColors.textPrimary,
            );
          } else {
            return TextBodySmall(
              text: data?.answer?.capitalize ?? "",
              color: AppColors.textPrimary,
            );
          }
        }
      case "yes_no":
        {
          return TextBodySmall(
            text: data?.answer?.capitalize ?? "",
            color: AppColors.textPrimary,
          );
        }
      default:
        {
          return const TextBodySmall(
            text: "Not Answer found",
            color: AppColors.textPrimary,
          );
        }
    }
  }
}
