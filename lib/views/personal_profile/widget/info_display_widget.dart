import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:revalesuva/components/custom_text.dart';
import 'package:revalesuva/utils/app_colors.dart';

class InfoDisplayWidget extends StatelessWidget {
  const InfoDisplayWidget({super.key, required this.title, required this.value});

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      textDirection: Get.locale?.languageCode == "he" ? TextDirection.rtl : TextDirection.ltr,
      children: [
        TextBodyMedium(
          text: title,
          color: AppColors.textPrimary,
        ),
        const TextBodyMedium(
          text: " : ",
          color: AppColors.textPrimary,
        ),
        Flexible(
          child: TextBodyMedium(
            text: value,
            color: AppColors.textPrimary,
            maxLine: 3,
          ),
        ),
      ],
    );
  }
}
