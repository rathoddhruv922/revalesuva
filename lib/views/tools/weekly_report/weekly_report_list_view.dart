import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:revalesuva/components/custom_click.dart';
import 'package:revalesuva/components/custom_text.dart';
import 'package:revalesuva/utils/app_colors.dart';
import 'package:revalesuva/utils/helper_method.dart';
import 'package:revalesuva/utils/navigation_helper.dart';
import 'package:revalesuva/utils/strings_constant.dart';
import 'package:revalesuva/view_models/tools/weekly_report_view_model.dart';
import 'package:revalesuva/view_models/user_view_model.dart';
import 'package:revalesuva/views/tools/weekly_report/widget/weekly_report_list_item.dart';

class WeeklyReportListView extends StatefulWidget {
  const WeeklyReportListView({super.key});

  @override
  State<WeeklyReportListView> createState() => _WeeklyReportListViewState();
}

class _WeeklyReportListViewState extends State<WeeklyReportListView> {
  final WeeklyReportViewModel weeklyReportViewModel = Get.find<WeeklyReportViewModel>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        weeklyReportViewModel.isLoading.value = false;
        weeklyReportViewModel.isLoadingMore.value = false;
        weeklyReportViewModel.listReport.clear();
        weeklyReportViewModel.currentPage.value = 1;
        weeklyReportViewModel.total.value = 1;
        weeklyReportViewModel.fetchWeeklyReportList();
        weeklyReportViewModel.setupScrollController();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        NavigationHelper.onBackScreen(widget: const WeeklyReportListView());
      },
      canPop: true,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20),
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
              TextHeadlineMedium(
                text: StringConstants.dailyReports,
                color: AppColors.textPrimary,
                letterSpacing: 0,
              ),
              const Gap(12),
              Expanded(
                child: Obx(
                  () => weeklyReportViewModel.isLoading.isTrue
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomShimmer(
                              height: 10.h,
                              width: 100.w,
                              radius: 15,
                            ),
                          ],
                        )
                      : weeklyReportViewModel.listReport.isNotEmpty
                          ? RefreshIndicator(
                              onRefresh: () {
                                weeklyReportViewModel.currentPage.value = 1;
                                weeklyReportViewModel.listReport.clear();
                                return weeklyReportViewModel.fetchWeeklyReportList();
                              },
                              child: ListView.separated(
                                itemBuilder: (context, index) {
                                  return WeeklyReportListItem(
                                    data: weeklyReportViewModel.listReport[index],
                                    count: "${weeklyReportViewModel.listReport.length - index}",
                                    weeks: calculateDateGap(
                                        date: "${weeklyReportViewModel.listReport[index].date ?? ""}"),
                                  );
                                },
                                separatorBuilder: (context, index) => const Gap(10),
                                itemCount: weeklyReportViewModel.listReport.length,
                              ),
                            )
                          : RefreshIndicator(
                              onRefresh: () {
                                weeklyReportViewModel.currentPage.value = 1;
                                weeklyReportViewModel.listReport.clear();
                                return weeklyReportViewModel.fetchWeeklyReportList();
                              },
                              child: SingleChildScrollView(
                                physics: const AlwaysScrollableScrollPhysics(),
                                child: Container(
                                  alignment: Alignment.center,
                                  height: 50.h,
                                  child: TextHeadlineMedium(text: StringConstants.noDataFound),
                                ),
                              ),
                            ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  calculateDateGap({required String date}) {
    if (Get.find<UserViewModel>().userPlanDetail.value.plan?.planCycles?.isNotEmpty ?? false) {
      // Define the two dates
      DateTime startDate = DateTime.tryParse(Get.find<UserViewModel>()
                  .userPlanDetail
                  .value
                  .plan
                  ?.planCycles
                  ?.first
                  .startDate
                  .toString() ??
              "") ??
          DateTime.now();
      DateTime endDate = DateTime.tryParse(date) ?? DateTime.now();

      int differenceInDays = endDate.difference(startDate).inDays;

      // Calculate the difference in weeks
      int differenceInWeeks = (differenceInDays / 7).ceil();

      return differenceInWeeks.toString();
    } else {
      return "";
    }
  }
}
