import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:revalesuva/components/custom_click.dart';
import 'package:revalesuva/components/custom_text.dart';
import 'package:revalesuva/utils/app_colors.dart';
import 'package:revalesuva/utils/date_format_helper.dart';
import 'package:revalesuva/utils/helper_method.dart';
import 'package:revalesuva/utils/navigation_helper.dart';
import 'package:revalesuva/utils/strings_constant.dart';
import 'package:revalesuva/view_models/tools/daily_reports_view_model.dart';
import 'package:revalesuva/view_models/user_view_model.dart';
import 'package:revalesuva/views/tools/daily_report/daily_report_ans_view.dart';
import 'package:revalesuva/views/tools/daily_report/widget/daily_report_list_item.dart';

class DailyReportListView extends StatefulWidget {
  const DailyReportListView({super.key});

  @override
  State<DailyReportListView> createState() => _DailyReportListViewState();
}

class _DailyReportListViewState extends State<DailyReportListView> {
  final DailyReportsViewModel dailyReportsViewModel = Get.find<DailyReportsViewModel>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        dailyReportsViewModel.isLoading.value = false;
        dailyReportsViewModel.isLoadingMore.value = false;
        dailyReportsViewModel.listReport.clear();
        dailyReportsViewModel.currentPage.value = 1;
        dailyReportsViewModel.total.value = 1;
        dailyReportsViewModel.fetchDailyReportList();
        dailyReportsViewModel.setupScrollController();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        NavigationHelper.onBackScreen(widget: const DailyReportListView());
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
                  () => dailyReportsViewModel.isLoading.isTrue
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
                      : dailyReportsViewModel.listReport.isNotEmpty
                          ? RefreshIndicator(
                              onRefresh: () {
                                dailyReportsViewModel.currentPage.value = 1;
                                dailyReportsViewModel.listReport.clear();
                                return dailyReportsViewModel.fetchDailyReportList();
                              },
                              child: ListView.separated(
                                controller: dailyReportsViewModel.scrollController,
                                itemBuilder: (context, index) {
                                  return CustomClick(
                                    onTap: () {
                                      NavigationHelper.pushScreenWithNavBar(
                                        widget: DailyReportAnsView(
                                          date: changeDateStringFormat(
                                            date:
                                                dailyReportsViewModel.listReport[index].date.toString(),
                                            format: DateFormatHelper.ymdFormat,
                                          ),
                                          day: calculateDateGap(
                                              date: "${dailyReportsViewModel.listReport[index].date}"),
                                        ),
                                        context: context,
                                      );
                                    },
                                    child: DailyReportListItem(
                                      data: dailyReportsViewModel.listReport[index],
                                      count: "${dailyReportsViewModel.listReport.length - index}",
                                      day: calculateDateGap(
                                          date: "${dailyReportsViewModel.listReport[index].date}"),
                                    ),
                                  );
                                },
                                separatorBuilder: (context, index) => const Gap(10),
                                itemCount: dailyReportsViewModel.listReport.length,
                              ),
                            )
                          : RefreshIndicator(
                              onRefresh: () {
                                dailyReportsViewModel.currentPage.value = 1;
                                dailyReportsViewModel.listReport.clear();
                                return dailyReportsViewModel.fetchDailyReportList();
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
    // Define the two dates
    if(Get.find<UserViewModel>().userPlanDetail.value.plan?.planCycles?.isNotEmpty ?? false){
      DateTime startDate =
          DateTime.tryParse(Get.find<UserViewModel>().userPlanDetail.value.plan?.planCycles?.first.startDate.toString() ?? "") ??
              DateTime.now();
      DateTime endDate = DateTime.tryParse(date) ?? DateTime.now();

      // Calculate the difference in days
      int differenceInDays = endDate.difference(startDate).inDays;
      return differenceInDays.toString();
    }else{
      return "";
    }

  }
}
