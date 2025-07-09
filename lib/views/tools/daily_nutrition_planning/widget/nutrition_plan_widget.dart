import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:revalesuva/components/custom_text.dart';
import 'package:revalesuva/generated/assets.dart';
import 'package:revalesuva/model/tools/nutrition_model/selected_nutrition_data.dart' as selected_nutrition_data;
import 'package:revalesuva/utils/app_colors.dart';
import 'package:revalesuva/utils/helper_method.dart';
import 'package:revalesuva/utils/strings_constant.dart';
import 'package:revalesuva/view_models/tools/daily_nutrition_view_model.dart';
import 'package:revalesuva/views/tools/daily_nutrition_planning/widget/bottom_sheet_widget.dart';
import 'package:revalesuva/views/tools/daily_nutrition_planning/widget/nutrition_plan_item_widget.dart';

class NutritionPlanWidget extends StatelessWidget {
  NutritionPlanWidget({
    super.key,
    required this.title,
    required this.icon,
    required this.mealType,
    required this.nutritionType,
  });

  final String title;
  final String icon;
  final String mealType;
  final selected_nutrition_data.NutritionType nutritionType;

  final DailyNutritionViewModel dailyNutritionViewModel = Get.find<DailyNutritionViewModel>();

  @override
  Widget build(BuildContext context) {
    return CustomCard2(
      color: AppColors.surfaceTertiary,
      child: Column(
        children: [
          Row(
            children: [
              ImageIcon(
                AssetImage(icon),
              ),
              const Gap(10),
              Expanded(
                child: TextTitleMedium(
                  text: title,
                ),
              ),
              TextBodySmall(
                text: StringConstants.markIfDone,
                color: AppColors.textPrimary,
              ),
              const Gap(5),
              const ImageIcon(
                AssetImage(
                  Assets.iconsIcMark,
                ),
                size: 15,
              ),
            ],
          ),
          const Gap(10),
          NutritionPlanItemWidget(
            hint: StringConstants.vegetables,
            selectedValue: nutritionType.vegetables?.nutritionName ?? "",
            status: nutritionType.vegetables?.status ?? "",
            onTap: () {
              Get.bottomSheet(
                BottomSheetWidget(
                  foodType: title,
                  nutritionType: StringConstants.vegetables,
                  nutritionList: dailyNutritionViewModel.listVegetableNutrition,
                  foodTypeKey: mealType,
                ),
              );
            },
            onStatusChanged: () {
              if (nutritionType.vegetables?.status != "pending") {
                if (nutritionType.vegetables?.status == "approved") {
                  dailyNutritionViewModel.changeNutritionStatus(
                      status: "completed", ids: nutritionType.vegetables?.nutritionId ?? [], mealType: mealType);
                } else {
                  dailyNutritionViewModel.changeNutritionStatus(
                      status: "approved", ids: nutritionType.vegetables?.nutritionId ?? [], mealType: mealType);
                }
              }
            },
          ),
          const Gap(10),
          NutritionPlanItemWidget(
            hint: StringConstants.proteins,
            selectedValue: nutritionType.proteins?.nutritionName ?? "",
            status: nutritionType.proteins?.status ?? "",
            onTap: () {
              Get.bottomSheet(
                BottomSheetWidget(
                  foodType: title,
                  nutritionType: StringConstants.proteins,
                  nutritionList: dailyNutritionViewModel.listProteinNutrition,
                  foodTypeKey: mealType,
                ),
              );
            },
            onStatusChanged: () {
              if (nutritionType.proteins?.status != "pending") {
                if (nutritionType.proteins?.status == "approved") {
                  dailyNutritionViewModel.changeNutritionStatus(
                      status: "completed", ids: nutritionType.proteins?.nutritionId ?? [], mealType: mealType);
                } else {
                  dailyNutritionViewModel.changeNutritionStatus(
                      status: "approved", ids: nutritionType.proteins?.nutritionId ?? [], mealType: mealType);
                }
              }
            },
          ),
          const Gap(10),
          NutritionPlanItemWidget(
            hint: StringConstants.carbohydrates,
            selectedValue: nutritionType.carbohydrates?.nutritionName ?? "",
            status: nutritionType.carbohydrates?.status ?? "",
            onTap: () {
              Get.bottomSheet(
                BottomSheetWidget(
                  foodType: title,
                  nutritionType: StringConstants.carbohydrates,
                  nutritionList: dailyNutritionViewModel.listCarbsNutrition,
                  foodTypeKey: mealType,
                ),
              );
            },
            onStatusChanged: () {
              if (nutritionType.carbohydrates?.status != "pending") {
                if (nutritionType.carbohydrates?.status == "approved") {
                  dailyNutritionViewModel.changeNutritionStatus(
                      status: "completed", ids: nutritionType.carbohydrates?.nutritionId ?? [], mealType: mealType);
                } else {
                  dailyNutritionViewModel.changeNutritionStatus(
                      status: "approved", ids: nutritionType.carbohydrates?.nutritionId ?? [], mealType: mealType);
                }
              }
            },
          ),
          const Gap(10),
          NutritionPlanItemWidget(
            hint: StringConstants.fats,
            selectedValue: nutritionType.fats?.nutritionName ?? "",
            status: nutritionType.fats?.status ?? "",
            onTap: () {
              Get.bottomSheet(
                BottomSheetWidget(
                  foodType: title,
                  nutritionType: StringConstants.fats,
                  nutritionList: dailyNutritionViewModel.listFatsNutrition,
                  foodTypeKey: mealType,
                ),
              );
            },
            onStatusChanged: () {
              if (nutritionType.fats?.status != "pending") {
                if (nutritionType.fats?.status == "approved") {
                  dailyNutritionViewModel.changeNutritionStatus(
                      status: "completed", ids: nutritionType.fats?.nutritionId ?? [], mealType: mealType);
                } else {
                  dailyNutritionViewModel.changeNutritionStatus(
                      status: "approved", ids: nutritionType.fats?.nutritionId ?? [], mealType: mealType);
                }
              }
            },
          ),
          const Gap(10),
        ],
      ),
    );
  }
}
