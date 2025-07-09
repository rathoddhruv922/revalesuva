import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:revalesuva/components/custom_Image_viewer.dart';
import 'package:revalesuva/components/custom_click.dart';
import 'package:revalesuva/components/custom_text.dart';
import 'package:revalesuva/components/half_circle_painter.dart';
import 'package:revalesuva/generated/assets.dart';
import 'package:revalesuva/model/product_and_recipes/recipe_model.dart' as recipe_model;
import 'package:revalesuva/utils/app_colors.dart';
import 'package:revalesuva/utils/app_corner.dart';
import 'package:revalesuva/utils/helper_method.dart';
import 'package:revalesuva/utils/navigation_helper.dart';
import 'package:revalesuva/utils/strings_constant.dart';
import 'package:revalesuva/view_models/home/home_view_model.dart';
import 'package:revalesuva/view_models/product_recipes/recipe_favorites_view_model.dart';
import 'package:revalesuva/views/product_and_recipes/recipes/widget/ingredients_item.dart';
import 'package:revalesuva/views/product_and_recipes/shopping_list/widget/shopping_list_widget.dart';

class RecipeDetailView extends StatefulWidget {
  const RecipeDetailView({super.key, required this.data, this.isFavourite});

  final recipe_model.Datum data;
  final bool? isFavourite;

  @override
  State<RecipeDetailView> createState() => _RecipeDetailViewState();
}

class _RecipeDetailViewState extends State<RecipeDetailView> {
  bool? isFavourite;
  late recipe_model.Datum data;
  bool isShow = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      isFavourite = widget.isFavourite;
      data = widget.data;
      isShow = true;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        NavigationHelper.onBackScreen(
          widget: RecipeDetailView(
            data: data,
          ),
        );
      },
      canPop: true,
      child: Scaffold(
        body: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: CustomClick(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: TextBodySmall(
                      text: "< ${StringConstants.backTo} ${StringConstants.productsAndRecipes}",
                      color: AppColors.textPrimary,
                      letterSpacing: 0,
                    ),
                  ),
                ),
                Expanded(
                  child: ListView(
                    physics: const BouncingScrollPhysics(),
                    children: [
                      AspectRatio(
                        aspectRatio: 22 / 10,
                        child: CustomImageViewer(
                          imageUrl: data.image,
                          errorImage: Image.asset(
                            Assets.imagesPlaceholderImg,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: TextTitleLarge(
                                    text: data.name ?? "",
                                    maxLine: 2,
                                  ),
                                ),
                                CustomClick(
                                  onTap: () async {
                                    bool isSuccess = await Get.find<RecipeFavoritesViewModel>()
                                        .addRemoveFavourite(recipeId: data.id ?? 0);
                                    if (isSuccess) {
                                      if (isFavourite == null) {
                                        data.favourite = !(data.favourite ?? true);
                                      } else {
                                        isFavourite = !(isFavourite ?? true);
                                      }
                                      setState(() {});
                                    }
                                  },
                                  child: Image.asset(
                                    width: 20,
                                    ((data.favourite ?? false) || (isFavourite ?? false))
                                        ? Assets.iconsIcLike
                                        : Assets.iconsIcLikeBlank,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 100.w,
                              child: Column(
                               crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Gap(2),
                                  TextTitleSmall(
                                    text: data.category?.name ?? "",
                                  ),
                                  const Gap(10),
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
                            TextTitleMedium(
                              text: data.subDescription ?? "",
                            ),
                            const Gap(10),
                            if (isShow)
                              CustomCard2(
                                color: AppColors.surfaceTertiary,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        TextTitleMedium(
                                          text: StringConstants.ingredients,
                                        ),
                                        const Gap(10),
                                        Expanded(
                                          child: TextBodySmall(
                                            text: StringConstants.toAddToShoppingList,
                                            color: AppColors.textSecondary.withValues(
                                              alpha: 0.8,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    const Gap(20),
                                    ListView.separated(
                                      shrinkWrap: true,
                                      physics: const NeverScrollableScrollPhysics(),
                                      itemBuilder: (context, index) {
                                        return IngredientsItem(
                                          data: data.ingredients?[index] ?? recipe_model.Ingredient(),
                                        );
                                      },
                                      separatorBuilder: (context, index) => const Gap(15),
                                      itemCount: data.ingredients?.length ?? 0,
                                    ),
                                    // const Gap(20),
                                    // SimpleButton(
                                    //   text: StringConstants.addToShoppingList,
                                    //   onPressed: () {},
                                    // ),
                                  ],
                                ),
                              ),
                            const Gap(10),
                            CustomCard2(
                              color: AppColors.surfaceTertiary,
                              child: SizedBox(
                                width: 100.w,
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: customHtmlWidget(data.description ?? ""),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Gap(50)
                    ],
                  ),
                )
              ],
            ),
            Obx(
              () => Get.find<HomeViewModel>().shoppingListItemCount.value != 0
                  ? Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: CustomClick(
                          onTap: () async {
                            await Get.bottomSheet(
                              PopScope(
                                onPopInvokedWithResult: (didPop, result) async {
                                  isShow = false;
                                  setState(() {});
                                  await Future.delayed(const Duration(seconds: 1));
                                  setState(() {});
                                  isShow = true;
                                },
                                child: const Padding(
                                  padding: EdgeInsets.only(
                                    top: 20.0,
                                  ),
                                  child: ShoppingListWidget(),
                                ),
                              ),
                              backgroundColor: AppColors.surfaceTertiary,
                            );
                          },
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              CustomPaint(
                                size: const Size(100, 15),
                                painter: HalfCirclePainter(color: AppColors.surfaceGreen),
                              ),
                              SizedBox(
                                width: 80,
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 50, top: 5),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Badge(
                                        label: TextBodySmall(
                                            text:
                                                "${Get.find<HomeViewModel>().shoppingListItemCount.value}"),
                                        child: const ImageIcon(
                                          AssetImage(Assets.iconsIcShoppingList),
                                          color: Colors.white,
                                          size: 25,
                                        ),
                                      ),
                                      const Gap(2),
                                      TextBodySmall(
                                        text: StringConstants.toShoppingList,
                                        textAlign: TextAlign.center,
                                        size: -1,
                                        maxLine: 1,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  : const SizedBox(),
            )
          ],
        ),
      ),
    );
  }
}
