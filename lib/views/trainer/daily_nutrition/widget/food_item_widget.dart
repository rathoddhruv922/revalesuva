import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:revalesuva/components/custom_text.dart';
import 'package:revalesuva/model/tools/nutrition_model/selected_nutrition_data.dart'
    as selected_nutrition_data;
import 'package:revalesuva/utils/app_colors.dart';
import 'package:revalesuva/utils/helper_method.dart';
import 'package:revalesuva/utils/strings_constant.dart';
import 'package:revalesuva/views/trainer/daily_nutrition/widget/customer_nutrition_item_widget.dart';

class FoodItemWidget extends StatelessWidget {
  const FoodItemWidget({super.key, required this.nutritionType, required this.foodType});

  final selected_nutrition_data.NutritionType nutritionType;
  final String foodType;

  @override
  Widget build(BuildContext context) {
    return CustomCard2(
      color: AppColors.surfaceTertiary,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextTitleMedium(
              text: foodType,
            ),
            const Gap(10),
            CustomerNutritionItemWidget(
              title: "${StringConstants.vegetables} :",
              nutrition: nutritionType.vegetables?.nutritionName ?? "",
            ),
            const Gap(10),
            CustomerNutritionItemWidget(
              title: "${StringConstants.proteins} :",
              nutrition: nutritionType.proteins?.nutritionName ?? "",
            ),
            const Gap(10),
            CustomerNutritionItemWidget(
              title: "${StringConstants.carbohydrates} :",
              nutrition: nutritionType.carbohydrates?.nutritionName ?? "",
            ),
            const Gap(10),
            CustomerNutritionItemWidget(
              title: "${StringConstants.fats} :",
              nutrition: nutritionType.fats?.nutritionName ?? "",
            ),
            const Gap(10),
          ],
        ),
      ),
    );
  }
}
