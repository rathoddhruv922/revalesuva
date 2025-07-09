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
import 'package:revalesuva/view_models/trainer/trainer_daily_report_view_model.dart';
import 'package:revalesuva/views/tools/daily_report/widget/daily_report_list_item.dart';
import 'package:revalesuva/views/trainer/widget/drawer_widget.dart';

class CustomerDailyReportListView extends StatefulWidget {
  const CustomerDailyReportListView({super.key, required this.userData});

  final customer_model.Datum userData;

  @override
  State<CustomerDailyReportListView> createState() => _CustomerDailyReportListViewState();
}

class _CustomerDailyReportListViewState extends State<CustomerDailyReportListView> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  final TrainerDailyReportViewModel trainerDailyReportViewModel = Get.put(TrainerDailyReportViewModel());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        trainerDailyReportViewModel.isLoading.value = false;
        trainerDailyReportViewModel.listReport.clear();
        trainerDailyReportViewModel.currentPage.value = 1;
        trainerDailyReportViewModel.total.value = 1;
        trainerDailyReportViewModel.getCustomerDetailById(customerId: "${widget.userData.id ?? ""}");
        trainerDailyReportViewModel.fetchDailyReportList(customerId: "${widget.userData.id ?? ""}");
        trainerDailyReportViewModel.setupScrollController(customerId: "${widget.userData.id ?? ""}");
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
              text: StringConstants.dailyReports,
              color: AppColors.textPrimary,
              letterSpacing: 0,
            ),
            const Gap(12),
            Expanded(
              child: Obx(
                () => trainerDailyReportViewModel.isLoading.isTrue
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
                    : trainerDailyReportViewModel.listReport.isNotEmpty
                        ? RefreshIndicator(
                            onRefresh: () {
                              trainerDailyReportViewModel.currentPage.value = 1;
                              trainerDailyReportViewModel.listReport.clear();
                              return trainerDailyReportViewModel.fetchDailyReportList(
                                  customerId: "${widget.userData.id ?? ""}");
                            },
                            child: ListView.separated(
                              controller: trainerDailyReportViewModel.scrollController,
                              itemBuilder: (context, index) {
                                return CustomClick(
                                  onTap: () {
                                    Get.toNamed(
                                      RoutesName.customerDailyReportDetailView,
                                      arguments: [
                                        widget.userData,
                                        changeDateStringFormat(
                                          date: trainerDailyReportViewModel.listReport[index].date
                                              .toString(),
                                          format: DateFormatHelper.ymdFormat,
                                        ),
                                        calculateDateGap(
                                            date:
                                                "${trainerDailyReportViewModel.listReport[index].date}")
                                      ],
                                    );
                                  },
                                  child: DailyReportListItem(
                                    data: trainerDailyReportViewModel.listReport[index],
                                    count: "${trainerDailyReportViewModel.listReport.length - index}",
                                    day: calculateDateGap(
                                        date: "${trainerDailyReportViewModel.listReport[index].date}"),
                                  ),
                                );
                              },
                              separatorBuilder: (context, index) => const Gap(10),
                              itemCount: trainerDailyReportViewModel.listReport.length,
                            ),
                          )
                        : RefreshIndicator(
                            onRefresh: () {
                              trainerDailyReportViewModel.currentPage.value = 1;
                              trainerDailyReportViewModel.listReport.clear();
                              return trainerDailyReportViewModel.fetchDailyReportList(
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
              () => trainerDailyReportViewModel.isLoadingMore.value
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
    DateTime startDate =
        DateTime.tryParse(trainerDailyReportViewModel.userData.value.plans?.first.startDatetime ?? "") ??
            DateTime.now();
    DateTime endDate = DateTime.tryParse(date) ?? DateTime.now();

    // Calculate the difference in days
    int differenceInDays = endDate.difference(startDate).inDays;

    return differenceInDays.toString();
  }
}
