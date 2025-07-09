import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:revalesuva/components/custom_click.dart';
import 'package:revalesuva/components/custom_dropdown.dart';
import 'package:revalesuva/components/custom_text.dart';
import 'package:revalesuva/components/custom_text_field.dart';
import 'package:revalesuva/generated/assets.dart';
import 'package:revalesuva/model/product_and_recipes/category_model.dart' as category_model;
import 'package:revalesuva/utils/app_colors.dart';
import 'package:revalesuva/utils/app_corner.dart';
import 'package:revalesuva/utils/helper_method.dart';
import 'package:revalesuva/utils/navigation_helper.dart';
import 'package:revalesuva/utils/strings_constant.dart';
import 'package:revalesuva/view_models/product_recipes/recipe_favorites_view_model.dart';
import 'package:revalesuva/view_models/product_recipes/recipe_view_model.dart';
import 'package:revalesuva/views/product_and_recipes/recipes/widget/recipe_category_list_widget.dart';
import 'package:revalesuva/views/product_and_recipes/recipes/widget/recipe_item_widget.dart';

class RecipeListView extends StatefulWidget {
  const RecipeListView({super.key});

  @override
  State<RecipeListView> createState() => _RecipeListViewState();
}

class _RecipeListViewState extends State<RecipeListView> {
  final RecipeViewModel recipeViewModel = Get.put(RecipeViewModel());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        recipeViewModel.isCategoryLoading.value = true;
        recipeViewModel.isRecipeLoading.value = true;
        await recipeViewModel.fetchAllCategories();
        await recipeViewModel.fetchFilterTags();
        recipeViewModel.currentPage.value = 1;
        recipeViewModel.selectedCategory.value = category_model.Datum();
        recipeViewModel.selectedTagForApi.value = "";
        recipeViewModel.txtSearch.text = "";
        recipeViewModel.listRecipe.clear();
        await recipeViewModel.fetchRecipe();
        await recipeViewModel.setupScrollController();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        NavigationHelper.onBackScreen(widget: const RecipeListView());
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
                      text: "< ${StringConstants.backTo} ${StringConstants.productsAndRecipes}",
                      color: AppColors.textPrimary,
                      letterSpacing: 0,
                    ),
                  ),
                  const Gap(10),
                  TextHeadlineMedium(
                    text: StringConstants.recipes,
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
                  await recipeViewModel.fetchAllCategories();
                  await recipeViewModel.fetchFilterTags();
                  recipeViewModel.currentPage.value = 1;
                  recipeViewModel.selectedCategory.value = category_model.Datum();
                  recipeViewModel.selectedTagForApi.value = "";
                  //recipeViewModel.selectedTags.value = "";
                  recipeViewModel.txtSearch.text = "";
                  recipeViewModel.listRecipe.clear();
                  await recipeViewModel.fetchRecipe();
                },
                child: Obx(
                  () => ListView(
                    controller: recipeViewModel.scrollController,
                    physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics(),
                    ),
                    children: [
                      RecipeCategoryListWidget(),
                      const Gap(10),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20.0,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Expanded(
                              child: CustomTextField(
                                controller: recipeViewModel.txtSearch,
                                hint: StringConstants.searchByFreeText,
                                suffixIcon: const Padding(
                                  padding: EdgeInsetsDirectional.only(end: 15.0),
                                  child: ImageIcon(
                                    AssetImage(Assets.iconsIcSearch),
                                    color: AppColors.iconPrimary,
                                  ),
                                ),
                              ),
                            ),
                            const Gap(10),
                            SizedBox(
                              width: 35.w,
                              child: Obx(
                                () => SimpleCheckBoxDropdownButton(
                                  hint: StringConstants.filterBy,
                                  dropdownItems: recipeViewModel.tagList,
                                  onChanged: (value) {
                                    recipeViewModel.onFilterSelect(value: value);
                                  },
                                  selectedValues: recipeViewModel.selectedTags.isEmpty
                                      ? []
                                      : recipeViewModel.selectedTags.value,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Gap(15),
                      recipeViewModel.isRecipeLoading.isTrue
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
                          : recipeViewModel.listRecipe.isNotEmpty
                              ? ListView.separated(
                                  padding: const EdgeInsets.symmetric(horizontal: 20),
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: recipeViewModel.listRecipe.length,
                                  itemBuilder: (context, index) {
                                    return RecipeItemWidget(
                                      data: recipeViewModel.listRecipe[index],
                                      onFavourite: () async {
                                        bool isSuccess = await Get.find<RecipeFavoritesViewModel>()
                                            .addRemoveFavourite(
                                                recipeId: recipeViewModel.listRecipe[index].id ?? 0);
                                        if (isSuccess) {
                                          recipeViewModel.listRecipe[index].favourite =
                                              !(recipeViewModel.listRecipe[index].favourite ?? true);
                                          recipeViewModel.listRecipe.refresh();
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
                        () => recipeViewModel.isLoadingMore.isTrue
                            ? const CupertinoActivityIndicator(
                                radius: 15,
                              )
                            : const SizedBox(),
                      ),
                      const Gap(10),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
