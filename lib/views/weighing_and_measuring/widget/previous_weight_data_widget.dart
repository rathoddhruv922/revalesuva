import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:revalesuva/components/custom_text.dart';
import 'package:revalesuva/utils/app_colors.dart';
import 'package:revalesuva/utils/app_corner.dart';
import 'package:revalesuva/utils/helper_method.dart';
import 'package:revalesuva/utils/strings_constant.dart';

class PreviousWeightDataWidget extends StatelessWidget {
  const PreviousWeightDataWidget({super.key, required this.previousDate, required this.lastWeight, required this.lastBMI});

  final String previousDate;
  final String lastWeight;
  final String lastBMI;


  @override
  Widget build(BuildContext context) {
    return CustomCard2(
      color: AppColors.surfaceTertiary,
      child: Column(
        children: [
          TextBodyMedium(
            text: StringConstants.previousWeighInDate.replaceFirst("{}", previousDate),
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
                      text: "BMI ${StringConstants.last} ",
                      color: AppColors.textPrimary,
                    ),
                    const Gap(10),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: AppColors.surfacePurpleLight,
                        borderRadius: BorderRadius.circular(AppCorner.button),
                      ),
                      child: TextTitleSmall(text: lastBMI),
                    )
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextBodyMedium(
                      text: "${StringConstants.weight} ${StringConstants.last} ",
                      color: AppColors.textPrimary,
                    ),
                    const Gap(10),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: AppColors.surfacePurpleLight,
                        borderRadius: BorderRadius.circular(AppCorner.button),
                      ),
                      child: TextTitleSmall(text: lastWeight),
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
