import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:revalesuva/components/custom_button.dart';
import 'package:revalesuva/components/custom_click.dart';
import 'package:revalesuva/components/custom_dropdown.dart';
import 'package:revalesuva/components/custom_text.dart';
import 'package:revalesuva/utils/app_colors.dart';
import 'package:revalesuva/utils/date_format_helper.dart';
import 'package:revalesuva/utils/helper_method.dart';
import 'package:revalesuva/utils/navigation_helper.dart';
import 'package:revalesuva/utils/strings_constant.dart';
import 'package:revalesuva/view_models/tools/fasting_calculator_view_model.dart';
import 'package:revalesuva/views/tools/fasting_calculator/fasting_history_view.dart';
import 'package:revalesuva/views/tools/fasting_calculator/widget/show_value_widget.dart';
import 'package:revalesuva/views/tools/fasting_calculator/widget/start_time_edit_widget.dart';

late Timer timer;
class FastingTimerView extends StatefulWidget {
  const FastingTimerView({super.key});

  @override
  State<FastingTimerView> createState() => _FastingTimerViewState();
}

class _FastingTimerViewState extends State<FastingTimerView> {
  final FastingCalculatorViewModel fastingCalculatorViewModel = Get.find<FastingCalculatorViewModel>();



  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        if(timer.isActive){
          timer.cancel();
        }else{
          await fastingCalculatorViewModel.getTodayFastingData();
          timer = Timer.periodic(const Duration(seconds: 1), (timer) async {
            fastingCalculatorViewModel.getDifferenceBetweenStartTimeAndCurrentTime();
            fastingCalculatorViewModel.timeBlinker.toggle();
          });
        }

      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        NavigationHelper.onBackScreen(widget: const FastingTimerView());
      },
      canPop: true,
      child: Scaffold(
        body: RefreshIndicator(
          child: ListView(
            padding: const EdgeInsets.all(20),
            physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
            children: [
              const Gap(10),
              Row(
                children: [
                  CustomClick(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: TextBodySmall(
                      text: "< ${StringConstants.backTo}",
                      color: AppColors.textPrimary,
                      letterSpacing: 0,
                    ),
                  ),
                  const Spacer(),
                  CustomClick(
                    onTap: () {
                      NavigationHelper.pushScreenWithNavBar(widget: const FastingHistoryView(), context: context);

                    },
                    child: TextBodySmall(
                      text: "${StringConstants.viewDataHistory} >",
                      color: AppColors.textPrimary,
                      letterSpacing: 0,
                    ),
                  ),
                ],
              ),
              const Gap(10),
              TextHeadlineMedium(
                text: StringConstants.fastingCalculator,
                color: AppColors.textPrimary,
                letterSpacing: 0,
              ),
              const Gap(20),
              CustomCard2(
                color: AppColors.surfaceTertiary,
                child: Column(
                  children: [
                    Obx(
                      () => RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: StringConstants.theTargetIs,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            TextSpan(
                              text: "${fastingCalculatorViewModel.currentSlot.value.noOfFastingHours ?? ""}",
                              style: Theme.of(context).textTheme.headlineLarge,
                            ),
                            TextSpan(
                              text: StringConstants.hoursReady,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Gap(20),
                    Obx(
                      () => CircularPercentIndicator(
                        radius: 100.0,
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
                                      size: 10,
                                    ),
                                  ),
                                  const Gap(5),
                                  TextHeadlineLarge(
                                    text: ":",
                                    color: fastingCalculatorViewModel.timeBlinker.value
                                        ? Colors.transparent
                                        : AppColors.textTertiary,
                                    weight: 2,
                                    size: 10,
                                  ),
                                  const Gap(5),
                                  Flexible(
                                    child: TextHeadlineLarge(
                                      text: fastingCalculatorViewModel.fastingHours.value,
                                      color: AppColors.textTertiary,
                                      weight: 2,
                                      size: 10,
                                    ),
                                  ),
                                ],
                              ),
                              const Gap(5),
                              TextHeadlineMedium(
                                text: StringConstants.toEndTheFast,
                                color: AppColors.textTertiary,
                                weight: 2,
                              ),
                              const Gap(5),
                              CustomTextButton(
                                text: StringConstants.pressToStop,
                                underline: true,
                                textColor: AppColors.textTertiary,
                                onPressed: () async {
                                  await fastingCalculatorViewModel.stopFasting();
                                  if (context.mounted) {
                                    Navigator.pop(context);
                                  }
                                },
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
                    const Gap(20),
                    CustomButton(
                      text: StringConstants.editFastingTimer,
                      backgroundColor: AppColors.surfaceTertiary,
                      borderColor: AppColors.borderPrimary,
                      onPressed: () {


                        var txStartTimeHour = TextEditingController();
                        var txStartTimeMin = TextEditingController();

                        Get.bottomSheet(
                          isScrollControlled: true,
                          ignoreSafeArea: false,
                          backgroundColor: AppColors.surfaceTertiary,
                          enableDrag: true,
                          ListView(
                            padding: const EdgeInsets.all(30),
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            children: [
                              TextHeadlineMedium(
                                text: StringConstants.fastClockUpdate,
                              ),
                              const Gap(30),
                              ShowValueWidget(
                                fieldName: StringConstants.date,
                                value: changeDateStringFormat(
                                  date: DateTime.now().toString(),
                                  format: DateFormatHelper.ymdFormat,
                                ),
                              ),
                              const Gap(20),
                              StartTimeEditWidget(
                                fieldName: StringConstants.startTime,
                                txHours: txStartTimeHour,
                                txMinutes: txStartTimeMin,
                              ),
                              const Gap(20),
                              Obx(
                                () => SimpleDropdownButton(
                                  hint: StringConstants.numberOfTargetHours,
                                  value: fastingCalculatorViewModel.targetHoursDisplay.value.isNotEmpty
                                      ? fastingCalculatorViewModel.targetHoursDisplay.value
                                      : null,
                                  dropdownItems: List.generate(
                                    23,
                                    (index) => StringConstants.hoursOfFasting.replaceAll("{}", "${index + 1}"),
                                  ),
                                  onChanged: (value) {
                                    fastingCalculatorViewModel.targetHoursDisplay.value = value ?? "";
                                    fastingCalculatorViewModel.targetHours.value = getNumberFromString(text: value ?? "");
                                  },
                                ),
                              ),
                              const Gap(20),
                              Row(
                                children: [
                                  SimpleButton(
                                    backgroundColor: AppColors.surfaceTertiary,
                                    text: StringConstants.cancel,
                                    onPressed: () {},
                                  ),
                                  const Spacer(),
                                  SimpleButton(
                                    text: StringConstants.update,
                                    onPressed: () {
                                      if (Get.isBottomSheetOpen ?? false) {
                                        Get.back();
                                      }
                                      var hours = txStartTimeHour.text.isEmpty ? 00 : txStartTimeHour.text;
                                      var minutes = txStartTimeMin.text.isEmpty ? 00 : txStartTimeMin.text;
                                      fastingCalculatorViewModel.updateFasting(
                                        startTime: "$hours:$minutes",
                                        date: changeDateStringFormat(
                                          date: "${fastingCalculatorViewModel.currentSlot.value.date ?? ""}",
                                          format: DateFormatHelper.ymdFormat,
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                              const Gap(30),
                            ],
                          ),
                        );
                      },
                    ),
                    const Gap(20),
                  ],
                ),
              ),
              const Gap(80),
            ],
          ),
          onRefresh: () async {
            await fastingCalculatorViewModel.getTodayFastingData();
          },
        ),
      ),
    );
  }
}
