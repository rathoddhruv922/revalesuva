import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:revalesuva/components/custom_Image_viewer.dart';
import 'package:revalesuva/components/custom_click.dart';
import 'package:revalesuva/components/custom_text.dart';
import 'package:revalesuva/generated/assets.dart';
import 'package:revalesuva/model/product_and_recipes/recipe_model.dart' as recipe_model;
import 'package:revalesuva/utils/app_colors.dart';
import 'package:revalesuva/utils/app_corner.dart';
import 'package:revalesuva/utils/navigation_helper.dart';
import 'package:revalesuva/views/product_and_recipes/recipes/recipe_detail_view.dart';

class RecipeItemWidget extends StatelessWidget {
  const RecipeItemWidget({super.key, required this.data, this.isFavourite, required this.onFavourite});

  final recipe_model.Datum data;
  final bool? isFavourite;
  final Function() onFavourite;

  @override
  Widget build(BuildContext context) {
    return CustomClick(
      onTap: () {
        NavigationHelper.pushScreenWithNavBar(
          widget: RecipeDetailView(
            data: data,
            isFavourite: isFavourite,
          ),
          context: context,
        );
      },
      child: Container(

        clipBehavior: Clip.hardEdge,
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: AppColors.surfaceTertiary,
          borderRadius: BorderRadius.circular(AppCorner.listTile),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 80,
              child: AspectRatio(
                aspectRatio: 11 / 10,
                child: ClipRRect(
                  clipBehavior: Clip.hardEdge,
                  borderRadius: BorderRadius.circular(
                    AppCorner.listTileImage,
                  ),
                  child: CustomImageViewer(
                    imageUrl: data.image,
                    errorImage: Image.asset(
                      Assets.imagesPlaceholderImg,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            const Gap(10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextTitleLarge(
                    text: data.name ?? "",
                    maxLine: 1,
                  ),
                  const Gap(8),
                  TextTitleSmall(
                    text: data.category?.name ?? "",
                  ),
                  const Gap(8),
                  Wrap(
                    runSpacing: 5,
                    spacing: 5,
                    children: data.tags?.map(
                          (e) {
                            return Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 1,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.surfaceTertiary,
                                borderRadius: BorderRadius.circular(AppCorner.listTile),
                                border: Border.all(
                                  color: AppColors.borderSecondary,
                                ),
                              ),
                              child: TextBodySmall(
                                text: e,
                                color: AppColors.textPrimary,
                              ),
                            );
                          },
                        ).toList() ??
                        [],
                  ),
                ],
              ),
            ),
            const Gap(10),
            CustomClick(
              onTap: onFavourite,
              child: Image.asset(
                width: 20,
                ((data.favourite ?? false) || (isFavourite ?? false))
                    ? Assets.iconsIcLike
                    : Assets.iconsIcLikeBlank,
              ),
            ),
            const Gap(10),
          ],
        ),
      ),
    );
  }
}
