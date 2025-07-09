import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:revalesuva/components/custom_text.dart';
import 'package:revalesuva/components/custom_text_field.dart';
import 'package:revalesuva/utils/app_colors.dart';

class InfoDisplayEditWidget extends StatelessWidget {
  const InfoDisplayEditWidget({
    super.key,
    required this.title,
    this.controller,
    this.validator,
    this.hint = '',
    this.enabled,
    this.inputFormatters,
    this.textInputType = TextInputType.text,
    this.onEditComplete,
    this.onChange, this.suffixIcon,
    this.size
  });

  final String title;
  final TextEditingController? controller;
  final String? Function(String? value)? validator;
  final String hint;
  final bool? enabled;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType textInputType;
  final void Function()? onEditComplete;
  final void Function(String value)? onChange;
  final Widget? suffixIcon;
  final double? size;

  @override
  Widget build(BuildContext context) {
    return Row(
      textDirection: Get.locale?.languageCode == "he" ? TextDirection.rtl : TextDirection.ltr,
      children: [
        SizedBox(
          width: size ?? 60,
          child: TextBodyMedium(
            text: title,
            color: AppColors.textPrimary,
          ),
        ),
        const TextBodyMedium(
          text: ":",
          color: AppColors.textPrimary,
        ),
        const Gap(10),
        Expanded(
          child: CustomTextField(
            fillColor: enabled == false ? AppColors.lightGray : null,
            controller: controller,
            hint: hint,
            onChange: onChange,
            onEditComplete: onEditComplete,
            validator: validator,
            enabled: enabled,
            inputFormatters: inputFormatters,
            textInputType: textInputType,
            suffixIcon: suffixIcon,
          ),
        )
      ],
    );
  }
}
