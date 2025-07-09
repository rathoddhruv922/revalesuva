import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:revalesuva/components/custom_button.dart';
import 'package:revalesuva/components/custom_click.dart';
import 'package:revalesuva/components/custom_text.dart';
import 'package:revalesuva/generated/assets.dart';
import 'package:revalesuva/model/tools/nutrition_model/selected_nutrition_data.dart'
    as selected_nutrition_data;
import 'package:revalesuva/utils/app_colors.dart';
import 'package:revalesuva/utils/navigation_helper.dart';
import 'package:revalesuva/utils/strings_constant.dart';
import 'package:revalesuva/view_models/tools/daily_nutrition_view_model.dart';
import 'package:revalesuva/views/tools/daily_nutrition_planning/widget/nutrition_plan_widget.dart';
import 'package:revalesuva/views/weighing_and_measuring/widget/notify_message_widget.dart';

class DailyNutritionPlanningView extends StatefulWidget {
  const DailyNutritionPlanningView({super.key});

  @override
  State<DailyNutritionPlanningView> createState() => _DailyNutritionPlanningViewState();
}

class _DailyNutritionPlanningViewState extends State<DailyNutritionPlanningView> {
  final DailyNutritionViewModel dailyNutritionViewModel = Get.find<DailyNutritionViewModel>();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        await dailyNutritionViewModel.onCreate();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        NavigationHelper.onBackScreen(widget: const DailyNutritionPlanningView());
      },
      canPop: true,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomClick(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: TextBodySmall(
                  text: "< ${StringConstants.backTo} ${StringConstants.tools}",
                  color: AppColors.textPrimary,
                  letterSpacing: 0,
                ),
              ),
              const Gap(10),
              TextHeadlineMedium(
                text: StringConstants.dailyNutritionPlanning,
                color: AppColors.textPrimary,
                letterSpacing: 0,
              ),
              const Gap(12),
              NotifyMessageWidget(
                backgroundColor: AppColors.surfaceError,
                title: StringConstants.theDailyPlanIsSentToTheCoachAtTheEndOfTheDayUpdateWhatYouHaveDne,
                description: "",
                icons: Assets.iconsIcDailyNutritionPlanning,
              ),
              Expanded(
                child: RefreshIndicator(
                  child: ListView(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    physics: const BouncingScrollPhysics(),
                    children: [
                      const Gap(10),
                      Obx(
                        () => NutritionPlanWidget(
                          icon: Assets.iconsIcBreakfast,
                          title: StringConstants.breakfast,
                          mealType: "breakfast",
                          nutritionType: dailyNutritionViewModel.userSelectedData.value.breakfast ??
                              selected_nutrition_data.NutritionType(),
                        ),
                      ),
                      const Gap(10),
                      Obx(
                        () => NutritionPlanWidget(
                          icon: Assets.iconsIcLunch,
                          title: StringConstants.lunch,
                          mealType: "lunch",
                          nutritionType: dailyNutritionViewModel.userSelectedData.value.lunch ??
                              selected_nutrition_data.NutritionType(),
                        ),
                      ),
                      const Gap(10),
                      Obx(
                        () => NutritionPlanWidget(
                          icon: Assets.iconsIcSnacks,
                          title: StringConstants.snacks,
                          mealType: "snacks",
                          nutritionType: dailyNutritionViewModel.userSelectedData.value.snacks ??
                              selected_nutrition_data.NutritionType(),
                        ),
                      ),
                      const Gap(10),
                      Obx(
                        () => NutritionPlanWidget(
                          icon: Assets.iconsIcDinner,
                          title: StringConstants.dinner,
                          mealType: "dinner",
                          nutritionType: dailyNutritionViewModel.userSelectedData.value.dinner ??
                              selected_nutrition_data.NutritionType(),
                        ),
                      ),
                      const Gap(20),
                      SimpleButton(
                        text: StringConstants.sendPlanToCoach,
                        onPressed: () {
                          dailyNutritionViewModel.nutritionSendToCoach();
                        },
                      ),
                      const Gap(80),
                    ],
                  ),
                  onRefresh: () async {
                    dailyNutritionViewModel.onCreate();
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
