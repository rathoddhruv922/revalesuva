import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:revalesuva/components/custom_click.dart';
import 'package:revalesuva/components/custom_text.dart';
import 'package:revalesuva/components/list_item.dart';
import 'package:revalesuva/generated/assets.dart';
import 'package:revalesuva/utils/app_colors.dart';
import 'package:revalesuva/utils/date_format_helper.dart';
import 'package:revalesuva/utils/helper_method.dart';
import 'package:revalesuva/utils/navigation_helper.dart';
import 'package:revalesuva/utils/strings_constant.dart';
import 'package:revalesuva/view_models/tools/daily_nutrition_view_model.dart';
import 'package:revalesuva/view_models/tools/daily_reports_view_model.dart';
import 'package:revalesuva/view_models/tools/fasting_calculator_view_model.dart';
import 'package:revalesuva/view_models/tools/weekly_report_view_model.dart';
import 'package:revalesuva/view_models/user_view_model.dart';
import 'package:revalesuva/views/tools/daily_nutrition_planning/daily_nutrition_planning_view.dart';
import 'package:revalesuva/views/tools/daily_report/daily_report_list_view.dart';
import 'package:revalesuva/views/tools/daily_report/daily_report_question_view.dart';
import 'package:revalesuva/views/tools/fasting_calculator/fasting_calculator_leading_view.dart';
import 'package:revalesuva/views/tools/fasting_calculator/fasting_timer_view.dart';
import 'package:revalesuva/views/tools/intuitive_writing/intuitive_writing_list_view.dart';
import 'package:revalesuva/views/tools/my_achievements/my_achievements_view.dart';
import 'package:revalesuva/views/tools/nutritional_information/nutritional_information_list_view.dart';
import 'package:revalesuva/views/tools/ovulation_calculator/ovulation_calculator_view.dart';
import 'package:revalesuva/views/tools/vegetable_challenge/vegetable_challenge_view.dart';
import 'package:revalesuva/views/tools/weekly_report/weekly_report_list_view.dart';
import 'package:revalesuva/views/tools/weekly_report/weekly_report_question_view.dart';

