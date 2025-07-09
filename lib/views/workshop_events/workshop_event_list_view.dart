import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:revalesuva/components/custom_text.dart';
import 'package:revalesuva/utils/app_colors.dart';
import 'package:revalesuva/utils/app_corner.dart';
import 'package:revalesuva/utils/helper_method.dart';
import 'package:revalesuva/utils/navigation_helper.dart';
import 'package:revalesuva/utils/strings_constant.dart';
import 'package:revalesuva/view_models/workshop_events/workshop_event_view_model.dart';
import 'package:revalesuva/views/workshop_events/widget/workshop_event_item_widget.dart';

class WorkshopEventListView extends StatefulWidget {
  const WorkshopEventListView({super.key});

  @override
  State<WorkshopEventListView> createState() => _WorkshopEventListViewState();
}

class _WorkshopEventListViewState extends State<WorkshopEventListView> {
  final WorkshopEventViewModel workshopEventViewModel = Get.put(WorkshopEventViewModel());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        workshopEventViewModel.currentPage.value = 1;
        workshopEventViewModel.listWorkshopEvent.clear();
        workshopEventViewModel.fetchWorkshopEvent();
        workshopEventViewModel.setupScrollController();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        NavigationHelper.onBackScreen(widget: const WorkshopEventListView());
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
                  TextHeadlineMedium(
                    text: StringConstants.workshopsAndEvents,
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
                  workshopEventViewModel.currentPage.value = 1;
                  workshopEventViewModel.listWorkshopEvent.clear();
                  await workshopEventViewModel.fetchWorkshopEvent();
                },
                child: Obx(
                  () => ListView(
                    controller: workshopEventViewModel.scrollController,
                    physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics(),
                    ),
                    children: [
                      const Gap(10),
                      workshopEventViewModel.isLoading.isTrue
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
                          : workshopEventViewModel.listWorkshopEvent.isNotEmpty
                              ? ListView.separated(
                                  padding: const EdgeInsets.symmetric(horizontal: 20),
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: workshopEventViewModel.listWorkshopEvent.length,
                                  itemBuilder: (context, index) {
                                    return WorkshopEventItemWidget(
                                      data: workshopEventViewModel.listWorkshopEvent[index],
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
                        () => workshopEventViewModel.isLoadingMore.isTrue
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
