import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:revalesuva/components/custom_text.dart';
import 'package:revalesuva/utils/app_colors.dart';
import 'package:revalesuva/utils/app_corner.dart';
import 'package:revalesuva/utils/helper_method.dart';
import 'package:revalesuva/utils/navigation_helper.dart';
import 'package:revalesuva/utils/strings_constant.dart';
import 'package:revalesuva/view_models/my_plan/program_completion_report_view_model.dart';
import 'package:revalesuva/views/my_plan/program_completion_report/after_image_form_view.dart';
import 'package:revalesuva/views/my_plan/program_completion_report/feedback_form_view.dart';
import 'package:revalesuva/views/my_plan/program_completion_report/general_question_view.dart';
import 'package:revalesuva/views/my_plan/program_completion_report/widget/question_progress_widget.dart';

class ProgramCompletionReportView extends StatefulWidget {
  const ProgramCompletionReportView({super.key});

  @override
  State<ProgramCompletionReportView> createState() => _ProgramCompletionReportViewState();
}

class _ProgramCompletionReportViewState extends State<ProgramCompletionReportView> {
  final ProgramCompletionReportViewModel programCompletionReportViewModel = Get.put(
    ProgramCompletionReportViewModel(),
    permanent: true,
  );

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        programCompletionReportViewModel.isLoading.value = true;
        await programCompletionReportViewModel.getProgramCompletionReportQuestion();
        programCompletionReportViewModel.isLoading.value = false;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        NavigationHelper.onBackScreen(
          widget: const ProgramCompletionReportView(),
        );
      },
      canPop: true,
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Gap(10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: TextHeadlineMedium(
                text: StringConstants.programCompletionReport,
                color: AppColors.textPrimary,
                letterSpacing: 0,
              ),
            ),
            const Gap(10),
            Obx(
              () => programCompletionReportViewModel.isLoading.isTrue
                  ? const SizedBox()
                  : QuestionProgressWidget(
                      value: programCompletionReportViewModel.progressCounter.value,
                      max: programCompletionReportViewModel.totalCounter.value,
                    ),
            ),
            Obx(
              () => programCompletionReportViewModel.isLoading.isTrue
                  ? const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: CustomShimmer(
                        height: 200,
                        radius: AppCorner.listTile,
                      ),
                    )
                  : Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Obx(
                          () => formContent(
                            formId:
                                programCompletionReportViewModel.activeProgramCompletionReportId.value,
                          ),
                        ),
                      ),
                    ),
            ),
            const Gap(10),
          ],
        ),
      ),
    );
  }

  Widget formContent({required int formId}) {
    if (formId == 1) {
      return FeedbackFormView(
        listQuestion: programCompletionReportViewModel.listFeedbackFormQuestion,
      );
    } else if (formId == 2) {
      return GeneralQuestionView();
    } else if (formId == 3) {
      return AfterImageFormView();
    } else {
      return const SizedBox.shrink();
    }
  }
}
