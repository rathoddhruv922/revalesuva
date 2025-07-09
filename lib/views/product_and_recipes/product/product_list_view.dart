import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:revalesuva/components/custom_click.dart';
import 'package:revalesuva/components/custom_text.dart';
import 'package:revalesuva/components/custom_text_field.dart';
import 'package:revalesuva/components/half_circle_painter.dart';
import 'package:revalesuva/generated/assets.dart';
import 'package:revalesuva/model/product_and_recipes/category_model.dart' as category_model;
import 'package:revalesuva/utils/app_colors.dart';
import 'package:revalesuva/utils/app_corner.dart';
import 'package:revalesuva/utils/helper_method.dart';
import 'package:revalesuva/utils/navigation_helper.dart';
import 'package:revalesuva/utils/strings_constant.dart';
import 'package:revalesuva/view_models/home/home_view_model.dart';
import 'package:revalesuva/view_models/product_recipes/product_view_model.dart';
import 'package:revalesuva/views/product_and_recipes/product/widget/product_category_list_widget.dart';
import 'package:revalesuva/views/product_and_recipes/product/widget/product_item_widget.dart';
import 'package:revalesuva/views/product_and_recipes/shopping_list/widget/shopping_list_widget.dart';

class ProductListView extends StatefulWidget {
  const ProductListView({super.key});

  @override
  State<ProductListView> createState() => _ProductListViewState();
}

class _ProductListViewState extends State<ProductListView> {
  final ProductViewModel productViewModel = Get.put(ProductViewModel());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        productViewModel.isCategoryLoading.value = true;
        productViewModel.isProductLoading .value = true;
        await productViewModel.fetchAllCategories();
        productViewModel.currentPage.value = 1;
        productViewModel.selectedCategory.value = category_model.Datum();
        productViewModel.isRecommended.value = false;
        productViewModel.listProduct.clear();
        await productViewModel.fetchProduct();
        productViewModel.setupScrollController();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        NavigationHelper.onBackScreen(widget: const ProductListView());
      },
      canPop: true,
      child: Scaffold(
        body: Stack(
          children: [
            Column(
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
                        text: StringConstants.recommendedProducts,
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
                      await productViewModel.fetchAllCategories();
                      productViewModel.currentPage.value = 1;
                      productViewModel.selectedCategory.value = category_model.Datum();
                      productViewModel.isRecommended.value = false;
                      productViewModel.listProduct.clear();
                      await productViewModel.fetchProduct();
                      await productViewModel.setupScrollController();
                    },
                    child: Obx(
                      () => ListView(
                        controller: productViewModel.scrollController,
                        physics: const BouncingScrollPhysics(
                          parent: AlwaysScrollableScrollPhysics(),
                        ),
                        children: [
                          ProductCategoryListWidget(),
                          const Gap(10),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20.0,
                            ),
                            child: CustomTextField(
                              controller: productViewModel.txtSearch,
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
                          const Gap(15),
                          productViewModel.isProductLoading.isTrue
                              ? GridView.builder(
                                  padding: const EdgeInsets.symmetric(horizontal: 20),
                                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 10.0,
                                    mainAxisSpacing: 10.0,
                                    childAspectRatio: 16 / 19,
                                  ),
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: 10,
                                  itemBuilder: (context, index) {
                                    return const CustomShimmer(
                                      height: 100,
                                      width: 100,
                                      radius: AppCorner.listTile,
                                    );
                                  },
                                )
                              : productViewModel.listProduct.isNotEmpty
                                  ? GridView.builder(
                                      padding: const EdgeInsets.symmetric(horizontal: 20),
                                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        crossAxisSpacing: 10.0,
                                        mainAxisSpacing: 10.0,
                                        childAspectRatio: 16 / 19,
                                      ),
                                      physics: const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: productViewModel.listProduct.length,
                                      itemBuilder: (context, index) {
                                        return ProductItemWidget(
                                          data: productViewModel.listProduct[index],
                                        );
                                      },
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
                            () => productViewModel.isLoadingMore.isTrue
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
            Obx(
              () => Get.find<HomeViewModel>().shoppingListItemCount.value != 0
                  ? Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: CustomClick(
                          onTap: () async {
                            await Get.bottomSheet(
                              const Padding(
                                padding: EdgeInsets.only(
                                  top: 20.0,
                                ),
                                child: ShoppingListWidget(),
                              ),
                              backgroundColor: AppColors.surfaceTertiary,
                            );
                            await productViewModel.fetchAllCategories();
                            productViewModel.currentPage.value = 1;
                            productViewModel.selectedCategory.value = category_model.Datum();
                            productViewModel.isRecommended.value = false;
                            productViewModel.listProduct.clear();
                            await productViewModel.fetchProduct();
                            await productViewModel.setupScrollController();
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
            ),
          ],
        ),
      ),
    );
  }
}
