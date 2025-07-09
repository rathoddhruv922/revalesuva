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
import 'package:revalesuva/utils/app_colors.dart';
import 'package:revalesuva/utils/app_corner.dart';
import 'package:revalesuva/utils/default_list.dart';
import 'package:revalesuva/utils/helper_method.dart';
import 'package:revalesuva/utils/navigation_helper.dart';
import 'package:revalesuva/utils/strings_constant.dart';
import 'package:revalesuva/view_models/store/store_favorites_view_model.dart';
import 'package:revalesuva/view_models/store/store_view_model.dart';
import 'package:revalesuva/views/store/widget/store_category_list_widget.dart';
import 'package:revalesuva/views/store/widget/store_item_widget.dart';

class StoreProductListView extends StatefulWidget {
  const StoreProductListView({super.key});

  @override
  State<StoreProductListView> createState() => _StoreProductListViewState();
}

class _StoreProductListViewState extends State<StoreProductListView> {
  final StoreViewModel storeViewModel = Get.put(StoreViewModel());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        storeViewModel.isCategoryLoading.value = true;
        storeViewModel.isStoreProductLoading.value = true;
        await storeViewModel.fetchAllCategories();
        storeViewModel.currentPage.value = 1;
        storeViewModel.listStoreProduct.clear();
        await storeViewModel.fetchStoreProduct();
        storeViewModel.setupScrollController();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        NavigationHelper.onBackScreen(widget: const StoreProductListView());
      },
      canPop: true,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Gap(20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // CustomClick(
                  //   onTap: () {
                  //     Navigator.of(context).pop();
                  //   },
                  //   child: TextBodySmall(
                  //     text: "< ${StringConstants.backTo} ${StringConstants.productsAndRecipes}",
                  //     color: AppColors.textPrimary,
                  //     letterSpacing: 0,
                  //   ),
                  // ),
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
                  await storeViewModel.fetchAllCategories();
                  storeViewModel.currentPage.value = 1;
                  storeViewModel.listStoreProduct.clear();
                  await storeViewModel.fetchStoreProduct();
                  await storeViewModel.setupScrollController();
                },
                child: Obx(
                  () => ListView(
                    controller: storeViewModel.scrollController,
                    physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics(),
                    ),
                    children: [
                      StoreCategoryListWidget(),
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
                                controller: storeViewModel.txtSearch,
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
                              child: SimpleDropdownButton(
                                hint: StringConstants.sortBy,
                                value: storeViewModel.selectedTags.value.isEmpty
                                    ? null
                                    : storeViewModel.selectedTags.value,
                                dropdownItems: DefaultList.sortBy,
                                onChanged: (value) {
                                  storeViewModel.onFilterSelect(value: value);
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Gap(15),
                      storeViewModel.isStoreProductLoading.isTrue
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
                          : storeViewModel.listStoreProduct.isNotEmpty
                              ? GridView.builder(
                                  padding: const EdgeInsets.symmetric(horizontal: 20),
                                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 10.0,
                                    mainAxisSpacing: 10.0,
                                    childAspectRatio: 16 / 22,
                                  ),
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: storeViewModel.listStoreProduct.length,
                                  itemBuilder: (context, index) {
                                    return StoreItemWidget(
                                      data: storeViewModel.listStoreProduct[index],
                                      onFavourite: () async {
                                        bool isSuccess = await Get.find<StoreFavoritesViewModel>()
                                            .addRemoveStoreFavourite(
                                                storeProductId:
                                                    storeViewModel.listStoreProduct[index].id ?? 0);
                                        if (isSuccess) {
                                          storeViewModel.listStoreProduct[index].favourite =
                                              !(storeViewModel.listStoreProduct[index].favourite ??
                                                  true);
                                          storeViewModel.listStoreProduct.refresh();
                                        }
                                      },
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
                        () => storeViewModel.isLoadingMore.isTrue
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
