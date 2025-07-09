import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:revalesuva/components/custom_text.dart';
import 'package:revalesuva/generated/assets.dart';
import 'package:revalesuva/model/tools/my_achievements/my_achievements_model.dart'
    as my_achievements_model;
import 'package:revalesuva/utils/app_colors.dart';

class AchievementsItem extends StatelessWidget {
  const AchievementsItem({super.key, required this.data});

  final my_achievements_model.Datum data;

  @override
  Widget build(BuildContext context) {
    bool isAchieved = data.isAchived == "true";
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ImageIcon(
          AssetImage(isAchieved ? Assets.iconsIcCheckBox : Assets.iconsIcUnselected),
          size: 20,
          color: isAchieved ? AppColors.iconGreen : AppColors.surfaceQuadruple,
        ),
        const Gap(10),
        Flexible(
          child: Stack(
            alignment: Alignment.center,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: TextBodySmall(
                      text: data.taskToAchieve ?? "",
                      color: AppColors.textPrimary,
                      decoration: isAchieved ? TextDecoration.lineThrough : null,
                    ),
                  ),
                  const Gap(10),
                  SizedBox(
                    width: 80,
                    child: TextBodySmall(
                      text: "${data.taskValue} כוכבים ",
                      textAlign: TextAlign.center,
                      color: AppColors.textPrimary,
                      decoration: isAchieved ? TextDecoration.lineThrough : null,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
