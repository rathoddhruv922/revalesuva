import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:revalesuva/components/custom_text.dart';
import 'package:revalesuva/components/list_item.dart';
import 'package:revalesuva/generated/assets.dart';
import 'package:revalesuva/utils/app_colors.dart';
import 'package:revalesuva/utils/navigation_helper.dart';
import 'package:revalesuva/utils/strings_constant.dart';
import 'package:revalesuva/views/hadas_strengthening/flexibility/flexibility_category_list_view.dart';
import 'package:revalesuva/views/hadas_strengthening/learning_to_cook/learning_to_cook_list_view.dart';
import 'package:revalesuva/views/hadas_strengthening/strength_training/strength_training_list_view.dart';
import 'package:revalesuva/views/hadas_strengthening/weekly_torah_portion/weekly_torah_portion_list_view.dart';

class HadasStrengtheningView extends StatelessWidget {
  const HadasStrengtheningView({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        NavigationHelper.onBackScreen(widget: const HadasStrengtheningView());
      },
      canPop: true,
      child: Scaffold(
        body: ListView(
          padding: const EdgeInsets.all(20),
          physics: const BouncingScrollPhysics(),
          children: [
            const Gap(10),
            TextHeadlineMedium(
              text: StringConstants.hadasStrengthening,
              color: AppColors.textPrimary,
              letterSpacing: 0,
            ),
            const Gap(20),
            ListItem(
              title: StringConstants.weeklyTorahPortion,
              onTab: () {
                NavigationHelper.pushScreenWithNavBar(
                  widget: const WeeklyTorahPortionListView(),
                  context: context,
                );
              },
              icon: Assets.iconsIcTorahPortion,
            ),
            const Gap(12),
            ListItem(
              title: StringConstants.strengthTraining,
              onTab: () {
                NavigationHelper.pushScreenWithNavBar(
                  widget: const StrengthTrainingListView(),
                  context: context,
                );
              },
              icon: Assets.iconsIcStrength,
            ),
            const Gap(12),
            ListItem(
              title: StringConstants.flexibility,
              onTab: () {
                NavigationHelper.pushScreenWithNavBar(
                  widget: const FlexibilityCategoryListView(),
                  context: context,
                );
              },
              icon: Assets.iconsIcFlexibility,
            ),
            const Gap(12),
            ListItem(
              title: StringConstants.learningToCook,
              onTab: () {
                NavigationHelper.pushScreenWithNavBar(
                  widget: const LearningToCookListView(),
                  context: context,
                );
              },
              icon: Assets.iconsIcRecipe,
            ),
            const Gap(80),
          ],
        ),
      ),
    );
  }
}
