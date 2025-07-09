import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:revalesuva/components/custom_appbar.dart';
import 'package:revalesuva/components/custom_click.dart';
import 'package:revalesuva/components/custom_text.dart';
import 'package:revalesuva/model/trainer/home/customer_model.dart' as customer_model;
import 'package:revalesuva/utils/app_colors.dart';
import 'package:revalesuva/utils/date_format_helper.dart';
import 'package:revalesuva/utils/helper_method.dart';
import 'package:revalesuva/utils/router.dart';
import 'package:revalesuva/utils/strings_constant.dart';
import 'package:revalesuva/view_models/trainer/trainer_weekly_report_view_model.dart';
import 'package:revalesuva/views/tools/weekly_report/widget/weekly_report_list_item.dart';
import 'package:revalesuva/views/trainer/widget/drawer_widget.dart';

class CustomerWeeklyReportListView extends StatefulWidget {
  const CustomerWeeklyReportListView({super.key, required this.userData});

  final customer_model.Datum userData;

  @override
  State<CustomerWeeklyReportListView> createState() => _CustomerWeeklyReportListViewState();
}

class _CustomerWeeklyReportListViewState extends State<CustomerWeeklyReportListView> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  final TrainerWeeklyReportViewModel trainerWeeklyReportViewModel =
      Get.put(TrainerWeeklyReportViewModel(), permanent: true);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        trainerWeeklyReportViewModel.isLoading.value = false;
        trainerWeeklyReportViewModel.listReport.clear();
        trainerWeeklyReportViewModel.currentPage.value = 1;
        trainerWeeklyReportViewModel.total.value = 1;
        trainerWeeklyReportViewModel.getCustomerDetailById(customerId: "${widget.userData.id ?? ""}");
        trainerWeeklyReportViewModel.fetchWeeklyReportList(customerId: "${widget.userData.id ?? ""}");
        trainerWeeklyReportViewModel.setupScrollController(customerId: "${widget.userData.id ?? ""}");
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: customAppBarTrainer(
        key: scaffoldKey,
      ),
      drawer: DrawerWidget(
        drawerKey: scaffoldKey,
      ),
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
                text: "< ${StringConstants.backTo} ${StringConstants.customerOptions}",
                color: AppColors.textPrimary,
                letterSpacing: 0,
              ),
            ),
            const Gap(10),
            TextHeadlineMedium(
              text: StringConstants.weeklyReport,
              color: AppColors.textPrimary,
              letterSpacing: 0,
            ),
            const Gap(12),
            Expanded(
              child: Obx(
                () => trainerWeeklyReportViewModel.isLoading.isTrue
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
                    : trainerWeeklyReportViewModel.listReport.isNotEmpty
                        ? RefreshIndicator(
                            onRefresh: () {
                              trainerWeeklyReportViewModel.currentPage.value = 1;
                              trainerWeeklyReportViewModel.listReport.clear();
                              return trainerWeeklyReportViewModel.fetchWeeklyReportList(
                                  customerId: "${widget.userData.id ?? ""}");
                            },
                            child: ListView.separated(
                              controller: trainerWeeklyReportViewModel.scrollController,
                              itemBuilder: (context, index) {
                                return CustomClick(
                                  onTap: () {
                                    Get.toNamed(
                                      RoutesName.customerWeeklyReportDetailView,
                                      arguments: [
                                        widget.userData,
                                        changeDateStringFormat(
                                          date: trainerWeeklyReportViewModel.listReport[index].date
                                              .toString(),
                                          format: DateFormatHelper.ymdFormat,
                                        ),
                                      ],
                                    );
                                  },
                                  child: WeeklyReportListItem(
                                    data: trainerWeeklyReportViewModel.listReport[index],
                                    count: "${trainerWeeklyReportViewModel.listReport.length - index}",
                                    weeks: calculateDateGap(
                                        date:
                                            "${trainerWeeklyReportViewModel.listReport[index].date ?? ""}"),
                                  ),
                                );
                              },
                              separatorBuilder: (context, index) => const Gap(10),
                              itemCount: trainerWeeklyReportViewModel.listReport.length,
                            ),
                          )
                        : RefreshIndicator(
                            onRefresh: () {
                              trainerWeeklyReportViewModel.currentPage.value = 1;
                              trainerWeeklyReportViewModel.listReport.clear();
                              return trainerWeeklyReportViewModel.fetchWeeklyReportList(
                                customerId: "${widget.userData.id ?? ""}",
                              );
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
            Obx(
              () => trainerWeeklyReportViewModel.isLoadingMore.value
                  ? const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: CupertinoActivityIndicator(
                        radius: 15,
                      ),
                    )
                  : const SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }

  calculateDateGap({required String date}) {
    // Define the two dates
    DateTime startDate = DateTime.tryParse(
            trainerWeeklyReportViewModel.userData.value.plans?.first.startDatetime ?? "") ??
        DateTime.now();
    DateTime endDate = DateTime.tryParse(date) ?? DateTime.now();

    int differenceInDays = endDate.difference(startDate).inDays;

    // Calculate the difference in weeks
    int differenceInWeeks = (differenceInDays / 7).ceil();

    return differenceInWeeks.toString();
  }
}
