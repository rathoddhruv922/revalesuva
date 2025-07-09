import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:revalesuva/components/custom_button.dart';
import 'package:revalesuva/components/custom_click.dart';
import 'package:revalesuva/components/custom_text.dart';
import 'package:revalesuva/utils/app_colors.dart';
import 'package:revalesuva/utils/app_corner.dart';
import 'package:revalesuva/utils/helper_method.dart';
import 'package:revalesuva/utils/navigation_helper.dart';
import 'package:revalesuva/utils/strings_constant.dart';
import 'package:revalesuva/view_models/my_plan/summary_of_journey_view_model.dart';
import 'package:revalesuva/views/my_plan/program_summary_report/feedback_summary_view.dart';
import 'package:revalesuva/views/my_plan/program_summary_report/general_summary_view.dart';

class SummaryOfJourneyView extends StatefulWidget {
  const SummaryOfJourneyView({super.key});

  @override
  State<SummaryOfJourneyView> createState() => _SummaryOfJourneyViewState();
}

class _SummaryOfJourneyViewState extends State<SummaryOfJourneyView> {
  final SummaryOfJourneyViewModel summaryOfJourneyViewModel = Get.put(
    SummaryOfJourneyViewModel(),
    permanent: true,
  );

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        summaryOfJourneyViewModel.isLoading.value = true;
        await summaryOfJourneyViewModel.getUserProgramSummaryReport();
        summaryOfJourneyViewModel.isLoading.value = false;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        NavigationHelper.onBackScreen(
          widget: const SummaryOfJourneyView(),
        );
      },
      canPop: true,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomClick(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: TextBodySmall(
                  text: "< ${StringConstants.backTo} ${StringConstants.personalArea}",
                  color: AppColors.textPrimary,
                  letterSpacing: 0,
                ),
              ),
              const Gap(10),
              TextHeadlineMedium(
                text: StringConstants.moveYourHeartOnTheScaleAccordingToYourFeelings,
                color: AppColors.textPrimary,
                textAlign: TextAlign.start,
              ),
              const Gap(10),
              Expanded(
                child: Obx(
                  () => ListView(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                    shrinkWrap: true,
                    children: [
                      formContent(formId: summaryOfJourneyViewModel.formId.value)
                    ],
                  ),
                ),
              ),
              const Gap(10),
              Obx(
                () => Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: summaryOfJourneyViewModel.formId.value == 2
                          ? TextBodyMedium(
                              textAlign: TextAlign.start,
                              text: StringConstants.previousPage,
                              color: AppColors.textPrimary,
                            )
                          : const SizedBox(),
                    ),
                    const Gap(10),
                    CustomIconButton(
                      text: "",
                      width: 40,
                      onPressed: () {
                        summaryOfJourneyViewModel.onPreviousPage();
                      },
                      icon: Icons.arrow_back_ios_new_rounded,
                      iconSize: 18,
                      backgroundColor: summaryOfJourneyViewModel.formId.value == 2
                          ? AppColors.surfaceBrand
                          : AppColors.surfaceTertiary,
                    ),
                    const Gap(20),
                    TextTitleLarge(
                      text: summaryOfJourneyViewModel.formId.value.toString(),
                    ),
                    const Gap(20),
                    CustomIconButton(
                      text: "",
                      width: 40,
                      onPressed: () {
                        summaryOfJourneyViewModel.onNextPage();
                      },
                      icon: Icons.arrow_forward_ios_rounded,
                      iconSize: 18,
                      backgroundColor: summaryOfJourneyViewModel.formId.value == 1
                          ? AppColors.surfaceBrand
                          : AppColors.surfaceTertiary,
                    ),
                    const Gap(10),
                    Expanded(
                      child: summaryOfJourneyViewModel.formId.value == 1
                          ? TextBodyMedium(
                              textAlign: TextAlign.start,
                              text: StringConstants.nextPage,
                              color: AppColors.textPrimary,
                            )
                          : const SizedBox(),
                    ),
                  ],
                ),
              ),
              const Gap(70)
            ],
          ),
        ),
      ),
    );
  }

  Widget formContent({required int formId}) {
    if (formId == 1) {
      return FeedbackSummaryView();
    } else if (formId == 2) {
      return GeneralSummaryView();
    } else {
      return const SizedBox.shrink();
    }
  }
}
