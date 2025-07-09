import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:revalesuva/components/custom_click.dart';
import 'package:revalesuva/utils/helper_method.dart';
import 'package:revalesuva/view_models/product_recipes/recipe_view_model.dart';
import 'package:revalesuva/views/product_and_recipes/product/widget/category_item_widget.dart';

class RecipeCategoryListWidget extends StatelessWidget {
  RecipeCategoryListWidget({
    super.key,
  });

  final RecipeViewModel recipeViewModel = Get.find<RecipeViewModel>();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Obx(
        () => recipeViewModel.isCategoryLoading.isTrue
            ? ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: 5,
                itemBuilder: (context, index) {
                  return const Column(
                    children: [
                      CustomShimmer(
                        height: 60,
                        width: 60,
                        shape: BoxShape.circle,
                      ),
                      Gap(10),
                      CustomShimmer(
                        height: 10,
                        width: 60,
                        radius: 5,
                      ),
                    ],
                  );
                },
                separatorBuilder: (context, index) {
                  return const Gap(15);
                },
              )
            : recipeViewModel.listCategory.isNotEmpty
                ? ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return CustomClick(
                        splashColor: Colors.transparent,
                        onTap: () {
                          recipeViewModel.onCategorySelect(index: index);
                        },
                        child: CategoryItemWidget(
                          data: recipeViewModel.listCategory[index],
                          isDefault: recipeViewModel.listCategory[index].id == -1,
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const Gap(15);
                    },
                    itemCount: recipeViewModel.listCategory.length,
                  )
                : const SizedBox(),
      ),
    );
  }
}
