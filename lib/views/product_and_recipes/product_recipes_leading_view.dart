import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:revalesuva/components/custom_text.dart';
import 'package:revalesuva/components/list_item.dart';
import 'package:revalesuva/generated/assets.dart';
import 'package:revalesuva/utils/app_colors.dart';
import 'package:revalesuva/utils/navigation_helper.dart';
import 'package:revalesuva/utils/strings_constant.dart';
import 'package:revalesuva/views/product_and_recipes/product/product_list_view.dart';
import 'package:revalesuva/views/product_and_recipes/recipes/recipe_list_view.dart';

class ProductRecipesLeadingView extends StatelessWidget {
  const ProductRecipesLeadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        NavigationHelper.onBackScreen(widget: const ProductRecipesLeadingView());
      },
      canPop: true,
      child: Scaffold(
        body: ListView(
          padding: const EdgeInsets.all(20),
          physics: const BouncingScrollPhysics(),
          children: [
            const Gap(10),
            TextHeadlineMedium(
              text: StringConstants.productsAndRecipes,
              color: AppColors.textPrimary,
              letterSpacing: 0,
            ),
            const Gap(12),
            ListItem(
              title: StringConstants.recommendedProducts,
              onTab: () {
                NavigationHelper.pushScreenWithNavBar(
                  widget: const ProductListView(),
                  context: context,
                );
              },
              icon: Assets.iconsIcProduct,
            ),
            const Gap(12),
            ListItem(
              title: StringConstants.recipes,
              onTab: () {
                NavigationHelper.pushScreenWithNavBar(
                  widget: const RecipeListView(),
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
