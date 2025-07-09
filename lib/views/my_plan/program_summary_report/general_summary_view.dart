import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:revalesuva/utils/app_colors.dart';
import 'package:revalesuva/utils/helper_method.dart';
import 'package:revalesuva/view_models/my_plan/summary_of_journey_view_model.dart';
import 'package:revalesuva/views/my_plan/program_summary_report/widget/summary_general_item_widget.dart';

class GeneralSummaryView extends StatelessWidget {
  GeneralSummaryView({super.key});

  final SummaryOfJourneyViewModel summaryOfJourneyViewModel = Get.find<SummaryOfJourneyViewModel>();

  @override
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => CustomCard2(
        color: AppColors.surfaceTertiary,
        child: ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 10),
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return SummaryGeneralItemWidget(
              data: summaryOfJourneyViewModel.listGeneralQuestion[index],
              isShowDivider: summaryOfJourneyViewModel.listGeneralQuestion.length - 1 == index,
            );
          },
          itemCount: summaryOfJourneyViewModel.listGeneralQuestion.length,
        ),
      ),
    );
  }
}
