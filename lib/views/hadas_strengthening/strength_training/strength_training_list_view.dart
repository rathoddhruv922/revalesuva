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
import 'package:revalesuva/view_models/hadas_strengthening/strength_training_view_model.dart';
import 'package:revalesuva/views/hadas_strengthening/strength_training/widget/strength_training_item_widget.dart';

import '../../../utils/navigation_helper.dart';

class StrengthTrainingListView extends StatefulWidget {
  const StrengthTrainingListView({super.key});

  @override
  State<StrengthTrainingListView> createState() => _StrengthTrainingListViewState();
}

class _StrengthTrainingListViewState extends State<StrengthTrainingListView> {
  final StrengthTrainingViewModel strengthTrainingViewModel = Get.put(StrengthTrainingViewModel());
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
        !strengthTrainingViewModel.isLoadingMore.value) {
      strengthTrainingViewModel.currentPage.value++;
      strengthTrainingViewModel.fetchStrengthTraining(isLoadMore: true);
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _onRefresh() async {
    strengthTrainingViewModel.currentPage.value = 1;
    strengthTrainingViewModel.listStrengthTraining.clear();
    strengthTrainingViewModel.fetchStrengthTraining();
  }
  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        NavigationHelper.onBackScreen(widget: const StrengthTrainingListView());
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
                    text: StringConstants.strengthTraining,
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
                        strengthTrainingViewModel.isLoading.isTrue
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
                            : strengthTrainingViewModel.listStrengthTraining.isNotEmpty
                                ? ListView.separated(
                                    padding: const EdgeInsets.symmetric(horizontal: 20),
                                    physics: const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: strengthTrainingViewModel.listStrengthTraining.length,
                                    itemBuilder: (context, index) {
                                      return StrengthTrainingItemWidget(
                                        index: index,
                                        data: strengthTrainingViewModel.listStrengthTraining[index],
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
                          () => strengthTrainingViewModel.isLoadingMore.isTrue
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