class ToolsListView extends StatelessWidget {
  const ToolsListView({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        NavigationHelper.onBackScreen(widget: const ToolsListView());
      },
      canPop: true,
      child: Scaffold(
        body: RefreshIndicator(
          onRefresh: () async {
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
            if (Get.find<UserViewModel>().isWeeklyReport.value) {
              await Get.find<WeeklyReportViewModel>().fetchUserWeeklyReportAns(
                date: changeDateStringFormat(
                  date: DateTime.now().toString(),
                  format: DateFormatHelper.ymdFormat,
                ),
              );
            }
            return;
          },
          child: ListView(
            padding: const EdgeInsets.all(20),
            physics: const BouncingScrollPhysics(),
            children: [
              const Gap(10),
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
              const Gap(10),
              TextHeadlineMedium(
                text: StringConstants.tools,
                color: AppColors.textPrimary,
                letterSpacing: 0,
              ),
              const Gap(6),
              Obx(
                () => Get.find<UserViewModel>().userData.value.gender?.toLowerCase() == "female" &&
                        Get.find<UserViewModel>().isOvulationModule.isTrue || true
                    ? Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6.0),
                        child: ListItem(
                          title: StringConstants.ovulationCalculator,
                          onTab: () {
                            NavigationHelper.pushScreenWithNavBar(
                                widget: const OvulationCalculatorView(), context: context);
                          },
                          icon: Assets.iconsIcOvulationCalculator,
                        ),
                      )
                    : const SizedBox(),
              ),
              Obx(
                () => Get.find<UserViewModel>().userPlanDetail.value.plan?.trainerId != null
                    ? Get.find<DailyNutritionViewModel>().isAvailable.isTrue
                        ? Padding(
                            padding: const EdgeInsets.symmetric(vertical: 6.0),
                            child: ListItem(
                              title: StringConstants.dailyNutritionPlanning,
                              onTab: () {
                                NavigationHelper.pushScreenWithNavBar(
                                    widget: const DailyNutritionPlanningView(), context: context);
                              },
                              icon: Assets.iconsIcNutritionPlanning,
                              reminder: StringConstants.dailyPlanningNeedsToBeFilledOut,
                              showReminderIcon: true,
                              reminderColor: AppColors.surfaceError,
                            ),
                          )
                        : Padding(
                            padding: const EdgeInsets.symmetric(vertical: 6.0),
                            child: ListItem(
                              title: StringConstants.dailyNutritionPlanning,
                              onTab: () {
                                NavigationHelper.pushScreenWithNavBar(
                                    widget: const DailyNutritionPlanningView(), context: context);
                              },
                              icon: Assets.iconsIcNutritionPlanning,
                            ),
                          )
                    : const SizedBox(),
              ),
              Obx(
                () => Get.find<UserViewModel>().isDailyReport.isTrue
                    ? Get.find<DailyReportsViewModel>().listUserAns.isEmpty
                        ? Padding(
                            padding: const EdgeInsets.symmetric(vertical: 6.0),
                            child: ListItem(
                              title: StringConstants.dailyReports,
                              onTab: () async {
                                final DailyReportsViewModel dailyReportsViewModel =
                                    Get.put(DailyReportsViewModel(), permanent: true);
                                showLoader();
                                await dailyReportsViewModel.fetchUserDailyReportAns(
                                  date: changeDateStringFormat(
                                    date: DateTime.now().toString(),
                                    format: DateFormatHelper.ymdFormat,
                                  ),
                                );
                                hideLoader();
                                if (context.mounted) {
                                  if (dailyReportsViewModel.listUserAns.isEmpty) {
                                    NavigationHelper.pushScreenWithNavBar(
                                        widget: DailyReportQuestionView(
                                          date: changeDateStringFormat(
                                            date: DateTime.now().toString(),
                                            format: DateFormatHelper.ymdFormat,
                                          ),
                                        ),
                                        context: context);
                                  } else {
                                    NavigationHelper.pushScreenWithNavBar(
                                        widget: const DailyReportListView(), context: context);
                                  }
                                }
                              },
                              icon: Assets.iconsIcReport,
                              reminder: StringConstants.reportIsAvailableForCompletion,
                              showReminderIcon: true,
                              reminderColor: AppColors.surfaceError,
                            ),
                          )
                        : Padding(
                            padding: const EdgeInsets.symmetric(vertical: 6.0),
                            child: ListItem(
                              title: StringConstants.dailyReports,
                              onTab: () async {
                                final DailyReportsViewModel dailyReportsViewModel =
                                    Get.put(DailyReportsViewModel(), permanent: true);
                                showLoader();
                                await dailyReportsViewModel.fetchUserDailyReportAns(
                                  date: changeDateStringFormat(
                                    date: DateTime.now().toString(),
                                    format: DateFormatHelper.ymdFormat,
                                  ),
                                );
                                hideLoader();
                                if (context.mounted) {
                                  if (dailyReportsViewModel.listUserAns.isEmpty) {
                                    NavigationHelper.pushScreenWithNavBar(
                                        widget: DailyReportQuestionView(
                                          date: changeDateStringFormat(
                                            date: DateTime.now().toString(),
                                            format: DateFormatHelper.ymdFormat,
                                          ),
                                        ),
                                        context: context);
                                  } else {
                                    NavigationHelper.pushScreenWithNavBar(
                                        widget: const DailyReportListView(), context: context);
                                  }
                                }
                              },
                              icon: Assets.iconsIcReport,
                            ),
                          )
                    : const SizedBox(),
              ),
              Obx(
                () => Get.find<UserViewModel>().isWeeklyReport.isTrue
                    ? Get.find<WeeklyReportViewModel>().listUserAns.isEmpty
                        ? Padding(
                            padding: const EdgeInsets.symmetric(vertical: 6.0),
                            child: ListItem(
                              title: StringConstants.weeklyReports,
                              onTab: () async {
                                final WeeklyReportViewModel weeklyReportViewModel =
                                    Get.put(WeeklyReportViewModel(), permanent: true);
                                if (Get.find<UserViewModel>().userPlanDetail.value.plan?.activeDay ==
                                    "saturday") {
                                  showLoader();
                                  await weeklyReportViewModel.fetchUserWeeklyReportAns(
                                    date: changeDateStringFormat(
                                      date: DateTime.now().toString(),
                                      format: DateFormatHelper.ymdFormat,
                                    ),
                                  );
                                  hideLoader();
                                  if (context.mounted) {
                                    if (weeklyReportViewModel.listUserAns.isEmpty) {
                                      NavigationHelper.pushScreenWithNavBar(
                                        widget: WeeklyReportQuestionView(
                                          date: changeDateStringFormat(
                                            date: DateTime.now().toString(),
                                            format: DateFormatHelper.ymdFormat,
                                          ),
                                        ),
                                        context: context,
                                      );
                                    } else {
                                      NavigationHelper.pushScreenWithNavBar(
                                          widget: const WeeklyReportListView(), context: context);
                                    }
                                  }
                                } else {
                                  NavigationHelper.pushScreenWithNavBar(
                                      widget: const WeeklyReportListView(), context: context);
                                }
                              },
                              icon: Assets.iconsIcReport,
                              reminder: StringConstants.reportIsAvailableForCompletion,
                              showReminderIcon: true,
                              reminderColor: AppColors.surfaceError,
                            ),
                          )
                        : Padding(
                            padding: const EdgeInsets.symmetric(vertical: 6.0),
                            child: ListItem(
                              title: StringConstants.weeklyReports,
                              onTab: () async {
                                final WeeklyReportViewModel weeklyReportViewModel =
                                    Get.put(WeeklyReportViewModel(), permanent: true);
                                if (Get.find<UserViewModel>().userPlanDetail.value.plan?.activeDay ==
                                    "saturday") {
                                  showLoader();
                                  await weeklyReportViewModel.fetchUserWeeklyReportAns(
                                    date: changeDateStringFormat(
                                      date: DateTime.now().toString(),
                                      format: DateFormatHelper.ymdFormat,
                                    ),
                                  );
                                  hideLoader();
                                  if (context.mounted) {
                                    if (weeklyReportViewModel.listUserAns.isEmpty) {
                                      NavigationHelper.pushScreenWithNavBar(
                                        widget: WeeklyReportQuestionView(
                                          date: changeDateStringFormat(
                                            date: DateTime.now().toString(),
                                            format: DateFormatHelper.ymdFormat,
                                          ),
                                        ),
                                        context: context,
                                      );
                                    } else {
                                      NavigationHelper.pushScreenWithNavBar(
                                          widget: const WeeklyReportListView(), context: context);
                                    }
                                  }
                                } else {
                                  NavigationHelper.pushScreenWithNavBar(
                                      widget: const WeeklyReportListView(), context: context);
                                }
                              },
                              icon: Assets.iconsIcReport,
                            ),
                          )
                    : const SizedBox(),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 6.0),
                child: ListItem(
                  title: StringConstants.intuitiveWritingForMyself,
                  onTab: () {
                    NavigationHelper.pushScreenWithNavBar(
                        widget: const IntuitiveWritingListView(), context: context);
                  },
                  icon: Assets.iconsIcWriting,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 6.0),
                child: ListItem(
                  title: StringConstants.mySuccesses,
                  onTab: () {
                    NavigationHelper.pushScreenWithNavBar(
                        widget: const MyAchievementsView(), context: context);
                  },
                  icon: Assets.iconsIcAchievements,
                ),
              ),
              Obx(
                () => Get.find<UserViewModel>().isFastingModule.isTrue
                    ? Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6.0),
                        child: ListItem(
                          title: StringConstants.fastingCalculator,
                          onTab: () async {
                            final FastingCalculatorViewModel fastingCalculatorViewModel =
                                Get.find<FastingCalculatorViewModel>();

                            var isSuccess = await fastingCalculatorViewModel.getTodayFastingData();
                            if (context.mounted) {
                              if (isSuccess && fastingCalculatorViewModel.todayStartTime.isNotEmpty) {
                                NavigationHelper.pushScreenWithNavBar(
                                    widget: const FastingTimerView(), context: context);
                              } else {
                                NavigationHelper.pushScreenWithNavBar(
                                    widget: const FastingCalculatorLeadingView(), context: context);
                              }
                            }
                          },
                          icon: Assets.iconsIcFastingCalculator,
                        ),
                      )
                    : const SizedBox(),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 6.0),
                child: ListItem(
                  title: StringConstants.nutritionalInformation,
                  onTab: () {
                    NavigationHelper.pushScreenWithNavBar(
                        widget: const NutritionalInformationListView(), context: context);
                  },
                  icon: Assets.iconsIcInformation,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 6.0),
                child: ListItem(
                  title: StringConstants.vegetableChallenge,
                  onTab: () {
                    NavigationHelper.pushScreenWithNavBar(
                      widget: const VegetableChallengeView(),
                      context: context,
                    );
                  },
                  icon: Assets.iconsIcNutritionPlanning,
                ),
              ),
              const Gap(80),
            ],
          ),
        ),
      ),
    );
  }
}
