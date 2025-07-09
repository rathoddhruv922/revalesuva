import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:revalesuva/components/custom_text.dart';
import 'package:revalesuva/utils/app_colors.dart';

class QuestionAnsItemWidget extends StatelessWidget {
  const QuestionAnsItemWidget({super.key, required this.question, required this.ans});

  final String question;
  final String ans;

  @override
  Widget build(BuildContext context) {
    return Column(
      textDirection: Get.locale?.languageCode == "he" ? TextDirection.rtl : TextDirection.ltr,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextTitleSmall(text: question,maxLine: 10,),
        const Gap(5),
        Padding(
          padding: const EdgeInsetsDirectional.only(start: 10),
          child: TextBodySmall(
            text: ans,
            color: AppColors.textPrimary,
          ),
        ),
        const Gap(10),
        const Divider(),
      ],
    );
  }
}
