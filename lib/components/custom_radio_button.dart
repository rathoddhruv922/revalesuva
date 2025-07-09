import 'package:flutter/material.dart';
import 'package:revalesuva/components/custom_text.dart';
import 'package:revalesuva/utils/app_colors.dart';

class CustomRadioButton extends StatelessWidget {
  const CustomRadioButton({
    super.key,
    required this.groupValue,
    required this.onChanged,
    required this.value,
    required this.text,
  });

  final String? groupValue;
  final Function(String? value) onChanged;
  final String value;
  final String text;

  @override
  Widget build(BuildContext context) {
    return RadioTheme(
      data: const RadioThemeData(
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        visualDensity: VisualDensity.compact,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Radio(
            value: value,
            activeColor: AppColors.iconGreen,
            groupValue: groupValue,
            onChanged: onChanged,
          ),
          TextBodyMedium(
            text: text,
            color: AppColors.textPrimary,
          )
        ],
      ),
    );
  }
}
