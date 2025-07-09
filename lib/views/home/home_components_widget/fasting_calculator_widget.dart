import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:revalesuva/components/custom_button.dart';
import 'package:revalesuva/components/custom_text.dart';
import 'package:revalesuva/utils/app_colors.dart';
import 'package:revalesuva/utils/app_corner.dart';
import 'package:revalesuva/utils/date_format_helper.dart';
import 'package:revalesuva/utils/helper_method.dart';
import 'package:revalesuva/utils/navigation_helper.dart';
import 'package:revalesuva/utils/strings_constant.dart';
import 'package:revalesuva/view_models/tools/fasting_calculator_view_model.dart';
import 'package:revalesuva/views/tools/fasting_calculator/fasting_timer_view.dart';

import '../../tools/fasting_calculator/fasting_calculator_leading_view.dart';

class FastingCalculatorWidget extends StatefulWidget {
  const FastingCalculatorWidget({super.key});

  @override
  State<FastingCalculatorWidget> createState() => _FastingCalculatorWidgetState();
}

class _FastingCalculatorWidgetState extends State<FastingCalculatorWidget> {
  final FastingCalculatorViewModel fastingCalculatorViewModel = Get.find<FastingCalculatorViewModel>();
  late Timer timer;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        await fastingCalculatorViewModel.getTodayFastingData();
        timer = Timer.periodic(const Duration(seconds: 1), (timer) async {
          fastingCalculatorViewModel.getDifferenceBetweenStartTimeAndCurrentTime();
          fastingCalculatorViewModel.timeBlinker.toggle();
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomCard2(
      color: AppColors.surfaceTertiary,
      radius: AppCorner.cardBoarder,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Obx(
            () => CircularPercentIndicator(
              radius: 65.0,
              lineWidth: 10.0,
              reverse: true,
              center: Container(
                height: double.infinity,
                width: double.infinity,
                margin: const EdgeInsets.all(20),
                decoration: const BoxDecoration(shape: BoxShape.circle, color: AppColors.surfaceGreen),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Flexible(
                          child: TextHeadlineLarge(
                            text: fastingCalculatorViewModel.fastingMinutes.value,
                            color: AppColors.textTertiary,
                            weight: 2,
                            size: 2,
                          ),
                        ),
                        const Gap(5),
                        TextHeadlineLarge(
                          text: ":",
                          color: fastingCalculatorViewModel.timeBlinker.value
                              ? Colors.transparent
                              : AppColors.textTertiary,
                          weight: 2,
                          size: 2,
                        ),
                        const Gap(5),
                        Flexible(
                          child: TextHeadlineLarge(
                            text: fastingCalculatorViewModel.fastingHours.value,
                            color: AppColors.textTertiary,
                            weight: 2,
                            size: 1,
                          ),
                        ),
                      ],
                    ),
                    const Gap(5),
                    TextTitleSmall(
                      text: StringConstants.toEndTheFast,
                      color: AppColors.textTertiary,
                      weight: 2,
                    ),
                  ],
                ),
              ),
              percent: fastingCalculatorViewModel.timerPercentage.value,
              backgroundWidth: 1,
              backgroundColor: AppColors.surfaceGreenLight,
              progressColor: AppColors.surfaceGreenLight,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextBodyMedium(
                text: "${StringConstants.startTime}: ",
                color: AppColors.textPrimary,
              ),
              TextTitleMedium(
                text: changeDateStringFormat(date: fastingCalculatorViewModel.todayStartTime.value, format: DateFormatHelper.hmFormat),
                color: AppColors.textPrimary,
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextBodyMedium(
                text: "${StringConstants.eatingWindow}: ",
                color: AppColors.textPrimary,
              ),
              TextTitleMedium(
                text: "40 ${StringConstants.days}",
                color: AppColors.textPrimary,
              )
            ],
          ),
          CustomTextButton(
            isFront: false,
            icon: Icons.arrow_forward_ios_rounded,
            text: StringConstants.forFastEditing,
            iconSize: 10,
            size: 4,
            onPressed: () async {
              final FastingCalculatorViewModel fastingCalculatorViewModel =
              Get.find<FastingCalculatorViewModel>();

              var isSuccess = await fastingCalculatorViewModel.getTodayFastingData();
              if (context.mounted) {
                if (isSuccess && fastingCalculatorViewModel.todayStartTime.isNotEmpty) {
                  NavigationHelper.pushScreenWithNavBar(
                      widget: const FastingTimerView(), context: context);
                } else {
                  NavigationHelper.pushScreenWithNavBar(
                      widget: const FastingCalculatorLeadingView(), context: context);
                }
              }
            },
          )
        ],
      ),
    );
  }
}
