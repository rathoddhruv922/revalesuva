import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:revalesuva/components/custom_button.dart';
import 'package:revalesuva/components/custom_click.dart';
import 'package:revalesuva/components/custom_dropdown.dart';
import 'package:revalesuva/components/custom_text.dart';
import 'package:revalesuva/components/custom_text_field.dart';
import 'package:revalesuva/services/api_constant.dart';
import 'package:revalesuva/utils/app_colors.dart';
import 'package:revalesuva/utils/app_validator.dart';
import 'package:revalesuva/utils/date_format_helper.dart';
import 'package:revalesuva/utils/helper_method.dart';
import 'package:revalesuva/utils/navigation_helper.dart';
import 'package:revalesuva/utils/strings_constant.dart';
import 'package:revalesuva/view_models/tools/fasting_calculator_view_model.dart';
import 'package:revalesuva/views/tools/fasting_calculator/fasting_history_view.dart';
import 'package:revalesuva/views/tools/fasting_calculator/fasting_timer_view.dart';

class FastingCalculatorLeadingView extends StatefulWidget {
  const FastingCalculatorLeadingView({super.key});

  @override
  State<FastingCalculatorLeadingView> createState() => _FastingCalculatorLeadingViewState();
}

class _FastingCalculatorLeadingViewState extends State<FastingCalculatorLeadingView> {
  final FastingCalculatorViewModel fastingCalculatorViewModel = Get.put(FastingCalculatorViewModel());

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        NavigationHelper.onBackScreen(widget: const FastingCalculatorLeadingView());
      },
      canPop: true,
      child: Scaffold(
        body: ListView(
          padding: const EdgeInsets.all(20),
          physics: const BouncingScrollPhysics(),
          children: [
            const Gap(10),
            Row(
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
                CustomTextButton(
                  onPressed: () {
                    startEarlier(context);
                  },
                  text: StringConstants.iStartedFastingEarlier,
                  underline: true,
                ),
                const Spacer(),
                SimpleButton(
                  text: StringConstants.startFastingTimer,
                  onPressed: () async {
                    var param = {
                      APIConstant.instance.kDate: changeDateStringFormat(
                          date: DateTime.now().toString(), format: DateFormatHelper.ymdFormat),
                      APIConstant.instance.kStartTime: changeDateStringFormat(
                          date: DateTime.now().toString(), format: DateFormatHelper.hmFormat),
                      APIConstant.instance.kNoOfFastingHours:
                          int.tryParse(fastingCalculatorViewModel.targetHours.value) ?? 0,
                    };
                    bool isSuccess = await fastingCalculatorViewModel.startFasting(param: param);
                    if (isSuccess && context.mounted) {
                      Navigator.of(context).pop();
                      NavigationHelper.pushScreenWithNavBar(
                        widget: const FastingTimerView(),
                        context: context,
                      );

                    }
                  },
                ),
              ],
            ),
            const Gap(80),
          ],
        ),
      ),
    );
  }

  startEarlier(BuildContext context) {
    var txStartTimeHour = TextEditingController();
    var txStartTimeMin = TextEditingController();
    final formKey = GlobalKey<FormState>();
    Get.dialog(
      PopScope(
        onPopInvokedWithResult: (didPop, result) {
          fastingCalculatorViewModel.targetHoursDisplay.value = "";
          fastingCalculatorViewModel.targetHours.value = "";
        },
        child: Dialog(
          backgroundColor: AppColors.surfaceTertiary,
          child: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextHeadlineMedium(
                    text: StringConstants.updateFastingStartTime,
                  ),
                  const Gap(30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: CustomTextField2(
                          hint: StringConstants.minutes,
                          controller: txStartTimeMin,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp(r'^\d+(\.\d{0,2})?$'))
                          ],
                          textInputType: TextInputType.number,
                          validator: (value) =>
                              FormValidate.requiredField(value, StringConstants.minutes),
                        ),
                      ),
                      const Gap(10),
                      const TextHeadlineLarge(
                        text: " : ",
                        size: 5,
                      ),
                      const Gap(10),
                      Expanded(
                        child: CustomTextField2(
                          hint: StringConstants.hour,
                          controller: txStartTimeHour,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp(r'^\d+(\.\d{0,2})?$'))
                          ],
                          validator: (value) => FormValidate.requiredField(value, StringConstants.hour),
                          textInputType: TextInputType.number,
                        ),
                      ),
                    ],
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
                        fastingCalculatorViewModel.targetHours.value =
                            getNumberFromString(text: value ?? "");
                      },
                    ),
                  ),
                  const Gap(30),
                  Row(
                    children: [
                      SimpleButton(
                        backgroundColor: AppColors.surfaceTertiary,
                        text: StringConstants.cancel,
                        onPressed: () {
                          if (Get.isDialogOpen ?? false) {
                            Get.back();
                          }
                        },
                      ),
                      const Spacer(),
                      SimpleButton(
                        text: StringConstants.startFastingTimer,
                        onPressed: () async {
                          if (formKey.currentState?.validate() ?? false) {
                            if (Get.isDialogOpen ?? false) {
                              Get.back();
                            }
                            var param = {
                              APIConstant.instance.kDate: changeDateStringFormat(
                                  date: DateTime.now().toString(), format: DateFormatHelper.ymdFormat),
                              APIConstant.instance.kStartTime: changeDateStringFormat(
                                  date: DateTime.now().toString(), format: DateFormatHelper.hmFormat),
                              APIConstant.instance.kNoOfFastingHours:
                                  int.tryParse(fastingCalculatorViewModel.targetHours.value) ?? 0,
                            };
                            bool isSuccess = await fastingCalculatorViewModel.startFasting(param: param);
                            if (isSuccess && context.mounted) {
                              Navigator.of(context).pop();
                              NavigationHelper.pushScreenWithNavBar(
                                widget: const FastingTimerView(),
                                context: context,
                              );
                            }
                          }
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
