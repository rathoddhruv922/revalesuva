import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:revalesuva/components/custom_button.dart';
import 'package:revalesuva/components/custom_click.dart';
import 'package:revalesuva/components/custom_text.dart';
import 'package:revalesuva/utils/app_colors.dart';
import 'package:revalesuva/utils/app_corner.dart';
import 'package:revalesuva/utils/helper_method.dart';
import 'package:revalesuva/utils/navigation_helper.dart';
import 'package:revalesuva/utils/strings_constant.dart';
import 'package:revalesuva/view_models/tools/vegetable_challenge_view_model.dart';
import 'package:revalesuva/views/tools/vegetable_challenge/widget/challenge_bottom_sheet_widget.dart';
import 'package:revalesuva/views/tools/vegetable_challenge/widget/challenge_dropdown_widget.dart';

class VegetableChallengeView extends StatefulWidget {
  const VegetableChallengeView({super.key});

  @override
  State<VegetableChallengeView> createState() => _VegetableChallengeViewState();
}

class _VegetableChallengeViewState extends State<VegetableChallengeView> {
  final VegetableChallengeViewModel vegetableChallengeViewModel =
      Get.put(VegetableChallengeViewModel(), permanent: true);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        vegetableChallengeViewModel.isLoading.value = true;
        await vegetableChallengeViewModel.fetchNutrition();
        await vegetableChallengeViewModel.fetchUserNutrition();

