import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:revalesuva/components/custom_button.dart';
import 'package:revalesuva/components/custom_text.dart';
import 'package:revalesuva/components/custom_text_field.dart';
import 'package:revalesuva/generated/assets.dart';
import 'package:revalesuva/model/tools/nutrition_model/nutrition_model.dart' as nutrition_model;
import 'package:revalesuva/utils/app_colors.dart';
import 'package:revalesuva/utils/strings_constant.dart';
import 'package:revalesuva/view_models/tools/daily_nutrition_view_model.dart';
import 'package:revalesuva/view_models/tools/vegetable_challenge_view_model.dart';
import 'package:revalesuva/views/tools/vegetable_challenge/widget/challenge_nutrition_item_widget.dart';

class ChallengeBottomSheetWidget extends StatefulWidget {
  const ChallengeBottomSheetWidget({
    super.key,
    required this.nutritionList,
    required this.title,
  });

  final String title;
  final List<nutrition_model.Datum> nutritionList;

  @override
  State<ChallengeBottomSheetWidget> createState() => _ChallengeBottomSheetWidgetState();
}

class _ChallengeBottomSheetWidgetState extends State<ChallengeBottomSheetWidget> {
  List<nutrition_model.Datum> _filteredNutritionList = [];

  final VegetableChallengeViewModel vegetableChallengeViewModel = Get.find<VegetableChallengeViewModel>();
  @override
  void initState() {
    super.initState();
    _filteredNutritionList = widget.nutritionList;
  }

  void _filterNutritionList(String query) {
    setState(() {
      _filteredNutritionList = widget.nutritionList
          .where((nutrition) => nutrition.name?.toLowerCase().contains(query.toLowerCase()) ?? false)
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomSheet(
      backgroundColor: AppColors.surfaceTertiary,
      builder: (context) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
              child: Row(
                children: [
                  Expanded(
                    child: TextTitleLarge(
                      text: widget.title,
                    ),
                  ),
                  SimpleButton(
                    text: StringConstants.confirm,
                    onPressed: () {
                      vegetableChallengeViewModel.selectedNutritionShow();
                      if (Get.isBottomSheetOpen ?? false) {
                        Get.back();
                      }
                    },
                  ),
                ],
              ),
            ),
            const Gap(10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: CustomTextField(
                onChange: (value) {
                  _filterNutritionList(value);
                },
                hint: StringConstants.searchByFreeText,
                suffixIcon: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: ImageIcon(
                    AssetImage(Assets.iconsIcSearch),
                    color: AppColors.iconPrimary,
                  ),
                ),
              ),
            ),
            const Gap(10),
            Expanded(
              child: ListView.separated(
                itemBuilder: (context, index) {
                  return ChallengeNutritionItemWidget(
                    data: _filteredNutritionList[index],
                  );
                },
                separatorBuilder: (context, index) {
                  return Divider(
                    color: AppColors.lightGray,
                    height: 0,
                  );
                },
                itemCount: _filteredNutritionList.length,
              ),
            ),
          ],
        );
      },
      onClosing: () {},
    );
  }
}
