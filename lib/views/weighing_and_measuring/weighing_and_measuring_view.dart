import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:revalesuva/components/custom_click.dart';
import 'package:revalesuva/components/custom_text.dart';
import 'package:revalesuva/components/custom_text_field.dart';
import 'package:revalesuva/generated/assets.dart';
import 'package:revalesuva/utils/app_colors.dart';
import 'package:revalesuva/utils/app_corner.dart';
import 'package:revalesuva/utils/helper_method.dart';
import 'package:revalesuva/utils/navigation_helper.dart';
import 'package:revalesuva/utils/strings_constant.dart';
import 'package:revalesuva/view_models/user_view_model.dart';
import 'package:revalesuva/view_models/weighing_and_measuring/weighing_and_measuring_view_model.dart';
import 'package:revalesuva/views/weighing_and_measuring/weighing_and_measuring_history_view.dart';
import 'package:revalesuva/views/weighing_and_measuring/widget/gauge_widget.dart';
import 'package:revalesuva/views/weighing_and_measuring/widget/notify_message_widget.dart';
import 'package:revalesuva/views/weighing_and_measuring/widget/previous_circumference_widget.dart';
import 'package:revalesuva/views/weighing_and_measuring/widget/previous_weight_data_widget.dart';

class WeighingAndMeasuringView extends StatefulWidget {
  const WeighingAndMeasuringView({super.key});

  @override
  State<WeighingAndMeasuringView> createState() => _WeighingAndMeasuringViewState();
}

