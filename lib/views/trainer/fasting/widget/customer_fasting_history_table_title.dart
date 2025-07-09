import 'package:flutter/material.dart';
import 'package:revalesuva/components/custom_text.dart';
import 'package:revalesuva/utils/app_colors.dart';
import 'package:revalesuva/utils/strings_constant.dart';

class CustomerFastingHistoryTableTitle extends StatelessWidget {
  const CustomerFastingHistoryTableTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppColors.surfaceGreen.withValues(alpha: 0.6),
          border: Border.all(
            color: AppColors.borderSecondary.withValues(
              alpha: 0.5,
            ),
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: TextTitleSmall(
                  text: StringConstants.date,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            const VerticalDivider(
              width: 1,
              color: AppColors.borderTertiary,
              endIndent: 0,
              indent: 0,
            ),
            Expanded(
              child: TextTitleSmall(
                text: StringConstants.duration,
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ),
    );
  }
}