        vegetableChallengeViewModel.checkAllowToAttempt();
        vegetableChallengeViewModel.isLoading.value = false;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (didPop, result) {
        NavigationHelper.onBackScreen(widget: const VegetableChallengeView());
      },
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Gap(10),
              CustomClick(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: TextBodySmall(
                  text: "< ${StringConstants.backTo} ${StringConstants.tools}",
                  color: AppColors.textPrimary,
                  letterSpacing: 0,
                ),
              ),
              const Gap(10),
              Row(
                children: [
                  Expanded(
                    child: TextHeadlineMedium(
                      text: StringConstants.vegetableChallenge,
                      color: AppColors.textPrimary,
                      letterSpacing: 0,
                    ),
                  ),
                  Obx(
                    () => vegetableChallengeViewModel.remainStartDay.value == 0
                        ? Row(
                            children: [
                              TextBodyMedium(
                                text: StringConstants.dayNumber,
                                color: AppColors.textPrimary,
                                letterSpacing: 0,
                              ),
                              Obx(
                                () => TextHeadlineMedium(
                                  text:
                                      ": ${vegetableChallengeViewModel.daysFromPlanStartToCurrent.value}",
                                  color: AppColors.textPrimary,
                                  letterSpacing: 0,
                                ),
                              ),
                            ],
                          )
                        : const SizedBox(),
                  )
                ],
              ),
              const Gap(10),
              Expanded(
                child: Obx(
                  () => vegetableChallengeViewModel.isLoading.isTrue
                      ? ListView(
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          children: [
                            CustomShimmer(
                              height: 25.h,
                              radius: AppCorner.listTile,
                            ),
                            const Gap(20),
                            CustomShimmer(
                              height: 25.h,
                              radius: AppCorner.listTile,
                            ),
                          ],
                        )
                      : RefreshIndicator(
                          onRefresh: () async {
                            await vegetableChallengeViewModel.fetchNutrition();
                          },
                          child: Obx(
                            () => vegetableChallengeViewModel.remainStartDay.value == 0
                                ? ListView(
                                    physics: const BouncingScrollPhysics(
                                        parent: AlwaysScrollableScrollPhysics()),
                                    padding: const EdgeInsets.symmetric(vertical: 10),
                                    children: [
                                      CustomCard2(
                                        color: AppColors.surfaceTertiary,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Obx(
                                              () => TextHeadlineSmall(
                                                text:
                                                    StringConstants.vegetableSummaryUntilDay.replaceAll(
                                                  "{}",
                                                  "${vegetableChallengeViewModel.lastUpdateDayOfWeek.value}",
                                                ),
                                              ),
                                            ),
                                            const Gap(10),
                                            Row(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Expanded(
                                                  child: TextBodySmall(
                                                    text:
                                                        "${StringConstants.redOrangePurpleVegetables}:",
                                                    color: AppColors.textPrimary,
                                                  ),
                                                ),
                                                Obx(
                                                  () => Padding(
                                                    padding: const EdgeInsets.only(top: 2.0),
                                                    child: SizedBox(
                                                      width: 40,
                                                      child: TextTitleSmall(
                                                        text:
                                                            "${vegetableChallengeViewModel.userShowROPNutrition.length}",
                                                        color: AppColors.textPrimary,
                                                        textAlign: TextAlign.center,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const Gap(10),
                                            Row(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Expanded(
                                                  child: TextBodySmall(
                                                    text: "${StringConstants.yellowWhiteVegetables}:",
                                                    color: AppColors.textPrimary,
                                                  ),
                                                ),
                                                Obx(
                                                  () => Padding(
                                                    padding: const EdgeInsets.only(top: 2.0),
                                                    child: SizedBox(
                                                      width: 40,
                                                      child: TextTitleSmall(
                                                        text:
                                                            "${vegetableChallengeViewModel.userShowYWNutrition.length}",
                                                        color: AppColors.textPrimary,
                                                        textAlign: TextAlign.center,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const Gap(10),
                                            Row(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Expanded(
                                                  child: TextBodySmall(
                                                    text: "${StringConstants.greenVegetables}:",
                                                    color: AppColors.textPrimary,
                                                  ),
                                                ),
                                                Obx(
                                                  () => Padding(
                                                    padding: const EdgeInsets.only(top: 2.0),
                                                    child: SizedBox(
                                                      width: 40,
                                                      child: TextTitleSmall(
                                                        text:
                                                            "${vegetableChallengeViewModel.userShowGNutrition.length}",
                                                        color: AppColors.textPrimary,
                                                        textAlign: TextAlign.center,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Divider(
                                              color: AppColors.lightGray,
                                              height: 20,
                                            ),
                                            Row(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Expanded(
                                                  child: TextTitleSmall(
                                                    text: "${StringConstants.totalVegetables}:",
                                                    color: AppColors.textPrimary,
                                                  ),
                                                ),
                                                Obx(
                                                  () => Padding(
                                                    padding: const EdgeInsets.only(top: 2.0),
                                                    child: SizedBox(
                                                      width: 40,
                                                      child: TextTitleSmall(
                                                        text:
                                                            "${vegetableChallengeViewModel.userShowROPNutrition.length + vegetableChallengeViewModel.userShowYWNutrition.length + vegetableChallengeViewModel.userShowGNutrition.length}",
                                                        color: AppColors.textPrimary,
                                                        textAlign: TextAlign.center,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      const Gap(20),
                                      Obx(
                                        () => vegetableChallengeViewModel.isAllowToAttempt.isTrue
                                            ? CustomCard2(
                                                color: AppColors.surfaceTertiary,
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    TextTitleMedium(
                                                      text: StringConstants.planVegetablesToday,
                                                    ),
                                                    const Gap(10),
                                                    Obx(
                                                      () => ChallengeDropdownWidget(
                                                        onTap: () {
                                                          Get.bottomSheet(
                                                            ChallengeBottomSheetWidget(
                                                              title: StringConstants
                                                                  .redOrangePurpleVegetables,
                                                              nutritionList: vegetableChallengeViewModel
                                                                  .listROPNutrition,
                                                            ),
                                                          );
                                                        },
                                                        selectedValue: vegetableChallengeViewModel
                                                                .userSelectedROPNutrition
                                                                .value
                                                                .nutritionName ??
                                                            "",
                                                        hint: StringConstants.redOrangePurpleVegetables,
                                                      ),
                                                    ),
                                                    const Gap(10),
                                                    Obx(
                                                      () => ChallengeDropdownWidget(
                                                        onTap: () {
                                                          Get.bottomSheet(
                                                            ChallengeBottomSheetWidget(
                                                              title:
                                                                  StringConstants.yellowWhiteVegetables,
                                                              nutritionList: vegetableChallengeViewModel
                                                                  .listYWNutrition,
                                                            ),
                                                          );
                                                        },
                                                        selectedValue: vegetableChallengeViewModel
                                                                .userSelectedYWNutrition
                                                                .value
                                                                .nutritionName ??
                                                            "",
                                                        hint: StringConstants.yellowWhiteVegetables,
                                                      ),
                                                    ),
                                                    const Gap(10),
                                                    Obx(
                                                      () => ChallengeDropdownWidget(
                                                        onTap: () {
                                                          Get.bottomSheet(
                                                            ChallengeBottomSheetWidget(
                                                              title: StringConstants.greenVegetables,
                                                              nutritionList: vegetableChallengeViewModel
                                                                  .listGNutrition,
                                                            ),
                                                          );
                                                        },
                                                        selectedValue: vegetableChallengeViewModel
                                                                .userSelectedGNutrition
                                                                .value
                                                                .nutritionName ??
                                                            "",
                                                        hint: StringConstants.greenVegetables,
                                                      ),
                                                    ),
                                                    // const Gap(10),
                                                    // TextTitleSmall(
                                                    //   text: StringConstants.confirmFinalDailyList,
                                                    //   color: AppColors.textError,
                                                    // ),
                                                    const Gap(20),
                                                    SimpleButton(
                                                      width: 100.w,
                                                      text: StringConstants.addToWeeklySummary,
                                                      onPressed: () {
                                                        vegetableChallengeViewModel
                                                            .submitUserWeeklySummary();
                                                      },
                                                    ),
                                                    const Gap(10),
                                                  ],
                                                ),
                                              )
                                            : const SizedBox(),
                                      ),
                                      const Gap(50),
                                    ],
                                  )
                                : noDataFoundWidget(
                                    message:
                                        StringConstants.vegetableChallengeWillStartAfterDays.replaceAll(
                                      "{}",
                                      vegetableChallengeViewModel.remainStartDay.value.toString(),
                                    ),
                                  ),
                          ),
                        ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
