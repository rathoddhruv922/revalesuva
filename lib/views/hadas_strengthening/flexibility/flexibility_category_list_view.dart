import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:revalesuva/components/custom_click.dart';
import 'package:revalesuva/components/custom_text.dart';
import 'package:revalesuva/generated/assets.dart';
import 'package:revalesuva/utils/app_colors.dart';
import 'package:revalesuva/utils/app_corner.dart';
import 'package:revalesuva/utils/helper_method.dart';
import 'package:revalesuva/utils/navigation_helper.dart';
import 'package:revalesuva/utils/strings_constant.dart';
import 'package:revalesuva/view_models/hadas_strengthening/flexibility_view_model.dart';
import 'package:revalesuva/views/hadas_strengthening/flexibility/flexibility_list_view.dart';

class FlexibilityCategoryListView extends StatefulWidget {
  const FlexibilityCategoryListView({super.key});

  @override
  State<FlexibilityCategoryListView> createState() => _FlexibilityCategoryListViewState();
}

class _FlexibilityCategoryListViewState extends State<FlexibilityCategoryListView> {
  final FlexibilityViewModel flexibilityViewModel = Get.put(FlexibilityViewModel());
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _initScrollController();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        _onRefresh();
      },
    );
  }

  void _initScrollController() {
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent &&
        !flexibilityViewModel.isLoadingMore.value) {
      flexibilityViewModel.categoryCurrentPage.value++;
      flexibilityViewModel.fetchCategory(isLoadMore: true);
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _onRefresh() async {
    flexibilityViewModel.categoryCurrentPage.value = 1;
    flexibilityViewModel.listCategory.clear();
    flexibilityViewModel.fetchCategory();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        NavigationHelper.onBackScreen(widget: const FlexibilityCategoryListView());
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
                      text: "< ${StringConstants.backTo} ${StringConstants.hadasStrengthening}",
                      color: AppColors.textPrimary,
                      letterSpacing: 0,
                    ),
                  ),
                  const Gap(10),
                  TextHeadlineMedium(
                    text: StringConstants.flexibility,
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
                    _onRefresh();
                  },
                  child: Obx(
                    () => ListView(
                      controller: _scrollController,
                      physics: const BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics(),
                      ),
                      children: [
                        const Gap(10),
                        flexibilityViewModel.isLoadingCategory.isTrue
                            ? ListView.separated(
                                padding: const EdgeInsets.symmetric(horizontal: 20),
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: 10,
                                itemBuilder: (context, index) {
                                  return const CustomShimmer(
                                    height: 50,
                                    radius: AppCorner.listTile,
                                  );
                                },
                                separatorBuilder: (context, index) => const Gap(10),
                              )
                            : flexibilityViewModel.listCategory.isNotEmpty
                                ? ListView.separated(
                                    padding: const EdgeInsets.symmetric(horizontal: 20),
                                    physics: const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: flexibilityViewModel.listCategory.length,
                                    itemBuilder: (context, index) {
                                      return CustomClick(
                                        onTap: () {
                                          NavigationHelper.pushScreenWithNavBar(
                                            widget: FlexibilityListView(
                                              data: flexibilityViewModel.listCategory[index],
                                            ),
                                            context: context,
                                          );
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                            color: AppColors.surfaceTertiary,
                                            borderRadius: BorderRadius.circular(
                                              AppCorner.listTile,
                                            ),
                                          ),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: TextHeadlineMedium(
                                                    text: flexibilityViewModel
                                                            .listCategory[index].flexibilityType ??
                                                        ""),
                                              ),
                                              const ImageIcon(
                                                AssetImage(Assets.iconsIcEndArrow),
                                                size: 15,
                                              ),
                                            ],
                                          ),
                                        ),
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
                          () => flexibilityViewModel.isLoadingMore.isTrue
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
