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
import 'package:revalesuva/view_models/workshop_events/workshop_event_view_model.dart';
import 'package:revalesuva/views/workshop_events/widget/my_workshop_event_item_widget.dart';
import 'package:revalesuva/views/workshop_events/widget/my_workshop_future_item_widget.dart';
import 'package:revalesuva/views/workshop_events/widget/registration_info_edit_widget.dart';

class MyWorkshopEventListView extends StatefulWidget {
  const MyWorkshopEventListView({super.key});

  @override
  State<MyWorkshopEventListView> createState() => _MyWorkshopEventListViewState();
}

class _MyWorkshopEventListViewState extends State<MyWorkshopEventListView> {
  final WorkshopEventViewModel workshopEventViewModel = Get.put(WorkshopEventViewModel());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        workshopEventViewModel.pastEventCurrentPage.value = 1;
        workshopEventViewModel.listPastEvent.clear();
        workshopEventViewModel.fetchFutureWorkshopEvent();
        workshopEventViewModel.pastFetchWorkshopEvent();
        workshopEventViewModel.pastSetupScrollController();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        NavigationHelper.onBackScreen(widget: const MyWorkshopEventListView());
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
                  const Gap(20),
                  TextHeadlineMedium(
                    text: StringConstants.myWorkshopsEvents,
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
                  workshopEventViewModel.pastEventCurrentPage.value = 1;
                  workshopEventViewModel.listPastEvent.clear();
                  workshopEventViewModel.fetchFutureWorkshopEvent();
                  await workshopEventViewModel.pastFetchWorkshopEvent();
                },
                child: Obx(
                  () => ListView(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    controller: workshopEventViewModel.pastEventScrollController,
                    physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics(),
                    ),
                    children: [
                      const Gap(10),
                      workshopEventViewModel.isFutureLoading.isTrue
                          ? ListView.separated(
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
                          : workshopEventViewModel.listFutureEvent.isNotEmpty
                              ? ListView.separated(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: workshopEventViewModel.listFutureEvent.length,
                                  itemBuilder: (context, index) {
                                    return MyWorkshopFutureItemWidget(
                                      data: workshopEventViewModel.listFutureEvent[index],
                                      onUpdate: () {
                                        Get.bottomSheet(
                                          backgroundColor: AppColors.surfaceTertiary,
                                          PopScope(
                                            onPopInvokedWithResult: (didPop, result) {
                                              workshopEventViewModel.fetchFutureWorkshopEvent();
                                            },
                                            child: Padding(
                                              padding: const EdgeInsets.all(5),
                                              child: SingleChildScrollView(
                                                padding: const EdgeInsets.symmetric(
                                                    horizontal: 10, vertical: 30),
                                                clipBehavior: Clip.hardEdge,
                                                child: RegistrationInfoEditWidget(
                                                  title: StringConstants.update,
                                                  data: workshopEventViewModel.listFutureEvent[index],
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
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
                      TextHeadlineMedium(
                        text: StringConstants.pastEvents,
                        color: AppColors.textPrimary,
                        letterSpacing: 0,
                      ),
                      const Gap(10),
                      workshopEventViewModel.pastEventIsLoading.isTrue
                          ? ListView.separated(
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
                          : workshopEventViewModel.listPastEvent.isNotEmpty
                              ? ListView.separated(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: workshopEventViewModel.listPastEvent.length,
                                  itemBuilder: (context, index) {
                                    return MyWorkshopEventPastItemWidget(
                                      data: workshopEventViewModel.listPastEvent[index],
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
                        () => workshopEventViewModel.pastEventIsLoadingMore.isTrue
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
