import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:revalesuva/components/custom_click.dart';
import 'package:revalesuva/components/custom_text.dart';
import 'package:revalesuva/components/list_item.dart';
import 'package:revalesuva/generated/assets.dart';
import 'package:revalesuva/utils/app_colors.dart';
import 'package:revalesuva/utils/helper_method.dart';
import 'package:revalesuva/utils/navigation_helper.dart';
import 'package:revalesuva/utils/strings_constant.dart';
import 'package:revalesuva/view_models/user_view_model.dart';
import 'package:revalesuva/views/my_plan/program_completion_report/widget/see_your_image_item_widget.dart';
import 'package:revalesuva/views/my_plan/program_summary_report/summary_of_journey_view.dart';
import 'package:revalesuva/views/my_plan/program_summary_report/victory_photo_view.dart';
import 'package:revalesuva/views/weighing_and_measuring/weighing_and_measuring_history_view.dart';

class ProgramSummaryView extends StatefulWidget {
  const ProgramSummaryView({super.key});

  @override
  State<ProgramSummaryView> createState() => _ProgramSummaryViewState();
}

class _ProgramSummaryViewState extends State<ProgramSummaryView> {
  final GlobalKey<State<StatefulWidget>> scr = GlobalKey();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        await Get.find<UserViewModel>().getUserPictures();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        NavigationHelper.onBackScreen(
          widget: const ProgramSummaryView(),
        );
      },
      canPop: true,
      child: Scaffold(
        body: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
          children: [
            CustomCard2(
              color: AppColors.surfaceTertiary,
              child: Column(
                children: [
                  CustomClick(
                    onTap:(){
                      takeScreenShotAndShareByKey(
                        key: scr,
                        message: StringConstants.amazingSeeYourProgress,
                      );
                    },
                    child: Row(
                      children: [
                        Expanded(
                          child: TextHeadlineMedium(
                            text: StringConstants.amazingSeeYourProgress,
                          ),
                        ),
                        const ImageIcon(
                          AssetImage(Assets.iconsIcShare),
                          size: 15,
                        ),
                        const Gap(5),
                        TextBodyMedium(
                          text: StringConstants.share,
                          color: AppColors.iconPrimary,
                        )
                      ],
                    ),
                  ),
                  const Gap(20),
                  RepaintBoundary(
                    key: scr,
                    child: Container(
                      margin: const EdgeInsets.all(20),
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(Assets.imagesBgAfterBefore),
                        ),
                      ),
                      child: Obx(
                        () => AspectRatio(
                          aspectRatio: 1 / 1,
                          child: Column(
                            children: [
                              const Gap(60),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10.0,
                                ),
                                child: Row(
                                  children: [
                                    SeeYourImageItemWidget(
                                      imageUrl: Get.find<UserViewModel>().userBeforeFrontPicURL.value,
                                      errorImage: Assets.imagesImFront,
                                    ),
                                    const Gap(10),
                                    SeeYourImageItemWidget(
                                      imageUrl: Get.find<UserViewModel>().userBeforeSidePicURL.value,
                                      errorImage: Assets.imagesImSide,
                                    ),
                                    const Gap(10),
                                    SeeYourImageItemWidget(
                                      imageUrl: Get.find<UserViewModel>().userBeforeBackPicURL.value,
                                      errorImage: Assets.imagesImBack,
                                    ),
                                  ],
                                ),
                              ),
                              const Gap(5),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                child: Row(
                                  children: [
                                    SeeYourImageItemWidget(
                                      imageUrl: Get.find<UserViewModel>().userAfterFrontPicURL.value,
                                      errorImage: Assets.imagesImFront,
                                    ),
                                    const Gap(10),
                                    SeeYourImageItemWidget(
                                      imageUrl: Get.find<UserViewModel>().userAfterSidePicURL.value,
                                      errorImage: Assets.imagesImSide,
                                    ),
                                    const Gap(10),
                                    SeeYourImageItemWidget(
                                      imageUrl: Get.find<UserViewModel>().userAfterBackPicURL.value,
                                      errorImage: Assets.imagesImBack,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Gap(10),
            ListItem(
              title: StringConstants.weightAndMeasurementHistory,
              onTab: () {
                NavigationHelper.pushScreenWithNavBar(
                  widget: const WeighingAndMeasuringHistoryView(),
                  context: context,
                );
              },
              icon: Assets.iconsIcWeighWhite,
            ),
            const Gap(10),
            ListItem(
              title: StringConstants.summaryOfMyPersonalJourney,
              onTab: () {
                NavigationHelper.pushScreenWithNavBar(
                  widget: const SummaryOfJourneyView(),
                  context: context,
                );
              },
              icon: Assets.iconsIcSummaryIcon,
            ),
            const Gap(10),
            ListItem(
              title: StringConstants.myVictoryPicture,
              onTab: () {
                NavigationHelper.pushScreenWithNavBar(
                  widget:  VictoryPhotoView(),
                  context: context,
                );
              },
              icon: Assets.iconsIcVictory,
            ),
            const Gap(60),
          ],
        ),
      ),
    );
  }
}
