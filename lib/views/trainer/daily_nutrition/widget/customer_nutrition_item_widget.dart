import 'package:flutter/material.dart';
import 'package:revalesuva/components/custom_text.dart';
import 'package:revalesuva/utils/app_colors.dart';
import 'package:revalesuva/utils/strings_constant.dart';

class CustomerNutritionItemWidget extends StatelessWidget {
  const CustomerNutritionItemWidget({
    super.key,
    required this.nutrition, required this.title,
  });

  final String nutrition;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 70,
          child: TextTitleSmall(
            text: title,
            color: AppColors.textSecondary,
          ),
        ),
        Expanded(
          child: TextBodySmall(
            text: nutrition,
            color: AppColors.textPrimary,
          ),
        )
      ],
    );
  }
}
