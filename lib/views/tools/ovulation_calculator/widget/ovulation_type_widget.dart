import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:revalesuva/components/custom_text.dart';
import 'package:revalesuva/utils/app_colors.dart';

class OvulationTypeWidget extends StatelessWidget {
  const OvulationTypeWidget({super.key, required this.color, required this.isSelected, required this.title});

  final Color color;
  final bool isSelected;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 15,
          height: 15,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            border: Border.all(
              color: AppColors.borderPrimary,
              width: isSelected ? 2 : 1,
              strokeAlign: BorderSide.strokeAlignOutside,
            ),
          ),
        ),
        const Gap(10),
        Flexible(
          child: TextBodySmall(
            text: title,
            color: AppColors.textPrimary,
          ),
        ),
      ],
    );
  }
}
