import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:revalesuva/components/custom_button.dart';
import 'package:revalesuva/components/custom_click.dart';
import 'package:revalesuva/components/custom_text.dart';
import 'package:revalesuva/generated/assets.dart';
import 'package:revalesuva/model/my_plan/program/user_program_model.dart' as user_program_model;
import 'package:revalesuva/utils/app_colors.dart';
import 'package:revalesuva/utils/date_format_helper.dart';
import 'package:revalesuva/utils/helper_method.dart';
import 'package:revalesuva/utils/navigation_helper.dart';
import 'package:revalesuva/utils/strings_constant.dart';
import 'package:revalesuva/view_models/hadas_strengthening/weekly_torah_portion_view_model.dart';
import 'package:revalesuva/view_models/home/home_view_model.dart';
import 'package:revalesuva/view_models/my_plan/lessons_view_model.dart';
import 'package:revalesuva/view_models/tools/daily_nutrition_view_model.dart';
import 'package:revalesuva/view_models/tools/daily_reports_view_model.dart';
import 'package:revalesuva/view_models/tools/weekly_report_view_model.dart';
import 'package:revalesuva/view_models/user_view_model.dart';
import 'package:revalesuva/view_models/weighing_and_measuring/weighing_and_measuring_view_model.dart';
import 'package:revalesuva/views/my_plan/program/program_detail_view.dart';
import 'package:revalesuva/views/my_plan/program_completion_report/program_completion_report_view.dart';
import 'package:revalesuva/views/tools/daily_nutrition_planning/daily_nutrition_planning_view.dart';
import 'package:revalesuva/views/tools/daily_report/daily_report_question_view.dart';
import 'package:revalesuva/views/tools/weekly_report/weekly_report_question_view.dart';
import 'package:revalesuva/views/weighing_and_measuring/weighing_and_measuring_view.dart';

class MessageNotificationListWidget extends StatefulWidget {
  const MessageNotificationListWidget({super.key});

  @override
  State<MessageNotificationListWidget> createState() => _MessageNotificationListWidgetState();
}

class _MessageNotificationListWidgetState extends State<MessageNotificationListWidget> {
  final HomeViewModel homeViewModel = Get.find<HomeViewModel>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        if (Get.find<UserViewModel>().isWeightModule.value) {
          await Get.find<WeighingAndMeasuringViewModel>().onCreate();
        }
        if (Get.find<UserViewModel>().isShowDailyNutrition.value) {
          await Get.find<DailyNutritionViewModel>().fetchUserDailyNutritionByDate();
        }
        if (Get.find<UserViewModel>().isDailyReport.value) {
          await Get.find<DailyReportsViewModel>().fetchUserDailyReportAns(
            date: changeDateStringFormat(
              date: DateTime.now().toString(),
              format: DateFormatHelper.ymdFormat,
            ),
          );
        }
        if (Get.find<UserViewModel>().isWeeklyReport.value &&
            Get.find<UserViewModel>().userPlanDetail.value.plan?.activeDay == "saturday") {
          await Get.find<WeeklyReportViewModel>().fetchUserWeeklyReportAns(
            date: changeDateStringFormat(
              date: DateTime.now().toString(),
              format: DateFormatHelper.ymdFormat,
            ),
          );
        }
        if (Get.find<UserViewModel>().isLessonSummary.value) {
          Get.find<LessonsViewModel>().getLessonsByPlanId(
              planId: "${Get.find<UserViewModel>().userPlanDetail.value.planId ?? ""}");
        }

