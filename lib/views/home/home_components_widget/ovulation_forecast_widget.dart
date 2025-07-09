import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:revalesuva/components/custom_button.dart';
import 'package:revalesuva/components/custom_text.dart';
import 'package:revalesuva/utils/app_colors.dart';
import 'package:revalesuva/utils/app_corner.dart';
import 'package:revalesuva/utils/helper_method.dart';
import 'package:revalesuva/utils/navigation_helper.dart';
import 'package:revalesuva/utils/strings_constant.dart';
import 'package:revalesuva/view_models/home/home_view_model.dart';
import 'package:revalesuva/views/tools/ovulation_calculator/ovulation_calculator_view.dart';

class OvulationForecastWidget extends StatelessWidget {
  OvulationForecastWidget({super.key});

  final HomeViewModel homeViewModel = Get.find<HomeViewModel>();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: homeViewModel.fetchOvulationDate(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CustomShimmer(
            width: 100.w,
            height: 80,
          );
        } else {
          if (homeViewModel.numberOfCycleDays.value > 0) {
            return LayoutBuilder(
              builder: (context, constraints) {
                bool isHalf = (MediaQuery.of(context).size.width / 2) > constraints.maxWidth;
                if (homeViewModel.menstruationDays.value < 0 ||
                    homeViewModel.expectedOvulation.value < 0) {
                  return CustomCard2(
                    color: AppColors.surfaceTertiary,
                    radius: AppCorner.cardBoarder,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        noDataFoundWidget(message: "No Ovulation data found",height: 10),
                      ],
                    ),
                  );
                } else if (isHalf) {
                  return CustomCard2(
                    color: AppColors.surfaceTertiary,
                    radius: AppCorner.cardBoarder,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Obx(
                          () => CircularPercentIndicator(
                            radius: 65.0,
                            lineWidth: 10.0,
                            reverse: true,
                            center: Container(
                              height: double.infinity,
                              width: double.infinity,
                              margin: const EdgeInsets.all(20),
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.surfaceBrand,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Obx(
                                    () => TextHeadlineLarge(
                                      text: "${homeViewModel.numberOfCycleDays.value}",
                                      color: AppColors.textPrimary,
                                      weight: 5,
                                      size: 3,
                                    ),
                                  ),
                                  const TextTitleMedium(
                                    text: "Cycle day",
                                    color: AppColors.textPrimary,
                                    weight: 1,
                                  ),
                                ],
                              ),
                            ),
                            percent: homeViewModel.percentage.value,
                            backgroundWidth: 1,
                            backgroundColor: AppColors.surfaceBrand,
                            progressColor: AppColors.surfaceBrand,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextBodyMedium(
                              text: "${StringConstants.ovulationExpected}: ",
                              color: AppColors.textPrimary,
                            ),
                            Obx(
                              () => TextTitleMedium(
                                text: "${homeViewModel.expectedOvulation} ${StringConstants.days}",
                                color: AppColors.textPrimary,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextBodyMedium(
                              text: "${StringConstants.menstruationExpected}: ",
                              color: AppColors.textPrimary,
                            ),
                            Obx(
                              () => TextTitleMedium(
                                text: "${homeViewModel.menstruationDays} ${StringConstants.days}",
                                color: AppColors.textPrimary,
                              ),
                            ),
                          ],
                        ),
                        CustomTextButton(
                          isFront: false,
                          icon: Icons.arrow_forward_ios_rounded,
                          text: StringConstants.periodEditing,
                          iconSize: 10,
                          size: 4,
                          onPressed: () {
                            NavigationHelper.pushScreenWithNavBar(
                              widget: const OvulationCalculatorView(),
                              context:
                                  homeViewModel.persistentNavKey[0].currentState?.context ?? context,
                            );
                          },
                        )
                      ],
                    ),
                  );
                } else {
                  return CustomCard2(
                    color: AppColors.surfaceTertiary,
                    radius: AppCorner.cardBoarder,
                    child: Stack(
                      alignment: AlignmentDirectional.bottomEnd,
                      children: [
                        Row(
                          children: [
                            Obx(
                              () => CircularPercentIndicator(
                                radius: 60.0,
                                lineWidth: 10.0,
                                reverse: true,
                                center: Container(
                                  height: double.infinity,
                                  width: double.infinity,
                                  margin: const EdgeInsets.all(20),
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColors.surfaceBrand,
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Obx(
                                        () => TextHeadlineLarge(
                                          text: "${homeViewModel.numberOfCycleDays.value}",
                                          color: AppColors.textPrimary,
                                          weight: 5,
                                          size: 3,
                                        ),
                                      ),
                                      const TextTitleMedium(
                                        text: "Cycle day",
                                        color: AppColors.textPrimary,
                                        weight: 1,
                                      ),
                                    ],
                                  ),
                                ),
                                percent: homeViewModel.percentage.value,
                                backgroundWidth: 1,
                                backgroundColor: AppColors.surfaceBrand,
                                progressColor: AppColors.surfaceBrand,
                              ),
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      TextBodyMedium(
                                        text: "${StringConstants.ovulationExpected}: ",
                                        color: AppColors.textPrimary,
                                      ),
                                      Obx(
                                        () => TextTitleMedium(
                                          text:
                                              "${homeViewModel.expectedOvulation.value} ${StringConstants.days}",
                                          color: AppColors.textPrimary,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      TextBodyMedium(
                                        text: "${StringConstants.menstruationExpected}: ",
                                        color: AppColors.textPrimary,
                                      ),
                                      Obx(
                                        () => TextTitleMedium(
                                          text:
                                              "${homeViewModel.menstruationDays} ${StringConstants.days}",
                                          color: AppColors.textPrimary,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        CustomTextButton(
                          isFront: false,
                          icon: Icons.arrow_forward_ios_rounded,
                          text: StringConstants.periodEditing,
                          iconSize: 10,
                          size: 4,
                          onPressed: () {
                            NavigationHelper.pushScreenWithNavBar(
                              widget: const OvulationCalculatorView(),
                              context:
                                  homeViewModel.persistentNavKey[0].currentState?.context ?? context,
                            );
                          },
                        )
                      ],
                    ),
                  );
                }
              },
            );
          } else {
            return const SizedBox();
          }
        }
      },
    );
  }
}
