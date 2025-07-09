import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:revalesuva/components/custom_dropdown.dart';
import 'package:revalesuva/components/custom_text.dart';
import 'package:revalesuva/utils/app_colors.dart';
import 'package:revalesuva/utils/strings_constant.dart';

class InfoDisplayEditDropdownWidget extends StatelessWidget {
  const InfoDisplayEditDropdownWidget({
    super.key,
    required this.title,
    this.value,
    this.onChanged,
    required this.dropdownItems,
  });

  final String title;
  final String? value;
  final ValueChanged<String?>? onChanged;
  final List<String> dropdownItems;

  @override
  Widget build(BuildContext context) {
    return Row(
      textDirection: Get.locale?.languageCode == "he" ? TextDirection.rtl : TextDirection.ltr,
      children: [
        SizedBox(
          width: 60,
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
          child: SimpleDropdownButton(
            hint: StringConstants.city,
            value: value,
            onChanged: onChanged,
            dropdownItems: dropdownItems,
          ),
        )
      ],
    );
  }
}