class _WeighingAndMeasuringViewState extends State<WeighingAndMeasuringView> {
  final WeighingAndMeasuringViewModel weighingAndMeasuringViewModel =
      Get.find<WeighingAndMeasuringViewModel>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        weighingAndMeasuringViewModel.onCreate();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        NavigationHelper.onBackScreen(widget: const WeighingAndMeasuringView());
      },
      canPop: true,
      child: Scaffold(
        body: Column(
          children: [
            const Gap(20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
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
                      NavigationHelper.pushScreenWithNavBar(
                        widget: const WeighingAndMeasuringHistoryView(),
                        context: context,
                      );
                    },
                    child: TextBodySmall(
                      text: "${StringConstants.viewDataHistory} >",
                      color: AppColors.textPrimary,
                      letterSpacing: 0,
                    ),
                  ),
                ],
              ),
            ),
            const Gap(10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Align(
                alignment: AlignmentDirectional.centerStart,
                child: TextHeadlineMedium(
                  text: StringConstants.weightAndMeasurementsTracking,
                  color: AppColors.textPrimary,
                  letterSpacing: 0,
                ),
              ),
            ),
            const Gap(10),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  return weighingAndMeasuringViewModel.onCreate();
                },
                child: ListView(
                  padding: const EdgeInsets.all(20),
                  physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                  children: [
                    Obx(
                      () => weighingAndMeasuringViewModel.isLoading.value
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomShimmer(
                                  height: 5.h,
                                  width: 100.w,
                                  radius: 15,
                                ),
                                const Gap(20),
                                CustomShimmer(
                                  height: 20.h,
                                  width: 100.w,
                                  radius: 15,
                                ),
                                const Gap(20),
                                CustomShimmer(
                                  height: 15.h,
                                  width: 100.w,
                                  radius: 15,
                                ),
                                const Gap(40),
                                CustomShimmer(
                                  height: 5.h,
                                  width: 100.w,
                                  radius: 15,
                                ),
                                const Gap(30),
                                CustomShimmer(
                                  height: 15.h,
                                  width: 100.w,
                                  radius: 15,
                                ),
                              ],
                            )
                          : Column(
                              children: [
                                NotifyMessageWidget(
                                  backgroundColor: weighingAndMeasuringViewModel.weightIsError.isTrue
                                      ? AppColors.surfaceError
                                      : AppColors.surfacePurple,
                                  title: weighingAndMeasuringViewModel.weightMessageTitle.value,
                                  description:
                                      weighingAndMeasuringViewModel.weightMessageDescription.value,
                                  icons: weighingAndMeasuringViewModel.weightIsError.isTrue
                                      ? Assets.iconsIcInfoWhite
                                      : Assets.iconsIcWeighWhite,
                                ),
                                const Gap(20),
                                Obx(
                                  () => weighingAndMeasuringViewModel.canShowBMI.value &&
                                          Get.find<UserViewModel>().isWeightModule.isTrue
                                      ? const GaugeWidget()
                                      : const SizedBox(),
                                ),
                                const Gap(10),
                                PreviousWeightDataWidget(
                                  lastWeight: weighingAndMeasuringViewModel.previousWeight.value,
                                  lastBMI: weighingAndMeasuringViewModel.previousBMI.value,
                                  previousDate: weighingAndMeasuringViewModel.previousWeightDate.value,
                                ),
                                const Gap(30),
                                NotifyMessageWidget(
                                  backgroundColor: AppColors.surfacePurple,
                                  title: weighingAndMeasuringViewModel.circumferenceTitle.value,
                                  description: weighingAndMeasuringViewModel
                                      .circumferenceMessageDescription.value,
                                  icons: Assets.iconsIcWaistLineWhite,
                                ),
                                const Gap(10),
                                Obx(
                                  () => weighingAndMeasuringViewModel.canUpdateCircumference.value &&
                                          Get.find<UserViewModel>().isMeasurement.isTrue
                                      ? Row(
                                          children: [
                                            Flexible(
                                              child: CustomTextField2(
                                                hint: StringConstants.chestCircumference,
                                                inputFormatters: [
                                                  FilteringTextInputFormatter.allow(
                                                      RegExp(r'^\d+(\.\d{0,2})?$')),
                                                  LengthLimitingTextInputFormatter(3)
                                                ],
                                                textInputType: TextInputType.number,
                                                controller: weighingAndMeasuringViewModel.txtChest.value,
                                                suffixIcon: Padding(
                                                  padding: const EdgeInsetsDirectional.only(end: 10.0),
                                                  child: TextTitleMedium(text: StringConstants.cm),
                                                ),
                                              ),
                                            ),
                                            const Gap(20),
                                            Flexible(
                                              child: CustomTextField2(
                                                hint: StringConstants.abdominalCircumference,
                                                inputFormatters: [
                                                  FilteringTextInputFormatter.allow(
                                                      RegExp(r'^\d+(\.\d{0,2})?$')),
                                                  LengthLimitingTextInputFormatter(3)
                                                ],
                                                textInputType: TextInputType.number,
                                                controller: weighingAndMeasuringViewModel.txtWaist.value,
                                                suffixIcon: Padding(
                                                  padding: const EdgeInsetsDirectional.only(end: 10.0),
                                                  child: TextTitleMedium(text: StringConstants.cm),
                                                ),
                                              ),
                                            ),
                                            const Gap(20),
                                            Flexible(
                                              child: CustomTextField2(
                                                hint: StringConstants.hipCircumference,
                                                inputFormatters: [
                                                  FilteringTextInputFormatter.allow(
                                                      RegExp(r'^\d+(\.\d{0,2})?$')),
                                                  LengthLimitingTextInputFormatter(3)
                                                ],
                                                textInputType: TextInputType.number,
                                                controller: weighingAndMeasuringViewModel.txtHip.value,
                                                suffixIcon: Padding(
                                                  padding: const EdgeInsetsDirectional.only(end: 10.0),
                                                  child: TextTitleMedium(text: StringConstants.cm),
                                                ),
                                              ),
                                            )
                                          ],
                                        )
                                      : const SizedBox(),
                                ),
                                const Gap(10),
                                PreviousCircumferenceWidget(
                                  lastChest:
                                      weighingAndMeasuringViewModel.previousCircumferenceChest.value,
                                  lastAbdominal:
                                      weighingAndMeasuringViewModel.previousCircumferenceWaist.value,
                                  lastHipLine:
                                      weighingAndMeasuringViewModel.previousCircumferenceHip.value,
                                  previousDate:
                                      weighingAndMeasuringViewModel.previousCircumferenceDate.value,
                                ),
                                const Gap(10),
                                weighingAndMeasuringViewModel.canUpdateCircumference.value
                                    ? CustomClick(
                                        onTap: () {
                                          if (weighingAndMeasuringViewModel
                                              .canUpdateCircumference.value) {
                                            Get.find<WeighingAndMeasuringViewModel>()
                                                .updateCircumference();
                                          } else {
                                            weighingAndMeasuringViewModel.canUpdateCircumference.value =
                                                true;
                                          }
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 30,
                                            vertical: 5,
                                          ),
                                          margin: const EdgeInsets.symmetric(vertical: 10),
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(AppCorner.button),
                                              border:
                                                  Border.all(width: 1, color: AppColors.borderPrimary)),
                                          child: TextBodyMedium(
                                            text: Get.find<WeighingAndMeasuringViewModel>()
                                                    .canUpdateCircumference
                                                    .value
                                                ? StringConstants.confirmation
                                                : StringConstants.edit,
                                            color: AppColors.textPrimary,
                                          ),
                                        ),
                                      )
                                    : const SizedBox(),
                                const Gap(80),
                              ],
                            ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
