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
import 'package:revalesuva/view_models/tools/daily_reports_view_model.dart';
import 'package:revalesuva/views/tools/widget/report_question_answer_widget.dart';

class DailyReportQuestionView extends StatefulWidget {
  const DailyReportQuestionView({
    super.key,
    required this.date,
  });

  final String date;

  @override
  State<DailyReportQuestionView> createState() => _DailyReportQuestionViewState();
}

class _DailyReportQuestionViewState extends State<DailyReportQuestionView> {
  final DailyReportsViewModel dailyReportsViewModel = Get.find<DailyReportsViewModel>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      dailyReportsViewModel.isLoading.value = true;
      dailyReportsViewModel.listCreateUserAns.clear();
      await dailyReportsViewModel.fetchDailyReportQuestions();
      // await dailyReportsViewModel.fetchUserDailyReportAns(date: "2025-01-07");
      dailyReportsViewModel.isLoading.value = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        NavigationHelper.onBackScreen(
          widget: DailyReportQuestionView(
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
                  text: StringConstants.dailyReportDay.replaceAll(
                      "{}",
                      dailyReportsViewModel.listDailyQuestion.isNotEmpty
                          ? dailyReportsViewModel.listDailyQuestion.first.day.toString()
                          : "0"),
                  color: AppColors.textPrimary,
                  letterSpacing: 0,
                ),
              ),
              const Gap(12),
              CustomCard2(
                color: AppColors.surfaceTertiary,
                child: Obx(
                  () => dailyReportsViewModel.isLoading.isTrue
                      ? const CupertinoActivityIndicator(
                          radius: 15,
                        )
                      : dailyReportsViewModel.listDailyQuestion.isNotEmpty
                          ? ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              padding: const EdgeInsets.all(0),
                              itemBuilder: (context, index) {
                                var answer = dailyReportsViewModel.listCreateUserAns.indexWhere(
                                  (element) =>
                                      element.questionId ==
                                      dailyReportsViewModel.listDailyQuestion[index].id,
                                );
                                return ReportQuestionAnswerWidget(
                                  question: dailyReportsViewModel.listDailyQuestion[index],
                                  answer: answer != -1
                                      ? dailyReportsViewModel.listCreateUserAns[answer]
                                      : null,
                                  index: index,
                                  onChange: (value, subAns, index) {
                                    dailyReportsViewModel.addUserAns(
                                      currentQuestionIndex: index,
                                      answer: value ?? "",
                                      subAnswer: subAns,
                                    );
                                    dailyReportsViewModel.listDailyQuestion.refresh();
                                  },
                                  onTextChange: (String? value) {
                                    if (dailyReportsViewModel.listDailyQuestion[index].answerType ==
                                        "input_box") {
                                      dailyReportsViewModel.addUserAns(
                                        currentQuestionIndex: index,
                                        answer: value ?? "",
                                        subAnswer: value ?? "",
                                      );
                                    } else {
                                      dailyReportsViewModel.addUserAns(
                                        currentQuestionIndex: index,
                                        answer:
                                            dailyReportsViewModel.listCreateUserAns[answer].answer ?? "",
                                        subAnswer: value ?? "",
                                      );
                                    }
                                  },
                                );
                              },
                              itemCount: dailyReportsViewModel.listDailyQuestion.length,
                            )
                          : noDataFoundWidget(),
                ),
              ),
              const Gap(20),
              Obx(
                () => dailyReportsViewModel.listDailyQuestion.isNotEmpty
                    ? SimpleButton(
                        text: StringConstants.reportApproval,
                        onPressed: () async {
                          var isSuccess = await dailyReportsViewModel.submitUserDailyReportAns();
                          if (isSuccess && context.mounted) {
                            Navigator.of(context).pop();
                          }
                        },
                      )
                    : const SizedBox(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
