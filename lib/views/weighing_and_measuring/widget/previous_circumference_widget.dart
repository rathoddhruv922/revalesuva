import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:revalesuva/components/custom_text.dart';
import 'package:revalesuva/utils/app_colors.dart';
import 'package:revalesuva/utils/app_corner.dart';
import 'package:revalesuva/utils/helper_method.dart';
import 'package:revalesuva/utils/strings_constant.dart';

class PreviousCircumferenceWidget extends StatelessWidget {
  const PreviousCircumferenceWidget(
      {super.key,
      required this.previousDate,
      required this.lastChest,
      required this.lastAbdominal,
      required this.lastHipLine});

  final String previousDate;
  final String lastChest;
  final String lastAbdominal;
  final String lastHipLine;

  @override
  Widget build(BuildContext context) {
    return CustomCard2(
      color: AppColors.surfaceTertiary,
      child: Column(
        children: [
          TextBodyMedium(
            text: StringConstants.previousWeighInDate.replaceAll("{}", previousDate),
            color: AppColors.textPrimary,
          ),
          const Gap(10),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextBodyMedium(
                      text: StringConstants.lastChestLine,
                      color: AppColors.textPrimary,
                    ),
                    const Gap(10),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: AppColors.surfacePurpleLight,
                        borderRadius: BorderRadius.circular(AppCorner.button),
                      ),
                      child: TextTitleSmall(text: lastChest),
                    )
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextBodyMedium(
                      text: StringConstants.lastAbdominalLine,
                      color: AppColors.textPrimary,
                    ),
                    const Gap(10),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: AppColors.surfacePurpleLight,
                        borderRadius: BorderRadius.circular(AppCorner.button),
                      ),
                      child: TextTitleSmall(text: lastAbdominal),
                    )
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextBodyMedium(
                      text: StringConstants.lastHipLine,
                      color: AppColors.textPrimary,
                    ),
                    const Gap(10),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: AppColors.surfacePurpleLight,
                        borderRadius: BorderRadius.circular(AppCorner.button),
                      ),
                      child: TextTitleSmall(text: lastHipLine),
                    )
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
