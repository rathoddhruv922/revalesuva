import 'package:flutter/material.dart';
import 'package:revalesuva/components/custom_click.dart';
import 'package:revalesuva/components/custom_text_field.dart';
import 'package:revalesuva/generated/assets.dart';
import 'package:revalesuva/utils/app_colors.dart';

class ChallengeDropdownWidget extends StatelessWidget {
  const ChallengeDropdownWidget({
    super.key,
    required this.hint,
    required this.onTap,
    required this.selectedValue,
  });

  final String hint;
  final Function() onTap;
  final String selectedValue;

  @override
  Widget build(BuildContext context) {
    return CustomClick(
      onTap: onTap,
      child: CustomTextField(
        hint: hint,
        enabled: false,
        controller: TextEditingController(text: selectedValue),
        suffixIcon: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: ImageIcon(
            AssetImage(
              Assets.iconsIcDownArrow,
            ),
            color: AppColors.iconPrimary,
            size: 15,
          ),
        ),
      ),
    );
  }
}
