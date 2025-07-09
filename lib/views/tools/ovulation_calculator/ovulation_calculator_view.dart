import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:revalesuva/components/custom_click.dart';
import 'package:revalesuva/components/custom_text.dart';
import 'package:revalesuva/utils/app_colors.dart';
import 'package:revalesuva/utils/app_corner.dart';
import 'package:revalesuva/utils/helper_method.dart';
import 'package:revalesuva/utils/localization.dart';
import 'package:revalesuva/utils/navigation_helper.dart';
import 'package:revalesuva/utils/strings_constant.dart';
import 'package:revalesuva/view_models/tools/ovulation_calculator_view_model.dart';
import 'package:revalesuva/views/tools/ovulation_calculator/widget/hebrew_style_calendar.dart';
import 'package:revalesuva/views/tools/ovulation_calculator/widget/ovulation_edit_data_widget.dart';
import 'package:revalesuva/views/tools/ovulation_calculator/widget/ovulation_type_widget.dart';

class OvulationCalculatorView extends StatefulWidget {
  const OvulationCalculatorView({super.key});

  @override
  State<OvulationCalculatorView> createState() => _OvulationCalculatorViewState();
}

class _OvulationCalculatorViewState extends State<OvulationCalculatorView> {
  final OvulationCalculatorViewModel ovulationCalculatorViewModel =
      Get.put(OvulationCalculatorViewModel(), permanent: true);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        ovulationCalculatorViewModel.isLoader.value = true;
        await ovulationCalculatorViewModel.onCreate();
        ovulationCalculatorViewModel.isLoader.value = false;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        NavigationHelper.onBackScreen(widget: const OvulationCalculatorView());
      },
      canPop: true,
      child: Scaffold(
        body: Obx(
          () => ovulationCalculatorViewModel.isLoader.isTrue
              ? ListView(
                  padding: const EdgeInsets.all(20),
                  children: const [
                    CustomShimmer(
                      height: 250,
                      radius: AppCorner.listTile,
                    ),
                    Gap(30),
                    CustomShimmer(
                      height: 250,
                      radius: AppCorner.listTile,
                    )
                  ],
                )
              : ListView(
                  padding: const EdgeInsets.all(20),
                  physics: const BouncingScrollPhysics(),
                  children: [
                    const Gap(10),
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
                    const Gap(10),
                    TextHeadlineMedium(
                      text: StringConstants.ovulationCalculator,
                      color: AppColors.textPrimary,
                      letterSpacing: 0,
                    ),
                    const Gap(10),
                    OvulationEditDataWidget(),
                    Obx(
                      () => ovulationCalculatorViewModel.userData.value.regularPeriod ==
                              "regular_period"
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Gap(20),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Flexible(
                                      child: OvulationTypeWidget(
                                        color: AppColors.surfaceBrand,
                                        isSelected: false,
                                        title: StringConstants.menstruation,
                                      ),
                                    ),
                                    const Gap(20),
                                    Flexible(
                                      child: OvulationTypeWidget(
                                        color: AppColors.surfaceGreen,
                                        isSelected: false,
                                        title: StringConstants.ovulation,
                                      ),
                                    ),
                                    const Gap(20),
                                    Flexible(
                                      child: OvulationTypeWidget(
                                        color: AppColors.surfaceYellow,
                                        isSelected: false,
                                        title: StringConstants.hormonalDays,
                                      ),
                                    ),
                                  ],
                                ),
                                const Gap(20),
                                HebrewStyleCalendar(),
                              ],
                            )
                          : const SizedBox(),
                    ),
                    const Gap(80)
                  ],
                ),
        ),
      ),
    );
  }
}

String getHebrewDate(DateTime date) {
  // Implement your Hebrew date conversion logic here
  // This is a placeholder - you'll need to add actual Hebrew date conversion
  return 'כ״ז'; // Example Hebrew date
}
