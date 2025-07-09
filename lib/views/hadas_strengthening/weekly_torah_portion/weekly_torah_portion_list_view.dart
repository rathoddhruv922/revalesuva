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
import 'package:revalesuva/utils/strings_constant.dart';
import 'package:revalesuva/view_models/hadas_strengthening/weekly_torah_portion_view_model.dart';
import 'package:revalesuva/views/hadas_strengthening/weekly_torah_portion/widget/weekly_torah_portion_item_widget.dart';

import '../../../utils/navigation_helper.dart';

class WeeklyTorahPortionListView extends StatefulWidget {
  const WeeklyTorahPortionListView({super.key});

  @override
  State<WeeklyTorahPortionListView> createState() => _WeeklyTorahPortionListViewState();
}

class _WeeklyTorahPortionListViewState extends State<WeeklyTorahPortionListView> {
  final WeeklyTorahPortionViewModel weeklyTorahPortionViewModel = Get.find<WeeklyTorahPortionViewModel>();
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
        !weeklyTorahPortionViewModel.isLoadingMore.value) {
      weeklyTorahPortionViewModel.currentPage.value++;
      weeklyTorahPortionViewModel.fetchWeeklyPortion(isLoadMore: true);
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _onRefresh() async {
    weeklyTorahPortionViewModel.currentPage.value = 1;
    weeklyTorahPortionViewModel.listWeeklyPortion.clear();
    await weeklyTorahPortionViewModel.fetchWeeklyPortion();
  }


  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        NavigationHelper.onBackScreen(widget: const WeeklyTorahPortionListView());
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
                    text: StringConstants.weeklyTorahPortion,
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
                        weeklyTorahPortionViewModel.isLoading.isTrue
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
                            : weeklyTorahPortionViewModel.listWeeklyPortion.isNotEmpty
                                ? ListView.separated(
                                    padding: const EdgeInsets.symmetric(horizontal: 20),
                                    physics: const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: weeklyTorahPortionViewModel.listWeeklyPortion.length,
                                    itemBuilder: (context, index) {
                                      return WeeklyTorahPortionItemWidget(
                                        index: index,
                                        data: weeklyTorahPortionViewModel.listWeeklyPortion[index],
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
                          () => weeklyTorahPortionViewModel.isLoadingMore.isTrue
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
