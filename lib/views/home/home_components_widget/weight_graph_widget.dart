import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:revalesuva/generated/assets.dart';
import 'package:revalesuva/utils/default_list.dart';
import 'package:revalesuva/utils/strings_constant.dart';
import 'package:revalesuva/view_models/weighing_and_measuring/weighing_and_measuring_view_model.dart';
import 'package:revalesuva/views/weighing_and_measuring/widget/history_data_item.dart';

class WeightGraphWidget extends StatefulWidget {
  const WeightGraphWidget({super.key});

  @override
  State<WeightGraphWidget> createState() => _WeightGraphWidgetState();
}

class _WeightGraphWidgetState extends State<WeightGraphWidget> {
  final WeighingAndMeasuringViewModel weighingAndMeasuringViewModel =
      Get.find<WeighingAndMeasuringViewModel>();

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
    return Obx(
      () => Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: HistoryDataItem(
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
    );
  }

  _initialize() {
    weighingAndMeasuringViewModel.weightList.assignAll(
      weighingAndMeasuringViewModel.calculateHistoryDataByMonth(
        selectedMonth: weighingAndMeasuringViewModel.selectedMonthForWeight.value,
        weights: weighingAndMeasuringViewModel.userdata.value.weights ?? [],
      ),
    );
  }
}
