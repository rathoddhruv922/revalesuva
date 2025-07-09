import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:revalesuva/components/custom_click.dart';
import 'package:revalesuva/components/custom_text.dart';
import 'package:revalesuva/model/hadas_strengthening/flexibility_category_model.dart'
    as flexibility_category_model;
import 'package:revalesuva/utils/app_colors.dart';
import 'package:revalesuva/utils/app_corner.dart';
import 'package:revalesuva/utils/helper_method.dart';
import 'package:revalesuva/utils/navigation_helper.dart';
import 'package:revalesuva/utils/strings_constant.dart';
import 'package:revalesuva/view_models/hadas_strengthening/flexibility_view_model.dart';
import 'package:revalesuva/views/hadas_strengthening/flexibility/widget/flexibility_item_widget.dart';

class FlexibilityListView extends StatefulWidget {
  const FlexibilityListView({super.key, required this.data});

  final flexibility_category_model.Datum data;

  @override
  State<FlexibilityListView> createState() => _FlexibilityListViewState();
}

class _FlexibilityListViewState extends State<FlexibilityListView> {
  final FlexibilityViewModel flexibilityViewModel = Get.find<FlexibilityViewModel>();
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
      flexibilityViewModel.flexibilityCurrentPage.value++;
      flexibilityViewModel.fetchFlexibility(isLoadMore: true,categoryId: widget.data.id.toString());
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _onRefresh() async {
    flexibilityViewModel.flexibilityCurrentPage.value = 1;
    flexibilityViewModel.listFlexibility.clear();
    flexibilityViewModel.fetchFlexibility(categoryId: widget.data.id.toString());
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        NavigationHelper.onBackScreen(
            widget: FlexibilityListView(
          data: widget.data,
        ));
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
                      text: "< ${StringConstants.backTo} ${StringConstants.flexibility}",
                      color: AppColors.textPrimary,
                      letterSpacing: 0,
                    ),
                  ),
                  const Gap(10),
                  TextHeadlineMedium(
                    text: widget.data.flexibilityType ?? "",
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
                        flexibilityViewModel.isLoadingItem.isTrue
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
                            : flexibilityViewModel.listFlexibility.isNotEmpty
                                ? ListView.separated(
                                    padding: const EdgeInsets.symmetric(horizontal: 20),
                                    physics: const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: flexibilityViewModel.listFlexibility.length,
                                    itemBuilder: (context, index) {
                                      return FlexibilityItemWidget(
                                        index: index,
                                        data: flexibilityViewModel.listFlexibility[index],
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
