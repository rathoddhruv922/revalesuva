import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:revalesuva/components/custom_Image_viewer.dart';
import 'package:revalesuva/components/custom_text.dart';
import 'package:revalesuva/generated/assets.dart';
import 'package:revalesuva/model/product_and_recipes/category_model.dart' as category_model;
import 'package:revalesuva/utils/app_colors.dart';

class CategoryItemWidget extends StatelessWidget {
  const CategoryItemWidget({
    super.key,
    required this.data,
    this.isDefault = false,
  });

  final category_model.Datum data;
  final bool isDefault;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: 65,
          width: 65,
          clipBehavior: Clip.hardEdge,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: (data.isSelected ?? false)
                ? AppColors.surfaceGreen
                : AppColors.surfaceTertiary,
            shape: BoxShape.circle,
            border: Border.all(
              color: data.isSelected == true ? AppColors.borderGreen : AppColors.borderTertiary,
              strokeAlign: BorderSide.strokeAlignInside,
              width: 3,
            ),
          ),
          child: (data.id ?? 0) < 0
              ? Image.asset(
                  data.image,
                  color: isDefault && (data.isSelected ?? false)
                      ? AppColors.iconTertiary
                      : AppColors.iconPrimary,
                )
              : CustomImageViewer(
                  imageUrl: data.image,
                  errorImage: Image.asset(Assets.iconsIcCrackImg),
                ),
        ),
        const Gap(10),
        SizedBox(
          width: 70,
          child: TextTitleSmall(
            text: data.name ?? "",
            textAlign: TextAlign.center,
            maxLine: 2,
          ),
        )
      ],
    );
  }
}
