import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:revalesuva/components/custom_click.dart';
import 'package:revalesuva/utils/helper_method.dart';
import 'package:revalesuva/view_models/product_recipes/product_view_model.dart';
import 'package:revalesuva/views/product_and_recipes/product/widget/category_item_widget.dart';

class ProductCategoryListWidget extends StatelessWidget {
  ProductCategoryListWidget({
    super.key,
  });

  final ProductViewModel productViewModel = Get.find<ProductViewModel>();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Obx(
        () => productViewModel.isCategoryLoading.isTrue
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
            : productViewModel.listCategory.isNotEmpty
                ? ListView(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics(),
                    ),
                    children: [
                      const Gap(20),
                      // InkWell(
                      //   splashColor: Colors.transparent,
                      //   onTap: () {
                      //     productViewModel.selectedCategory.value = category_model.Datum();
                      //     productViewModel.onCategorySelect(index: -1);
                      //     productViewModel.onDefaultSelect(value: false);
                      //   },
                      //   child: CategoryItemWidget(
                      //     data: category_model.Datum(
                      //       id: -1,
                      //       updatedAt: "",
                      //       createdAt: "",
                      //       isActive: 1,
                      //       name: StringConstants.allProducts,
                      //       image: Assets.iconsIcAllProduct,
                      //       isSelected: !productViewModel.isRecommended.value,
                      //     ),
                      //     isDefault: true,
                      //   ),
                      // ),
                      // const Gap(10),
                      // InkWell(
                      //   splashColor: Colors.transparent,
                      //   onTap: () {
                      //     productViewModel.selectedCategory.value = category_model.Datum();
                      //     productViewModel.onCategorySelect(index: -1);
                      //     productViewModel.onDefaultSelect(value: true);
                      //   },
                      //   child: CategoryItemWidget(
                      //     data: category_model.Datum(
                      //       id: -1,
                      //       updatedAt: "",
                      //       createdAt: "",
                      //       isActive: 1,
                      //       name: StringConstants.recommended,
                      //       image: Assets.iconsIcRecipe,
                      //       isSelected: productViewModel.isRecommended.value,
                      //     ),
                      //     isDefault: true,
                      //   ),
                      // ),
                      ListView.separated(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return CustomClick(
                            splashColor: Colors.transparent,
                            onTap: () {
                              productViewModel.onCategorySelect(index: index);
                            },
                            child: CategoryItemWidget(
                              data: productViewModel.listCategory[index],
                              isDefault: (productViewModel.listCategory[index].id ?? 0) < 0,
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const Gap(15);
                        },
                        itemCount: productViewModel.listCategory.length,
                      ),
                    ],
                  )
                : const SizedBox(),
      ),
    );
  }
}
