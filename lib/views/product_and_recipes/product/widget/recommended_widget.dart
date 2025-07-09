import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:revalesuva/components/custom_text.dart';
import 'package:revalesuva/utils/app_colors.dart';
import 'package:revalesuva/utils/strings_constant.dart';

class RecommendedWidget extends StatelessWidget {
  const RecommendedWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return PositionedDirectional(
      top: 4.w,
      start: -8.w,
      child: Transform.rotate(
        angle: 0.8,
        child: Container(
          width: 120,
          padding: const EdgeInsets.all(2),
          color: AppColors.surfaceGreen,
          child: TextBodyMedium(
            textAlign: TextAlign.center,
            text: StringConstants.recommended,
          ),
        ),
      ),
    );
  }
}
