import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:revalesuva/components/custom_button.dart';
import 'package:revalesuva/components/custom_click.dart';
import 'package:revalesuva/components/custom_text.dart';
import 'package:revalesuva/model/tools/fasting_calculator/fasting_calculator_list_model.dart'
    as fasting_calculator_list_model;
import 'package:revalesuva/utils/app_colors.dart';
import 'package:revalesuva/utils/date_format_helper.dart';
import 'package:revalesuva/utils/helper_method.dart';
import 'package:revalesuva/utils/navigation_helper.dart';
import 'package:revalesuva/utils/strings_constant.dart';
import 'package:revalesuva/view_models/tools/fasting_calculator_view_model.dart';
import 'package:revalesuva/views/tools/fasting_calculator/fasting_calculator_leading_view.dart';
import 'package:revalesuva/views/tools/fasting_calculator/widget/fasting_history_item_widget.dart';
import 'package:revalesuva/views/tools/fasting_calculator/widget/history_table_title_widget.dart';
import 'package:revalesuva/views/tools/fasting_calculator/widget/show_value_widget.dart';
import 'package:revalesuva/views/tools/fasting_calculator/widget/start_time_edit_widget.dart';

class FastingHistoryView extends StatefulWidget {
  const FastingHistoryView({super.key});

  @override
  State<FastingHistoryView> createState() => _FastingHistoryViewState();
}

class _FastingHistoryViewState extends State<FastingHistoryView> {
  final FastingCalculatorViewModel fastingCalculatorViewModel = Get.find<FastingCalculatorViewModel>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        fastingCalculatorViewModel.currentPage.value = 1;
        fastingCalculatorViewModel.total.value = 1;
        await fastingCalculatorViewModel.getHistoryFastingData();
        fastingCalculatorViewModel.setupScrollController();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        NavigationHelper.onBackScreen(widget: const FastingHistoryView());
      },
      canPop: true,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
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
                ],
              ),
              const Gap(10),
              SizedBox(
                height: 40,
                child: Row(
                  children: [
                    Expanded(
                      child: TextHeadlineMedium(
                        text: StringConstants.fastingHistory,
                        color: AppColors.textPrimary,
                        letterSpacing: 0,
                      ),
                    ),
                    SimpleButton(
                      text: StringConstants.addNewFast,
                      onPressed: () {
                        NavigationHelper.pushScreenWithNavBar(
                          widget: const FastingCalculatorLeadingView(),
                          context: context,
                        );
                      },
                    ),
                  ],
                ),
              ),
              const Gap(20),
              Expanded(
                child: Obx(
                  () => fastingCalculatorViewModel.isLoading.isTrue
                      ? const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: CupertinoActivityIndicator(
                            radius: 15,
                          ),
                        )
                      : fastingCalculatorViewModel.listHistory.isEmpty
                          ? RefreshIndicator(
                              onRefresh: () {
                                fastingCalculatorViewModel.currentPage.value = 1;

                                return fastingCalculatorViewModel.getHistoryFastingData();
                              },
                              child: SingleChildScrollView(
                                physics: const AlwaysScrollableScrollPhysics(),
                                child: Container(
                                  alignment: Alignment.center,
                                  height: 50.h,
                                  child: TextHeadlineMedium(
                                    text: StringConstants.noDataFound,
                                  ),
                                ),
                              ),
                            )
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const HistoryTableTitleWidget(),
                                Expanded(
                                  child: RefreshIndicator(
                                    child: ListView.builder(
                                      controller: fastingCalculatorViewModel.scrollController,
                                      itemBuilder: (context, index) {
                                        return FastingHistoryItemWidget(
                                          data: fastingCalculatorViewModel.listHistory[index],
                                          index: index,
                                          onEdit: () {
                                            onUpdateDuration(
                                              data: fastingCalculatorViewModel.listHistory[index],
                                            );
                                          },
                                        );
                                      },
                                      itemCount: fastingCalculatorViewModel.listHistory.length,
                                      shrinkWrap: true,
                                      physics: const AlwaysScrollableScrollPhysics(),
                                    ),
                                    onRefresh: () async {
                                      fastingCalculatorViewModel.currentPage.value = 1;
                                      return fastingCalculatorViewModel.getHistoryFastingData();
                                    },
                                  ),
                                ),
                              ],
                            ),
                ),
              ),
              const Gap(80),
            ],
          ),
        ),
      ),
    );
  }

  onUpdateDuration({required fasting_calculator_list_model.Datum data}) {
    var txStartTimeHour = TextEditingController();
    var txStartTimeMin = TextEditingController();
    var formKey = GlobalKey<FormState>();
    Get.bottomSheet(
      isScrollControlled: true,
      ignoreSafeArea: false,
      backgroundColor: AppColors.surfaceTertiary,
      enableDrag: true,
      Form(
        key: formKey,
        child: ListView(
          padding: const EdgeInsets.all(30),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            TextHeadlineMedium(
              text: StringConstants.fastEditing,
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
              fieldName: StringConstants.duration,
              txHours: txStartTimeHour,
              txMinutes: txStartTimeMin,
            ),
            const Gap(20),
            Row(
              children: [
                SimpleButton(
                  backgroundColor: AppColors.surfaceTertiary,
                  text: StringConstants.cancel,
                  onPressed: () {
                    if (Get.isBottomSheetOpen ?? false) {
                      Get.back();
                    }
                  },
                ),
                const Spacer(),
                SimpleButton(
                  text: StringConstants.update,
                  onPressed: () {
                    if (formKey.currentState?.validate() ?? false) {
                      if (Get.isBottomSheetOpen ?? false) {
                        Get.back();
                      }
                      var hours = txStartTimeHour.text.isEmpty ? "00" : txStartTimeHour.text;
                      var minutes = txStartTimeMin.text.isEmpty ? "00" : txStartTimeMin.text;

                      if (hours != "00" || minutes != "00") {
                        fastingCalculatorViewModel.updateDuration(
                          fastingId: data.id ?? -1,
                          hours: int.tryParse(hours) ?? 0,
                          min: int.tryParse(minutes) ?? 0,
                          startTime: data.startTime ?? "",
                          date: changeDateStringFormat(
                            date: data.date.toString(),
                            format: DateFormatHelper.ymdFormat,
                          ),
                        );
                      }
                    }
                  },
                ),
              ],
            ),
            const Gap(30),
          ],
        ),
      ),
    );
  }
}
