import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:revalesuva/components/custom_click.dart';
import 'package:revalesuva/components/custom_text.dart';
import 'package:revalesuva/generated/assets.dart';
import 'package:revalesuva/utils/app_colors.dart';
import 'package:revalesuva/utils/default_list.dart';
import 'package:revalesuva/utils/navigation_helper.dart';
import 'package:revalesuva/utils/strings_constant.dart';
import 'package:revalesuva/view_models/weighing_and_measuring/weighing_and_measuring_view_model.dart';
import 'package:revalesuva/views/weighing_and_measuring/widget/history_data_item.dart';

class WeighingAndMeasuringHistoryView extends StatefulWidget {
  const WeighingAndMeasuringHistoryView({super.key});

  @override
  State<WeighingAndMeasuringHistoryView> createState() => _WeighingAndMeasuringHistoryViewState();
}

class _WeighingAndMeasuringHistoryViewState extends State<WeighingAndMeasuringHistoryView>
    with AutomaticKeepAliveClientMixin {
  final WeighingAndMeasuringViewModel weighingAndMeasuringViewModel =
      Get.find<WeighingAndMeasuringViewModel>();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        weighingAndMeasuringViewModel.onCreate();
        _initialize();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        NavigationHelper.onBackScreen(widget: const WeighingAndMeasuringHistoryView());
      },
      canPop: true,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
              const Gap(10),
              Align(
                alignment: AlignmentDirectional.centerStart,
                child: TextHeadlineMedium(
                  text: StringConstants.weighingAndCircumferenceDataHistory,
                  color: AppColors.textPrimary,
                  letterSpacing: 0,
                ),
              ),
              Expanded(
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  cacheExtent: 1000.0,
                  controller: _scrollController,
                  addAutomaticKeepAlives: true,
                  children: [
                    const Gap(20),
                    Obx(
                      () => HistoryDataItem(
                        title: StringConstants.weight,
                        icon: Assets.iconsIcWeighWhite,
                        firstLabel: StringConstants.firstWeighIn,
                        firstValue: weighingAndMeasuringViewModel.weightList.isNotEmpty
                            ? "${weighingAndMeasuringViewModel.weightList.first.value ?? ""} "
                                "${StringConstants.kg}"
                            : "-",
                        onTabTable: () {
                          weighingAndMeasuringViewModel.isWeightChart.value = false;
                        },
                        onTapChart: () {
                          weighingAndMeasuringViewModel.isWeightChart.value = true;
                        },
                        isChartShow: weighingAndMeasuringViewModel.isWeightChart.value,
                        lastLabel: StringConstants.lastWeighIn,
                        lastValue: weighingAndMeasuringViewModel.weightList.isNotEmpty
                            ? "${weighingAndMeasuringViewModel.weightList.last.value ?? ""} "
                                "${StringConstants.kg}"
                            : "-",
                        dataList: weighingAndMeasuringViewModel.weightList,
                        // message: StringConstants.lostWeight.replaceAll("{}", "10"),
                        message: "",
                        selectedValue: weighingAndMeasuringViewModel.selectedMonthForWeight.value,
                        onChanged: (value) {
                          if (value != null) {
                            weighingAndMeasuringViewModel.selectedMonthForWeight.value = value;
                            weighingAndMeasuringViewModel.weightList.assignAll(
                              weighingAndMeasuringViewModel.calculateHistoryDataByMonth(
                                selectedMonth: weighingAndMeasuringViewModel.selectedMonthForWeight.value,
                                weights: weighingAndMeasuringViewModel.userdata.value.weights ?? [],
                              ),
                            );
                          }
                        },
                        dropDownList: DefaultList.monthList,
                      ),
                    ),
                    const Gap(10),
                    Obx(
                      () => HistoryDataItem(
                        title: StringConstants.chestLine,
                        icon: Assets.iconsIcWeighWhite,
                        firstLabel: StringConstants.firstMeasurement,
                        lastLabel: StringConstants.lastMeasurement,
                        firstValue: weighingAndMeasuringViewModel.chestList.isNotEmpty
                            ? "${weighingAndMeasuringViewModel.chestList.first.value ?? ""} ${StringConstants.cm}"
                            : "-",
                        lastValue: weighingAndMeasuringViewModel.chestList.isNotEmpty
                            ? "${weighingAndMeasuringViewModel.chestList.last.value ?? ""} ${StringConstants.cm}"
                            : "-",
                        onTabTable: () {
                          weighingAndMeasuringViewModel.isChestChart.value = false;
                        },
                        onTapChart: () {
                          weighingAndMeasuringViewModel.isChestChart.value = true;
                        },
                        isChartShow: weighingAndMeasuringViewModel.isChestChart.value,
                        dataList: weighingAndMeasuringViewModel.chestList,
                        // message: StringConstants.lostWeight.replaceAll("{}", "10"),
                        message: "",
                        selectedValue: weighingAndMeasuringViewModel.selectedYearForChest.value,
                        onChanged: (value) {
                          if (value != null) {
                            weighingAndMeasuringViewModel.selectedYearForChest.value = value;
                            weighingAndMeasuringViewModel.chestList.assignAll(
                              weighingAndMeasuringViewModel.calculateHistoryDataByYear(
                                selectedYear: weighingAndMeasuringViewModel.selectedYearForChest.value,
                                circumference:
                                    weighingAndMeasuringViewModel.userdata.value.circumferences ?? [],
                                circumferenceType: 'chest',
                              ),
                            );
                          }
                        },
                        dropDownList: DefaultList.yearList(),
                      ),
                    ),
                    const Gap(10),
                    Obx(
                      () => HistoryDataItem(
                        title: StringConstants.hipLine,
                        icon: Assets.iconsIcWeighWhite,
                        firstLabel: StringConstants.firstMeasurement,
                        lastLabel: StringConstants.lastMeasurement,
                        firstValue: weighingAndMeasuringViewModel.hipList.isNotEmpty
                            ? "${weighingAndMeasuringViewModel.hipList.first.value ?? ""} ${StringConstants.cm}"
                            : "-",
                        lastValue: weighingAndMeasuringViewModel.hipList.isNotEmpty
                            ? "${weighingAndMeasuringViewModel.hipList.last.value ?? ""} ${StringConstants.cm}"
                            : "-",
                        onTabTable: () {
                          weighingAndMeasuringViewModel.isHipChart.value = false;
                        },
                        onTapChart: () {
                          weighingAndMeasuringViewModel.isHipChart.value = true;
                        },
                        isChartShow: weighingAndMeasuringViewModel.isHipChart.value,
                        dataList: weighingAndMeasuringViewModel.hipList,
                        // message: StringConstants.lostWeight.replaceAll("{}", "10"),
                        message: "",
                        selectedValue: weighingAndMeasuringViewModel.selectedYearForHip.value,
                        onChanged: (value) {
                          if (value != null) {
                            weighingAndMeasuringViewModel.selectedYearForHip.value = value;
                            weighingAndMeasuringViewModel.hipList.assignAll(
                              weighingAndMeasuringViewModel.calculateHistoryDataByYear(
                                selectedYear: weighingAndMeasuringViewModel.selectedYearForHip.value,
                                circumference:
                                    weighingAndMeasuringViewModel.userdata.value.circumferences ?? [],
                                circumferenceType: 'hip',
                              ),
                            );
                          }
                        },
                        dropDownList: DefaultList.yearList(),
                      ),
                    ),
                    const Gap(10),
                    Obx(
                      () => HistoryDataItem(
                        title: StringConstants.abdominalLine,
                        icon: Assets.iconsIcWeighWhite,
                        firstLabel: StringConstants.firstMeasurement,
                        lastLabel: StringConstants.lastMeasurement,
                        firstValue: weighingAndMeasuringViewModel.waistList.isNotEmpty
                            ? "${weighingAndMeasuringViewModel.waistList.first.value ?? ""} ${StringConstants.cm}"
                            : "-",
                        lastValue: weighingAndMeasuringViewModel.waistList.isNotEmpty
                            ? "${weighingAndMeasuringViewModel.waistList.last.value ?? ""} ${StringConstants.cm}"
                            : "-",
                        onTabTable: () {
                          weighingAndMeasuringViewModel.isWaistChart.value = false;
                        },
                        onTapChart: () {
                          weighingAndMeasuringViewModel.isWaistChart.value = true;
                        },
                        isChartShow: weighingAndMeasuringViewModel.isWaistChart.value,
                        dataList: weighingAndMeasuringViewModel.waistList,
                        // message: StringConstants.lostWeight.replaceAll("{}", "10"),
                        message: "",
                        selectedValue: weighingAndMeasuringViewModel.selectedYearForWaist.value,
                        onChanged: (value) {
                          if (value != null) {
                            weighingAndMeasuringViewModel.selectedYearForWaist.value = value;
                            weighingAndMeasuringViewModel.waistList.assignAll(
                              weighingAndMeasuringViewModel.calculateHistoryDataByYear(
                                selectedYear: weighingAndMeasuringViewModel.selectedYearForWaist.value,
                                circumference:
                                    weighingAndMeasuringViewModel.userdata.value.circumferences ?? [],
                                circumferenceType: 'waist',
                              ),
                            );
                          }
                        },
                        dropDownList: DefaultList.yearList(),
                      ),
                    ),
                    const Gap(80),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  _initialize() {
    weighingAndMeasuringViewModel.weightList.assignAll(
      weighingAndMeasuringViewModel.calculateHistoryDataByMonth(
        selectedMonth: weighingAndMeasuringViewModel.selectedMonthForWeight.value,
        weights: weighingAndMeasuringViewModel.userdata.value.weights ?? [],
      ),
    );
    weighingAndMeasuringViewModel.chestList.assignAll(
      weighingAndMeasuringViewModel.calculateHistoryDataByYear(
        selectedYear: weighingAndMeasuringViewModel.selectedYearForChest.value,
        circumference: weighingAndMeasuringViewModel.userdata.value.circumferences ?? [],
        circumferenceType: 'chest',
      ),
    );
    weighingAndMeasuringViewModel.hipList.assignAll(
      weighingAndMeasuringViewModel.calculateHistoryDataByYear(
        selectedYear: weighingAndMeasuringViewModel.selectedYearForHip.value,
        circumference: weighingAndMeasuringViewModel.userdata.value.circumferences ?? [],
        circumferenceType: 'hip',
      ),
    );
    weighingAndMeasuringViewModel.waistList.assignAll(
      weighingAndMeasuringViewModel.calculateHistoryDataByYear(
        selectedYear: weighingAndMeasuringViewModel.selectedYearForWaist.value,
        circumference: weighingAndMeasuringViewModel.userdata.value.circumferences ?? [],
        circumferenceType: 'waist',
      ),
    );
  }
}
