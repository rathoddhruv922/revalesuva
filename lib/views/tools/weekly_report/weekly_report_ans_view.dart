import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:revalesuva/components/custom_click.dart';
import 'package:revalesuva/components/custom_text.dart';
import 'package:revalesuva/utils/app_colors.dart';
import 'package:revalesuva/utils/helper_method.dart';
import 'package:revalesuva/utils/navigation_helper.dart';
import 'package:revalesuva/utils/strings_constant.dart';
import 'package:revalesuva/view_models/tools/weekly_report_view_model.dart';
import 'package:revalesuva/views/tools/widget/report_answer_item.dart';

class WeeklyReportAnsView extends StatefulWidget {
  const WeeklyReportAnsView({
    super.key,
    required this.date,
    required this.week,
  });

  final String date;
  final String week;

  @override
  State<WeeklyReportAnsView> createState() => _DailyReportAnsViewState();
}

class _DailyReportAnsViewState extends State<WeeklyReportAnsView> {
  final WeeklyReportViewModel weeklyReportViewModel = Get.find<WeeklyReportViewModel>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      weeklyReportViewModel.isLoading.value = true;
      weeklyReportViewModel.listCreateUserAns.clear();
      await weeklyReportViewModel.fetchWeeklyReportQuestions();
      await weeklyReportViewModel.fetchUserWeeklyReportAns(date: widget.date);
      weeklyReportViewModel.isLoading.value = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        NavigationHelper.onBackScreen(
          widget: WeeklyReportAnsView(
            date: widget.date,
            week: widget.week,
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
                text: StringConstants.weeklyReportNo.replaceAll("{}", widget.week),
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
                      // var answer = weeklyReportViewModel.listUserAns.firstWhereOrNull(
                      //   (element) => element.questionId == weeklyReportViewModel.listWeeklyQuestion[index].id,
                      // );
                      return ReportAnswerItem(
                        question:
                            "${index + 1}. ${weeklyReportViewModel.listUserAns[index].question?.question}",
                        answer: weeklyReportViewModel.listUserAns[index],
                      );
                    },
                    itemCount: weeklyReportViewModel.listUserAns.length,
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
