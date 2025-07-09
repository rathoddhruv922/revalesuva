import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:revalesuva/components/custom_click.dart';
import 'package:revalesuva/components/custom_text.dart';
import 'package:revalesuva/utils/app_colors.dart';
import 'package:revalesuva/utils/helper_method.dart';
import 'package:revalesuva/utils/navigation_helper.dart';
import 'package:revalesuva/utils/strings_constant.dart';
import 'package:revalesuva/view_models/tools/daily_reports_view_model.dart';
import 'package:revalesuva/views/tools/widget/report_answer_item.dart';

class DailyReportAnsView extends StatefulWidget {
  const DailyReportAnsView({
    super.key,
    required this.date,
    required this.day,
  });

  final String date;
  final String day;

  @override
  State<DailyReportAnsView> createState() => _DailyReportAnsViewState();
}

class _DailyReportAnsViewState extends State<DailyReportAnsView> {
  final DailyReportsViewModel dailyReportsViewModel = Get.find<DailyReportsViewModel>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      dailyReportsViewModel.isLoading.value = true;
      dailyReportsViewModel.listCreateUserAns.clear();
      await dailyReportsViewModel.fetchDailyReportQuestions();
      await dailyReportsViewModel.fetchUserDailyReportAns(date: widget.date);
      dailyReportsViewModel.isLoading.value = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        NavigationHelper.onBackScreen(
          widget: DailyReportAnsView(
            date: widget.date,
            day: widget.day,
          ),
        );
      },
      canPop: true,
      child: Scaffold(
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
                  text: "< ${StringConstants.backTo} ${StringConstants.tools}",
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
              CustomCard2(
                color: AppColors.surfaceTertiary,
                child: Obx(
                  () => ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.all(0),
                    itemBuilder: (context, index) {
                      // var answer = dailyReportsViewModel.listUserAns.firstWhereOrNull(
                      //   (element) => element.questionId == dailyReportsViewModel.listDailyQuestion[index].id,
                      // );
                      return ReportAnswerItem(
                        question:
                            "${index + 1}. ${dailyReportsViewModel.listUserAns[index].question?.question ?? ""}",
                        answer: dailyReportsViewModel.listUserAns[index],
                      );
                    },
                    itemCount: dailyReportsViewModel.listUserAns.length,
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
