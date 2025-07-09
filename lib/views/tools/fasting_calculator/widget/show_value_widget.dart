import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:revalesuva/components/custom_text.dart';
import 'package:revalesuva/utils/app_colors.dart';

class ShowValueWidget extends StatelessWidget {
  const ShowValueWidget({super.key, required this.fieldName, required this.value});

  final String fieldName;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 15.w,
          child: TextTitleMedium(
            text: fieldName,
            color: AppColors.textPrimary,
          ),
        ),
        const Gap(20),
        Expanded(
          child: TextTitleMedium(
            text: value,
            color: AppColors.textPrimary,
          ),
        ),
      ],
    );
  }
}
