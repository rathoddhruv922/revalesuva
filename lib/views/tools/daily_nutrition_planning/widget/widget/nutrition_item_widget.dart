import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:revalesuva/components/custom_text.dart';
import 'package:revalesuva/model/tools/nutrition_model/nutrition_model.dart' as nutrition_model;
import 'package:revalesuva/model/tools/nutrition_model/user_nutrition_model.dart' as user_nutrition_model;
import 'package:revalesuva/utils/app_colors.dart';
import 'package:revalesuva/utils/strings_constant.dart';
import 'package:revalesuva/view_models/tools/daily_nutrition_view_model.dart';

class NutritionItemWidget extends StatelessWidget {
  NutritionItemWidget({
    super.key,
    required this.data,
    required this.foodType,
  });

  final nutrition_model.Datum data;
  final String foodType;
  final DailyNutritionViewModel dailyNutritionViewModel = Get.find<DailyNutritionViewModel>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        user_nutrition_model.Datum? userData = dailyNutritionViewModel.listUserNutrition.firstWhereOrNull(
          (element) => element.nutrition?.name == data.name && element.foodType?.toLowerCase() == foodType.toLowerCase(),
        );
        user_nutrition_model.Datum? mailUserData = dailyNutritionViewModel.listMainUserNutrition.firstWhereOrNull(
              (element) => element.nutrition?.name == data.name && element.foodType?.toLowerCase() == foodType.toLowerCase(),
        );
        return ColoredBox(
          color: (userData != null) ? AppColors.lightGray : AppColors.surfaceTertiary,
          child: SizedBox(
            height: 40,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CheckboxTheme(
                  data: CheckboxThemeData(
                    side: const BorderSide(color: AppColors.borderSecondary),
                    fillColor: WidgetStatePropertyAll(
                      data.isActive == 0 ? AppColors.lightGray : AppColors.iconTertiary,
                    ),
                  ),
                  child: Checkbox(
                    activeColor: AppColors.surfaceGreen,
                    value: userData != null,
                    onChanged: (value) {
                      if (data.isActive != 0) {
                        if (userData != null) {
                          dailyNutritionViewModel.listUserNutrition.remove(userData);
                        } else {
                          dailyNutritionViewModel.listUserNutrition.add(
                            user_nutrition_model.Datum(
                              nutritionId: data.id,
                              foodType: foodType,
                              status: mailUserData?.status ?? "pending",
                              nutrition: user_nutrition_model.Nutrition(
                                id: data.id,
                                nutritionType: data.nutritionType,
                                color: data.color,
                                name: data.name,
                                isActive: data.isActive,
                                createdAt: data.createdAt,
                                updatedAt: data.updatedAt,
                              ),
                            ),
                          );
                        }
                      }
                      dailyNutritionViewModel.listUserNutrition.refresh();
                    },
                  ),
                ),
                Expanded(
                  child: data.isActive == 0
                      ? TextBodyMedium(
                          text: data.name ?? "",
                          color: AppColors.textError,
                        )
                      : TextTitleMedium(
                          text: data.name ?? "",
                          color: AppColors.textPrimary,
                        ),
                ),
                if (data.isActive == 0)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: TextBodySmall(
                      text: StringConstants.cannotSelect,
                      color: AppColors.textError,
                    ),
                  )
              ],
            ),
          ),
        );
      },
    );
  }
}
