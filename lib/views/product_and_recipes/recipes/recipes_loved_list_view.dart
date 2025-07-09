import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:revalesuva/components/custom_click.dart';
import 'package:revalesuva/components/custom_text.dart';
import 'package:revalesuva/utils/app_colors.dart';
import 'package:revalesuva/utils/app_corner.dart';
import 'package:revalesuva/utils/helper_method.dart';
import 'package:revalesuva/utils/navigation_helper.dart';
import 'package:revalesuva/utils/strings_constant.dart';
import 'package:revalesuva/view_models/product_recipes/recipe_favorites_view_model.dart';
import 'package:revalesuva/views/product_and_recipes/recipes/widget/recipe_item_widget.dart';

class RecipesLovedListView extends StatefulWidget {
  const RecipesLovedListView({super.key});

  @override
  State<RecipesLovedListView> createState() => _RecipesLovedListViewState();
}

class _RecipesLovedListViewState extends State<RecipesLovedListView> {
  final RecipeFavoritesViewModel recipeFavoritesViewModel = Get.find<RecipeFavoritesViewModel>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        recipeFavoritesViewModel.currentPage.value = 1;
        recipeFavoritesViewModel.listUserFavourite.clear();
        recipeFavoritesViewModel.fetchFavouriteRecipe();
        recipeFavoritesViewModel.setupScrollController();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        NavigationHelper.onBackScreen(widget: const RecipesLovedListView());
      },
      canPop: true,
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Gap(20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomClick(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: TextBodySmall(
                      text: "< ${StringConstants.backTo} ${StringConstants.personalArea}",
                      color: AppColors.textPrimary,
                      letterSpacing: 0,
                    ),
                  ),
                  const Gap(10),
                  TextHeadlineMedium(
                    text: StringConstants.theRecipesILoved,
                    color: AppColors.textPrimary,
                    letterSpacing: 0,
                  ),
                  const Gap(10),
                ],
              ),
            ),
            Expanded(
              child: RefreshIndicator(
                  onRefresh: () async {
                    recipeFavoritesViewModel.currentPage.value = 1;
                    recipeFavoritesViewModel.listUserFavourite.clear();
                    await recipeFavoritesViewModel.fetchFavouriteRecipe();
                  },
                  child: Obx(
                    () => ListView(
                      controller: recipeFavoritesViewModel.recipeScrollController,
                      physics: const BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics(),
                      ),
                      children: [
                        const Gap(10),
                        recipeFavoritesViewModel.isRecipeLoading.isTrue
                            ? ListView.separated(
                                padding: const EdgeInsets.symmetric(horizontal: 20),
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: 10,
                                itemBuilder: (context, index) {
                                  return const CustomShimmer(
                                    height: 80,
                                    radius: AppCorner.listTile,
                                  );
                                },
                                separatorBuilder: (context, index) => const Gap(10),
                              )
                            : recipeFavoritesViewModel.listUserFavourite.isNotEmpty
                                ? ListView.separated(
                                    padding: const EdgeInsets.symmetric(horizontal: 20),
                                    physics: const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: recipeFavoritesViewModel.listUserFavourite.length,
                                    itemBuilder: (context, index) {
                                      return RecipeItemWidget(
                                        data: recipeFavoritesViewModel.listUserFavourite[index],
                                        isFavourite: true,
                                        onFavourite: () async {
                                          bool isSuccess =
                                              await recipeFavoritesViewModel.addRemoveFavourite(
                                                  recipeId: recipeFavoritesViewModel
                                                          .listUserFavourite[index].id ??
                                                      0);
                                          if (isSuccess) {
                                            recipeFavoritesViewModel.listUserFavourite.removeAt(index);
                                            recipeFavoritesViewModel.listUserFavourite.refresh();
                                          }
                                        },
                                      );
                                    },
                                    separatorBuilder: (context, index) => const Gap(10),
                                  )
                                : Container(
                                    alignment: Alignment.center,
                                    height: 30.h,
                                    child: TextHeadlineMedium(
                                      text: StringConstants.noDataFound,
                                    ),
                                  ),
                        const Gap(15),
                        Obx(
                          () => recipeFavoritesViewModel.isRecipeLoadMore.isTrue
                              ? const CupertinoActivityIndicator(
                                  radius: 15,
                                )
                              : const SizedBox(),
                        ),
                        const Gap(10),
                      ],
                    ),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
