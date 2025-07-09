import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:revalesuva/components/custom_bottom_sheet.dart';
import 'package:revalesuva/components/custom_button.dart';
import 'package:revalesuva/components/custom_click.dart';
import 'package:revalesuva/components/custom_text.dart';
import 'package:revalesuva/generated/assets.dart';
import 'package:revalesuva/utils/app_colors.dart';
import 'package:revalesuva/utils/app_corner.dart';
import 'package:revalesuva/utils/date_format_helper.dart';
import 'package:revalesuva/utils/default_list.dart';
import 'package:revalesuva/utils/helper_method.dart';
import 'package:revalesuva/utils/localization.dart';
import 'package:revalesuva/utils/strings_constant.dart';
import 'package:revalesuva/view_models/tools/ovulation_calculator_view_model.dart';
import 'package:revalesuva/views/personal_profile/widget/info_display_edit_dropdown_widget.dart';
import 'package:revalesuva/views/personal_profile/widget/info_display_edit_widget.dart';

class OvulationEditDataWidget extends StatelessWidget {
  OvulationEditDataWidget({super.key});

  final OvulationCalculatorViewModel ovulationCalculatorViewModel =
      Get.find<OvulationCalculatorViewModel>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Obx(
          () => InfoDisplayEditDropdownWidget(
            title: StringConstants.menstruationStatus,
            dropdownItems: DefaultList.periodList,
            value: ovulationCalculatorViewModel.menstruationStatus.value.isNotEmpty
                ? ovulationCalculatorViewModel.menstruationStatus.value
                : null,
            onChanged: (value) {
              if (value != null) {
                ovulationCalculatorViewModel.menstruationStatus.value = value;
                if (ovulationCalculatorViewModel.menstruationStatus.value ==
                    StringConstants.regularPeriod) {
                  ovulationCalculatorViewModel.showMoreDetail.value = true;
                } else {
                  ovulationCalculatorViewModel.showMoreDetail.value = false;
                }
              }
            },
          ),
        ),
        Obx(
          () => ovulationCalculatorViewModel.showMoreDetail.value
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Gap(10),
                    Obx(
                      () => CustomClick(
                        onTap: () {
                          if (ovulationCalculatorViewModel.isAvailable.isTrue) {
                            Get.bottomSheet(
                              isScrollControlled: false,
                              ignoreSafeArea: false,
                              CustomBottomSheet(
                                bottomSheetTitle: StringConstants.lastMenstruationDate,
                                onDone: () {
                                  if (ovulationCalculatorViewModel
                                      .txtDateOfLastPeriod.value.text.isEmpty) {
                                    ovulationCalculatorViewModel.txtDateOfLastPeriod.value.text =
                                        changeDateStringFormat(
                                      date: DateTime(DateTime.now().year - 5).toString(),
                                      format: DateFormatHelper.ymdFormat,
                                    );
                                  }
                                  if (Get.isBottomSheetOpen ?? false) {
                                    Get.back();
                                  }
                                },
                                widget: SizedBox(
                                  height: 30.h,
                                  child: CupertinoTheme(
                                    data: const CupertinoThemeData(brightness: Brightness.light),
                                    child: CupertinoDatePicker(
                                      dateOrder: DatePickerDateOrder.ymd,
                                      itemExtent: 40,
                                      mode: CupertinoDatePickerMode.date,
                                      initialDateTime: DateTime.tryParse(ovulationCalculatorViewModel
                                              .txtDateOfLastPeriod.value.text) ??
                                          DateTime.now(),
                                      minimumDate:
                                          DateTime(DateTime.now().year, DateTime.now().month - 1),
                                      maximumDate: DateTime(DateTime.now().year + 1),
                                      showDayOfWeek: true,
                                      onDateTimeChanged: (DateTime newDate) {
                                        ovulationCalculatorViewModel.txtDateOfLastPeriod.value.text =
                                            changeDateStringFormat(
                                                date: newDate.toString(),
                                                format: DateFormatHelper.ymdFormat);
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            );
                          } else {
                            showToast(
                                msg: "You can't select date, wait for finish your ovulation dates");
                          }
                        },
                        child: InfoDisplayEditWidget(
                          title: StringConstants.lastMenstruationDate,
                          enabled: false,
                          controller: ovulationCalculatorViewModel.txtDateOfLastPeriod.value,
                          suffixIcon: const Align(
                            child: ImageIcon(
                              AssetImage(
                                Assets.iconsIcCalendar,
                              ),
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const Gap(10),
                    Row(
                      children: [
                        Expanded(
                          child: Obx(
                            () => ovulationCalculatorViewModel.isAvailable.isTrue
                                ? InfoDisplayEditDropdownWidget(
                                    title: StringConstants.numberOfCycleDays,
                                    dropdownItems: List.generate(11, (index) => "${index + 20}"),
                                    value:
                                        ovulationCalculatorViewModel.numberOfCycleDays.value.isNotEmpty
                                            ? ovulationCalculatorViewModel.numberOfCycleDays.value
                                            : null,
                                    onChanged: (value) {
                                      if (value != null) {
                                        ovulationCalculatorViewModel.numberOfCycleDays.value = value;
                                      }
                                    },
                                  )
                                : Stack(
                                    children: [
                                      InfoDisplayEditDropdownWidget(
                                        title: StringConstants.numberOfCycleDays,
                                        dropdownItems: List.generate(11, (index) => "${index + 20}"),
                                        value: ovulationCalculatorViewModel
                                                .numberOfCycleDays.value.isNotEmpty
                                            ? ovulationCalculatorViewModel.numberOfCycleDays.value
                                            : null,
                                        onChanged: (value) {
                                          if (value != null) {
                                            ovulationCalculatorViewModel.numberOfCycleDays.value = value;
                                          }
                                        },
                                      ),
                                      CustomClick(
                                        onTap: () {
                                          showToast(
                                            msg: "You can't days, wait for finish your ovulation cycle",
                                          );
                                        },
                                        child: SizedBox(
                                          width: 100.w,
                                          height: 42,
                                        ),
                                      ),
                                    ],
                                  ),
                          ),
                        ),
                        const Gap(10),
                        CustomClick(
                          onTap: () {
                            Get.dialog(
                              Dialog(
                                backgroundColor: AppColors.surfaceTertiary,
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      color: AppColors.surfaceTertiary,
                                      borderRadius: BorderRadius.circular(AppCorner.listTile)),
                                  child: TextBodyMedium(
                                    text: StringConstants
                                        .cycleLengthNumberOfDaysBetweenPeriodsUsuallyBetween26_50Days,
                                    color: AppColors.textPrimary,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            );
                          },
                          child: const Icon(
                            Icons.info_outline,
                            color: AppColors.iconSecondary,
                          ),
                        ),
                      ],
                    ),
                  ],
                )
              : const SizedBox(),
        ),
        const Gap(20),
        SimpleButton(
          width: 100.w,
          text: StringConstants.saveData,
          onPressed: () {
            // if (ovulationCalculatorViewModel.menstruationStatus.value
            //         .translateValue("en_US")
            //         .toLowerCase()
            //         .replaceAll(" ", "_") !=
            //     ovulationCalculatorViewModel.userData.value.regularPeriod) {
            //   ovulationCalculatorViewModel.onSubmitSelectedDate();
            // } else {
            //   showToast(msg: "You can't submit same data again");
            // }
            if (ovulationCalculatorViewModel.isAvailable.isFalse &&
                ovulationCalculatorViewModel.menstruationStatus.value
                        .translateValue("en_US")
                        .toLowerCase()
                        .replaceAll(" ", "_") ==
                    ovulationCalculatorViewModel.userData.value.regularPeriod) {
              showToast(msg: "You can't submit data again, wait for finish your ovulation dates");
            } else {
              ovulationCalculatorViewModel.onSubmitSelectedDate();
            }
          },
        ),
      ],
    );
  }
}
