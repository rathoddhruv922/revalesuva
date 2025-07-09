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
import 'package:revalesuva/view_models/store/store_favorites_view_model.dart';
import 'package:revalesuva/views/store/widget/store_favorites_item_widget.dart';

class StoreProductLovedListView extends StatefulWidget {
  const StoreProductLovedListView({super.key});

  @override
  State<StoreProductLovedListView> createState() => _StoreProductLovedListViewState();
}

class _StoreProductLovedListViewState extends State<StoreProductLovedListView> {
  final StoreFavoritesViewModel storeFavoritesViewModel = Get.find<StoreFavoritesViewModel>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        storeFavoritesViewModel.currentPage.value = 1;
        storeFavoritesViewModel.listUserStoreFavourite.clear();
        storeFavoritesViewModel.fetchFavouriteStore();
        storeFavoritesViewModel.setupScrollController();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        NavigationHelper.onBackScreen(widget: const StoreProductLovedListView());
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
                    storeFavoritesViewModel.currentPage.value = 1;
                    storeFavoritesViewModel.listUserStoreFavourite.clear();
                    await storeFavoritesViewModel.fetchFavouriteStore();
                  },
                  child: Obx(
                    () => ListView(
                      controller: storeFavoritesViewModel.storeScrollController,
                      physics: const BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics(),
                      ),
                      children: [
                        const Gap(10),
                        storeFavoritesViewModel.isStoreLoading.isTrue
                            ? ListView.separated(
                                padding: const EdgeInsets.symmetric(horizontal: 20),
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: 10,
                                itemBuilder: (context, index) {
                                  return CustomShimmer(
                                    height: 50,
                                    width: 100.w,
                                    radius: AppCorner.listTile,
                                  );
                                },
                                separatorBuilder: (context, index) => const Gap(10),
                              )
                            : storeFavoritesViewModel.listUserStoreFavourite.isNotEmpty
                                ? ListView.separated(
                                    separatorBuilder: (context, index) => const Gap(10),
                                    padding: const EdgeInsets.symmetric(horizontal: 20),
                                    physics: const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: storeFavoritesViewModel.listUserStoreFavourite.length,
                                    itemBuilder: (context, index) {
                                      return StoreFavoritesItemWidget(
                                        data: storeFavoritesViewModel.listUserStoreFavourite[index],
                                        onFavourite: () async {
                                          bool isSuccess = await Get.find<StoreFavoritesViewModel>()
                                              .addRemoveStoreFavourite(
                                                  storeProductId: storeFavoritesViewModel
                                                          .listUserStoreFavourite[index].id ??
                                                      0);
                                          if (isSuccess) {
                                            storeFavoritesViewModel.listUserStoreFavourite
                                                .removeAt(index);
                                            storeFavoritesViewModel.listUserStoreFavourite.refresh();
                                          }
                                        },
                                        isFavourite: true,
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
                          () => storeFavoritesViewModel.isStoreLoadMore.isTrue
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
