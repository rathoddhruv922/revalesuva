import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:revalesuva/components/custom_text.dart';
import 'package:revalesuva/utils/app_colors.dart';
import 'package:revalesuva/views/my_plan/program_completion_report/widget/heart_slider_widget.dart';

class SummaryFeedbackItemWidget extends StatelessWidget {
  const SummaryFeedbackItemWidget({
    super.key,
    this.value,
    required this.question1,
    required this.question2,
    required this.onChanged,
    this.enable = true,
  });

  final double? value;
  final String question1;
  final String question2;
  final Function(dynamic) onChanged;
  final bool enable;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Gap(5),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: HeartSliderWidget(
            value: value,
            onChanged: onChanged,
            enable: enable,
          ),
        ),
        const Gap(10),
        Row(
          children: [
            Expanded(
              child: TextBodySmall(
                text: question1,
                color: AppColors.textPrimary,
                textAlign: TextAlign.center,
              ),
            ),
            Gap(30.w),
            Expanded(
              child: TextBodySmall(
                text: question2,
                color: AppColors.textPrimary,
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
        const Gap(5),
      ],
    );
  }
}
