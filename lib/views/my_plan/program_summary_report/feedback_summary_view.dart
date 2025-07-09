import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:revalesuva/utils/app_colors.dart';
import 'package:revalesuva/utils/app_corner.dart';
import 'package:revalesuva/utils/helper_method.dart';
import 'package:revalesuva/view_models/my_plan/summary_of_journey_view_model.dart';
import 'package:revalesuva/views/my_plan/program_summary_report/widget/summary_feedback_item_widget.dart';

class FeedbackSummaryView extends StatelessWidget {
  FeedbackSummaryView({super.key});

  final SummaryOfJourneyViewModel summaryOfJourneyViewModel = Get.find<SummaryOfJourneyViewModel>();

  @override
  Widget build(BuildContext context) {
    return Obx(
          () => summaryOfJourneyViewModel.isLoading.isTrue
          ? const CustomShimmer(
        height: 100,
        radius: AppCorner.listTile,
      )
          : summaryOfJourneyViewModel.listFeedbackQuestion.isEmpty
          ? noDataFoundWidget()
          : CustomCard2(
        color: AppColors.surfaceTertiary,
        child: ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return SummaryFeedbackItemWidget(
              value: double.tryParse(
                  summaryOfJourneyViewModel.listFeedbackQuestion[index].answer ?? "5"),
              question1: summaryOfJourneyViewModel
                  .listFeedbackQuestion[index].planSummaryReport?.question1 ??
                  "",
              question2: summaryOfJourneyViewModel
                  .listFeedbackQuestion[index].planSummaryReport?.question2 ??
                  "",
              onChanged: (value) {},
              enable: false,
            );
          },
          separatorBuilder: (context, index) => Divider(
            color: AppColors.borderGreen.withValues(
              alpha: 0.2,
            ),
          ),
          itemCount: summaryOfJourneyViewModel.listFeedbackQuestion.length,
        ),
      ),
    );
  }
}