        Get.find<WeeklyTorahPortionViewModel>().currentPage.value = 1;
        Get.find<WeeklyTorahPortionViewModel>().listWeeklyPortion.clear();
        await Get.find<WeeklyTorahPortionViewModel>().fetchWeeklyPortion();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Obx(
          () => Get.find<UserViewModel>().isWeightModule.value &&
                  Get.find<WeighingAndMeasuringViewModel>().canUpdateWeight.isTrue
              ? CustomCard(
                  color: AppColors.surfaceBlueDark,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        Assets.iconsIcWeighWhite,
                        width: 20,
                        color: AppColors.iconTertiary,
                      ),
                      const Gap(10),
                      Expanded(
                        child: TextTitleMedium(
                          text: StringConstants.weighing,
                          color: AppColors.textTertiary,
                        ),
                      ),
                      CustomTextButton(
                        isFront: false,
                        icon: Icons.arrow_forward_ios_rounded,
                        text: StringConstants.clickHereAndWeighMe,
                        iconSize: 10,
                        size: 1,
                        textColor: AppColors.textTertiary,
                        onPressed: () {
                          NavigationHelper.pushScreenWithNavBar(
                            widget: const WeighingAndMeasuringView(),
                            context: homeViewModel.persistentNavKey[0].currentState?.context ?? context,
                          );
                        },
                      )
                    ],
                  ),
                )
              : const SizedBox(),
        ),
        Obx(
          () => Get.find<UserViewModel>().isShowDailyNutrition.value &&
                  Get.find<DailyNutritionViewModel>().isAvailable.isTrue
              ? CustomClick(
                  onTap: () {
                    NavigationHelper.pushScreenWithNavBar(
                      widget: const DailyNutritionPlanningView(),
                      context: homeViewModel.persistentNavKey[0].currentState?.context ?? context,
                    );
                  },
                  child: CustomCard(
                    color: AppColors.surfaceError,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          Assets.iconsIcDailyNutritionPlanning,
                          width: 20,
                          color: AppColors.iconTertiary,
                        ),
                        const Gap(10),
                        Expanded(
                          child: TextTitleMedium(
                            text: StringConstants.nutritionPlanning,
                            color: AppColors.textTertiary,
                          ),
                        ),
                        CustomTextButton(
                          isFront: false,
                          icon: Icons.keyboard_arrow_down_rounded,
                          text: "",
                          iconSize: 20,
                          size: 1,
                          textColor: AppColors.textTertiary,
                          onPressed: () {},
                        )
                      ],
                    ),
                  ),
                )
              : const SizedBox(),
        ),
        Obx(
          () {
            var isSame = false;

            if (Get.find<WeeklyTorahPortionViewModel>().listWeeklyPortion.isNotEmpty) {
              isSame = Get.find<WeeklyTorahPortionViewModel>()
                      .listWeeklyPortion
                      .first
                      .date
                      ?.isAfter(DateTime.now()) ??
                  false;
            }

            return isSame
                ? CustomCard(
                    color: AppColors.surfaceGreen,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          Assets.iconsIcTorahPortion,
                          width: 20,
                          color: AppColors.iconTertiary,
                        ),
                        const Gap(10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextTitleMedium(
                                text: StringConstants.weeklyPortion,
                                color: AppColors.textTertiary,
                              ),
                              TextBodyMedium(
                                text: Get.find<WeeklyTorahPortionViewModel>()
                                        .listWeeklyPortion
                                        .first
                                        .title ??
                                    "",
                                color: AppColors.textTertiary,
                              ),
                            ],
                          ),
                        ),
                        CustomTextButton(
                          isFront: false,
                          icon: Icons.keyboard_arrow_down_rounded,
                          text: "",
                          iconSize: 20,
                          size: 1,
                          textColor: AppColors.textTertiary,
                          onPressed: () {},
                        )
                      ],
                    ),
                  )
                : const SizedBox();
          },
        ),
        // CustomCard(
        //   color: AppColors.surfaceGreen,
        //   child: Row(
        //     crossAxisAlignment: CrossAxisAlignment.start,
        //     children: [
        //       Image.asset(
        //         Assets.iconsIcTorahPortion,
        //         width: 20,
        //         color: AppColors.iconTertiary,
        //       ),
        //       const Gap(10),
        //       Expanded(
        //         child: Column(
        //           crossAxisAlignment: CrossAxisAlignment.start,
        //           children: [
        //             TextTitleMedium(
        //               text: "\"${StringConstants.forMe}\"",
        //               color: AppColors.textTertiary,
        //             ),
        //             TextBodyMedium(
        //               text: StringConstants.nextMeeting,
        //               color: AppColors.textTertiary,
        //             ),
        //           ],
        //         ),
        //       ),
        //       CustomTextButton(
        //         isFront: false,
        //         icon: Icons.keyboard_arrow_down_rounded,
        //         text: "",
        //         iconSize: 20,
        //         size: 1,
        //         textColor: AppColors.textTertiary,
        //         onPressed: () {},
        //       ),
        //     ],
        //   ),
        // ),
        Obx(
          () => Get.find<UserViewModel>().isDailyReport.value &&
                  Get.find<DailyReportsViewModel>().listUserAns.isEmpty
              ? CustomCard(
                  color: AppColors.surfaceGreen,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        Assets.iconsIcReport,
                        width: 20,
                        color: AppColors.iconTertiary,
                      ),
                      const Gap(10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextTitleMedium(
                              text: StringConstants.dailyReportMustBeFilledOut,
                              color: AppColors.textTertiary,
                            ),
                          ],
                        ),
                      ),
                      CustomTextButton(
                        isFront: false,
                        icon: Icons.keyboard_arrow_down_rounded,
                        text: StringConstants.clickHereToFillItOut,
                        iconSize: 20,
                        size: 1,
                        textColor: AppColors.textTertiary,
                        onPressed: () {
                          NavigationHelper.pushScreenWithNavBar(
                            widget: DailyReportQuestionView(
                              date: changeDateStringFormat(
                                date: DateTime.now().toString(),
                                format: DateFormatHelper.ymdFormat,
                              ),
                            ),
                            context: homeViewModel.persistentNavKey[0].currentState?.context ?? context,
                          );
                        },
                      )
                    ],
                  ),
                )
              : const SizedBox(),
        ),
        Obx(
          () => Get.find<UserViewModel>().isWeeklyReport.value &&
                  Get.find<UserViewModel>().userPlanDetail.value.plan?.activeDay == "saturday" &&
                  Get.find<WeeklyReportViewModel>().listUserAns.isEmpty
              ? CustomCard(
                  color: AppColors.surfaceGreen,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        Assets.iconsIcReport,
                        width: 20,
                        color: AppColors.iconTertiary,
                      ),
                      const Gap(10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextTitleMedium(
                              text: StringConstants.weeklyReportMustBeFilledOut,
                              color: AppColors.textTertiary,
                            ),
                          ],
                        ),
                      ),
                      CustomTextButton(
                        isFront: false,
                        icon: Icons.keyboard_arrow_down_rounded,
                        text: StringConstants.clickHereToFillItOut,
                        iconSize: 20,
                        size: 1,
                        textColor: AppColors.textTertiary,
                        onPressed: () {
                          NavigationHelper.pushScreenWithNavBar(
                            widget: WeeklyReportQuestionView(
                              date: changeDateStringFormat(
                                date: DateTime.now().toString(),
                                format: DateFormatHelper.ymdFormat,
                              ),
                            ),
                            context: homeViewModel.persistentNavKey[0].currentState?.context ?? context,
                          );
                        },
                      )
                    ],
                  ),
                )
              : const SizedBox(),
        ),
        Obx(
          () => Get.find<UserViewModel>().isLessonSummary.value &&
                  Get.find<LessonsViewModel>().isShowProgramCompletionReport.isTrue
              ? CustomCard(
                  color: AppColors.surfaceGreen,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        Assets.iconsIcLikeBlank,
                        width: 18,
                        color: AppColors.iconTertiary,
                      ),
                      const Gap(10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            TextTitleMedium(
                              text: StringConstants.completedProgramHome,
                              color: AppColors.textTertiary,
                            ),
                            CustomTextButton(
                              isFront: false,
                              icon: Icons.keyboard_arrow_down_rounded,
                              text: StringConstants.clickHereToFillItOut,
                              iconSize: 20,
                              size: 1,
                              textColor: AppColors.textTertiary,
                              onPressed: () {
                                NavigationHelper.pushReplaceScreenWithNavBar(
                                  widget: const ProgramCompletionReportView(),
                                  context:
                                      homeViewModel.persistentNavKey[0].currentState?.context ?? context,
                                );
                              },
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              : const SizedBox(),
        ),
        FutureBuilder<List<user_program_model.Datum>>(
          future: homeViewModel.getActiveProgramList(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const SizedBox.shrink();
            } else {
              List<user_program_model.Datum> data = snapshot.data ?? [];
              if (data.isNotEmpty) {
                return CustomClick(
                  onTap: () {
                    NavigationHelper.pushScreenWithNavBar(
                      widget: ProgramDetailView(
                        programId: data.first.programId.toString(),
                      ),
                      context: homeViewModel.persistentNavKey[0].currentState?.context ?? context,
                    );
                  },
                  child: CustomCard(
                    color: AppColors.surfaceBlue,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          Assets.iconsIcIceCube,
                          width: 20,
                          color: AppColors.iconPrimary,
                        ),
                        const Gap(10),
                        Expanded(
                          child: TextTitleMedium(
                            text: data.first.program?.name ?? "",
                            color: AppColors.textPrimary,
                          ),
                        ),
                        CustomTextButton(
                          isFront: false,
                          icon: Icons.keyboard_arrow_down_rounded,
                          text: "",
                          iconSize: 20,
                          size: 1,
                          textColor: AppColors.textPrimary,
                          onPressed: () {},
                        )
                      ],
                    ),
                  ),
                );
              } else {
                return const SizedBox();
              }
            }
          },
        ),
        // CustomCard(
        //   color: AppColors.surfaceYellow,
        //   child: Stack(
        //     children: [
        //       Align(
        //         alignment: AlignmentDirectional.topEnd,
        //         child: Image.asset(
        //           Assets.iconsIcClose,
        //           width: 15,
        //           color: AppColors.iconSecondary,
        //         ),
        //       ),
        //       Column(
        //         crossAxisAlignment: CrossAxisAlignment.start,
        //         children: [
        //           const TextTitleMedium(
        //             text: "Graduates launch event!",
        //             color: AppColors.textPrimary,
        //           ),
        //           const Gap(5),
        //           Row(
        //             children: [
        //               const Expanded(
        //                 child: TextBodyMedium(
        //                   text: "December 4, 2024",
        //                   color: AppColors.textPrimary,
        //                 ),
        //               ),
        //               CustomTextButton(
        //                 isFront: false,
        //                 icon: Icons.keyboard_arrow_down_rounded,
        //                 text: StringConstants.clickHereToFillItOut,
        //                 iconSize: 20,
        //                 size: 1,
        //                 textColor: AppColors.textPrimary,
        //                 onPressed: () {},
        //               ),
        //             ],
        //           )
        //         ],
        //       ),
        //     ],
        //   ),
        // ),
      ],
    );
  }
}
