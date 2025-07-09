import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:revalesuva/components/custom_button.dart';
import 'package:revalesuva/components/custom_click.dart';
import 'package:revalesuva/components/custom_text.dart';
import 'package:revalesuva/utils/app_colors.dart';
import 'package:revalesuva/utils/helper_method.dart';
import 'package:revalesuva/utils/navigation_helper.dart';
import 'package:revalesuva/utils/strings_constant.dart';
import 'package:revalesuva/view_models/tools/weekly_report_view_model.dart';
import 'package:revalesuva/views/tools/widget/report_question_answer_widget.dart';

class WeeklyReportQuestionView extends StatefulWidget {
  const WeeklyReportQuestionView({
    super.key,
    required this.date,
  });

  final String date;

  @override
  State<WeeklyReportQuestionView> createState() => _WeeklyReportQuestionViewState();
}

class _WeeklyReportQuestionViewState extends State<WeeklyReportQuestionView> {
  final WeeklyReportViewModel weeklyReportViewModel = Get.find<WeeklyReportViewModel>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      weeklyReportViewModel.isLoading.value = true;
      weeklyReportViewModel.listCreateUserAns.clear();
      await weeklyReportViewModel.fetchWeeklyReportQuestions();
      weeklyReportViewModel.isLoading.value = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        NavigationHelper.onBackScreen(
          widget: WeeklyReportQuestionView(
            date: widget.date,
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
              Obx(
                () => TextHeadlineMedium(
                  text: StringConstants.weeklyReportNo.replaceAll(
                      "{}",
                      weeklyReportViewModel.listWeeklyQuestion.isNotEmpty
                          ? weeklyReportViewModel.listWeeklyQuestion.first.day.toString()
                          : "0"),
                  color: AppColors.textPrimary,
                  letterSpacing: 0,
                ),
              ),
              const Gap(12),
              CustomCard2(
                color: AppColors.surfaceTertiary,
                child: Obx(
                  () => weeklyReportViewModel.isLoading.isTrue
                      ? const CupertinoActivityIndicator(
                          radius: 15,
                        )
                      : weeklyReportViewModel.listWeeklyQuestion.isNotEmpty
                          ? ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              padding: const EdgeInsets.all(0),
                              itemBuilder: (context, index) {
                                var answer = weeklyReportViewModel.listCreateUserAns.indexWhere(
                                  (element) =>
                                      element.questionId ==
                                      weeklyReportViewModel.listWeeklyQuestion[index].id,
                                );
                                return ReportQuestionAnswerWidget(
                                  question: weeklyReportViewModel.listWeeklyQuestion[index],
                                  answer: answer != -1
                                      ? weeklyReportViewModel.listCreateUserAns[answer]
                                      : null,
                                  index: index,
                                  onChange: (value, subAns, index) {
                                    weeklyReportViewModel.addUserAns(
                                      currentQuestionIndex: index,
                                      answer: value ?? "",
                                      subAnswer: subAns,
                                    );
                                    weeklyReportViewModel.listWeeklyQuestion.refresh();
                                  },
                                  onTextChange: (String? value) {
                                    if (weeklyReportViewModel.listWeeklyQuestion[index].answerType ==
                                        "input_box") {
                                      weeklyReportViewModel.addUserAns(
                                        currentQuestionIndex: index,
                                        answer: value ?? "",
                                        subAnswer: value ?? "",
                                      );
                                    } else {
                                      weeklyReportViewModel.addUserAns(
                                        currentQuestionIndex: index,
                                        answer:
                                            weeklyReportViewModel.listCreateUserAns[answer].answer ?? "",
                                        subAnswer: value ?? "",
                                      );
                                    }
                                  },
                                );
                              },
                              itemCount: weeklyReportViewModel.listWeeklyQuestion.length,
                            )
                          : noDataFoundWidget(),
                ),
              ),
              const Gap(20),
              Obx(
                () => weeklyReportViewModel.listWeeklyQuestion.isNotEmpty
                    ? SimpleButton(
                        text: StringConstants.reportApproval,
                        onPressed: () async {
                          await weeklyReportViewModel.submitUserWeeklyReportAns();
                          if (context.mounted) {
                            Navigator.of(context).pop();
                          }
                        },
                      )
                    : const SizedBox(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
