import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:revalesuva/components/custom_appbar.dart';
import 'package:revalesuva/components/custom_click.dart';
import 'package:revalesuva/components/custom_text.dart';
import 'package:revalesuva/model/trainer/home/customer_model.dart' as customer_model;
import 'package:revalesuva/utils/app_colors.dart';
import 'package:revalesuva/utils/app_corner.dart';
import 'package:revalesuva/utils/helper_method.dart';
import 'package:revalesuva/utils/strings_constant.dart';
import 'package:revalesuva/view_models/trainer/trainer_daily_report_view_model.dart';
import 'package:revalesuva/views/tools/widget/report_answer_item.dart';
import 'package:revalesuva/views/trainer/widget/drawer_widget.dart';

class CustomerDailyReportDetailView extends StatefulWidget {
  const CustomerDailyReportDetailView({
    super.key,
    required this.date,
    required this.userData, required this.day,
  });

  final String date;
  final customer_model.Datum userData;
  final String day;

  @override
  State<CustomerDailyReportDetailView> createState() => _CustomerDailyReportDetailViewState();
}

class _CustomerDailyReportDetailViewState extends State<CustomerDailyReportDetailView> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  final TrainerDailyReportViewModel trainerDailyReportViewModel =
      Get.find<TrainerDailyReportViewModel>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      trainerDailyReportViewModel.isLoading.value = true;
      await trainerDailyReportViewModel.fetchUserDailyReportAns(
          date: widget.date, customerId: "${widget.userData.id}");
      trainerDailyReportViewModel.isLoading.value = false;
    });
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
        child: ListView(
          shrinkWrap: true,
          children: [
            CustomClick(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: TextBodySmall(
                text: "< ${StringConstants.backTo} ${StringConstants.dailyReports}",
                color: AppColors.textPrimary,
                letterSpacing: 0,
              ),
            ),
            const Gap(10),
            TextHeadlineMedium(
              text: StringConstants.dailyReportDay.replaceAll("{}", widget.day),
              color: AppColors.textPrimary,
              letterSpacing: 0,
            ),
            const Gap(12),
            Obx(
              () => trainerDailyReportViewModel.isLoading.isTrue
                  ? const CustomShimmer(
                      height: 250,
                      radius: AppCorner.listTile,
                    )
                  : CustomCard2(
                      color: AppColors.surfaceTertiary,
                      child: Obx(
                        () => ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          padding: const EdgeInsets.all(0),
                          itemBuilder: (context, index) {
                            // var answer = trainerDailyReportViewModel.listUserAns.firstWhereOrNull(
                            //   (element) =>
                            //       element.questionId ==
                            //       trainerDailyReportViewModel.listDailyQuestion[index].id,
                            // );
                            return ReportAnswerItem(
                              question:
                                  "${index + 1}. ${trainerDailyReportViewModel.listUserAns[index].question?.question}",
                              answer: trainerDailyReportViewModel.listUserAns[index],
                            );
                          },
                          itemCount: trainerDailyReportViewModel.listUserAns.length,
                        ),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
