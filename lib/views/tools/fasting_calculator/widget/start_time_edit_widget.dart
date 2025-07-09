import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:revalesuva/components/custom_text.dart';
import 'package:revalesuva/components/custom_text_field.dart';
import 'package:revalesuva/utils/app_colors.dart';
import 'package:revalesuva/utils/app_validator.dart';
import 'package:revalesuva/utils/strings_constant.dart';

class StartTimeEditWidget extends StatelessWidget {
  const StartTimeEditWidget(
      {super.key, required this.fieldName, required this.txHours, required this.txMinutes});

  final String fieldName;
  final TextEditingController txHours;
  final TextEditingController txMinutes;

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
          child: CustomTextField(
            hint: StringConstants.minutes,
            controller: txMinutes,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'^\d+(\.\d{0,2})?$')),
              TextInputFormatter.withFunction((oldValue, newValue) {
                if (newValue.text.isEmpty) {
                  return newValue;
                }
                final double? value = double.tryParse(newValue.text);
                if (value != null && value <= 60) {
                  return newValue;
                }
                return oldValue;
              }),
            ],
            textInputType: TextInputType.number,
            validator: (value) => FormValidate.requiredField(
                value, "${StringConstants.minutes} ${StringConstants.required}"),
          ),
        ),
        const Gap(10),
        const TextHeadlineMedium(text: " : "),
        const Gap(10),
        Expanded(
          child: CustomTextField(
            hint: StringConstants.hour,
            controller: txHours,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'^\d+(\.\d{0,2})?$')),
              TextInputFormatter.withFunction((oldValue, newValue) {
                if (newValue.text.isEmpty) {
                  return newValue;
                }
                final double? value = double.tryParse(newValue.text);
                if (value != null && value <= 24) {
                  return newValue;
                }
                return oldValue;
              }),
            ],
            textInputType: TextInputType.number,
            validator: (value) =>
                FormValidate.requiredField(value, "${StringConstants.hour} ${StringConstants.required}"),
          ),
        ),
      ],
    );
  }
}
