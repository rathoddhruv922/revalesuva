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
import 'package:revalesuva/view_models/trainer/trainer_weekly_report_view_model.dart';
import 'package:revalesuva/views/tools/widget/report_answer_item.dart';
import 'package:revalesuva/views/trainer/widget/drawer_widget.dart';

class CustomerWeeklyReportDetailView extends StatefulWidget {
  const CustomerWeeklyReportDetailView({
    super.key,
    required this.date,
    required this.userData,
  });

  final String date;
  final customer_model.Datum userData;

  @override
  State<CustomerWeeklyReportDetailView> createState() => _CustomerWeeklyReportDetailViewState();
}

class _CustomerWeeklyReportDetailViewState extends State<CustomerWeeklyReportDetailView> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  final TrainerWeeklyReportViewModel trainerWeeklyReportViewModel =
      Get.find<TrainerWeeklyReportViewModel>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      trainerWeeklyReportViewModel.isLoading.value = true;
      await trainerWeeklyReportViewModel.fetchWeeklyReportQuestions();
      await trainerWeeklyReportViewModel.fetchUserWeeklyReportAns(
        date: widget.date,
        customerId: "${widget.userData.id}",
      );
      trainerWeeklyReportViewModel.isLoading.value = false;
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
                text: "< ${StringConstants.backTo} ${StringConstants.weeklyReport}",
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
            Obx(
              () => trainerWeeklyReportViewModel.isLoading.isTrue
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
                            // var answer = trainerWeeklyReportViewModel.listUserAns.firstWhereOrNull(
                            //   (element) =>
                            //       element.questionId ==
                            //       trainerWeeklyReportViewModel.listWeeklyQuestion[index].id,
                            // );
                            return ReportAnswerItem(
                              question:
                                  "${index + 1}. ${trainerWeeklyReportViewModel.listUserAns[index].question}",
                              answer: trainerWeeklyReportViewModel.listUserAns[index],
                            );
                          },
                          itemCount: trainerWeeklyReportViewModel.listUserAns.length,
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
