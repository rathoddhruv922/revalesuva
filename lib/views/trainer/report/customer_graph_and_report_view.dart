import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:revalesuva/components/custom_appbar.dart';
import 'package:revalesuva/components/custom_click.dart';
import 'package:revalesuva/components/custom_text.dart';
import 'package:revalesuva/generated/assets.dart';
import 'package:revalesuva/model/trainer/home/customer_model.dart' as customer_model;
import 'package:revalesuva/utils/app_colors.dart';
import 'package:revalesuva/utils/default_list.dart';
import 'package:revalesuva/utils/strings_constant.dart';
import 'package:revalesuva/view_models/trainer/trainer_report_and_graph_view_model.dart';
import 'package:revalesuva/views/trainer/widget/drawer_widget.dart';
import 'package:revalesuva/views/weighing_and_measuring/widget/history_data_item.dart';

class CustomerGraphAndReportView extends StatefulWidget {
  const CustomerGraphAndReportView({super.key, required this.data});

  final customer_model.Datum data;

  @override
  State<CustomerGraphAndReportView> createState() => _CustomerGraphAndReportViewState();
}

class _CustomerGraphAndReportViewState extends State<CustomerGraphAndReportView>
    with AutomaticKeepAliveClientMixin {
  final ScrollController _scrollController = ScrollController();

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final TrainerReportAndGraphViewModel trainerReportAndGraphViewModel =
      Get.put(TrainerReportAndGraphViewModel());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        trainerReportAndGraphViewModel.isLoading.value = true;
        await trainerReportAndGraphViewModel.getCustomerDetailById(
          customerId: "${widget.data.id ?? ""}",
        );
        await trainerReportAndGraphViewModel.onCreate();
        _initialize();
        trainerReportAndGraphViewModel.isLoading.value = false;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      key: scaffoldKey,
      appBar: customAppBarTrainer(
        key: scaffoldKey,
      ),
      drawer: DrawerWidget(
        drawerKey: scaffoldKey,
      ),
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
            const Gap(10),
            Expanded(
              child: ListView(
                physics: const BouncingScrollPhysics(),
                cacheExtent: 1000.0,
                controller: _scrollController,
                addAutomaticKeepAlives: true,
                children: [
                  Obx(
                    () => HistoryDataItem(
                      title: StringConstants.weight,
                      icon: Assets.iconsIcWeighWhite,
                      firstLabel: StringConstants.firstWeighIn,
                      firstValue: trainerReportAndGraphViewModel.weightList.isNotEmpty
                          ? "${trainerReportAndGraphViewModel.weightList.first.value ?? ""} "
                              "${StringConstants.kg}"
                          : "-",
                      onTabTable: () {
                        trainerReportAndGraphViewModel.isWeightChart.value = false;
                      },
                      onTapChart: () {
                        trainerReportAndGraphViewModel.isWeightChart.value = true;
                      },
                      isChartShow: trainerReportAndGraphViewModel.isWeightChart.value,
                      lastLabel: StringConstants.lastWeighIn,
                      lastValue: trainerReportAndGraphViewModel.weightList.isNotEmpty
                          ? "${trainerReportAndGraphViewModel.weightList.last.value ?? ""} "
                              "${StringConstants.kg}"
                          : "-",
                      dataList: trainerReportAndGraphViewModel.weightList,
                      // message: StringConstants.lostWeight.replaceAll("{}", "10"),
                      message: "",
                      selectedValue: trainerReportAndGraphViewModel.selectedMonthForWeight.value,
                      onChanged: (value) {
                        if (value != null) {
                          trainerReportAndGraphViewModel.selectedMonthForWeight.value = value;
                          trainerReportAndGraphViewModel.weightList.assignAll(
                            trainerReportAndGraphViewModel.calculateHistoryDataByMonth(
                              selectedMonth: trainerReportAndGraphViewModel.selectedMonthForWeight.value,
                              weights: trainerReportAndGraphViewModel.userData.value.weights ?? [],
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
                      firstValue: trainerReportAndGraphViewModel.chestList.isNotEmpty
                          ? "${trainerReportAndGraphViewModel.chestList.first.value ?? ""} ${StringConstants.cm}"
                          : "-",
                      lastValue: trainerReportAndGraphViewModel.chestList.isNotEmpty
                          ? "${trainerReportAndGraphViewModel.chestList.last.value ?? ""} ${StringConstants.cm}"
                          : "-",
                      onTabTable: () {
                        trainerReportAndGraphViewModel.isChestChart.value = false;
                      },
                      onTapChart: () {
                        trainerReportAndGraphViewModel.isChestChart.value = true;
                      },
                      isChartShow: trainerReportAndGraphViewModel.isChestChart.value,
                      dataList: trainerReportAndGraphViewModel.chestList,
                      // message: StringConstants.lostWeight.replaceAll("{}", "10"),
                      message: "",
                      selectedValue: trainerReportAndGraphViewModel.selectedYearForChest.value,
                      onChanged: (value) {
                        if (value != null) {
                          trainerReportAndGraphViewModel.selectedYearForChest.value = value;
                          trainerReportAndGraphViewModel.chestList.assignAll(
                            trainerReportAndGraphViewModel.calculateHistoryDataByYear(
                              selectedYear: trainerReportAndGraphViewModel.selectedYearForChest.value,
                              circumference:
                              trainerReportAndGraphViewModel.userData.value.circumferences ?? [],
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
                      firstValue: trainerReportAndGraphViewModel.hipList.isNotEmpty
                          ? "${trainerReportAndGraphViewModel.hipList.first.value ?? ""} ${StringConstants.cm}"
                          : "-",
                      lastValue: trainerReportAndGraphViewModel.hipList.isNotEmpty
                          ? "${trainerReportAndGraphViewModel.hipList.last.value ?? ""} ${StringConstants.cm}"
                          : "-",
                      onTabTable: () {
                        trainerReportAndGraphViewModel.isHipChart.value = false;
                      },
                      onTapChart: () {
                        trainerReportAndGraphViewModel.isHipChart.value = true;
                      },
                      isChartShow: trainerReportAndGraphViewModel.isHipChart.value,
                      dataList: trainerReportAndGraphViewModel.hipList,
                      // message: StringConstants.lostWeight.replaceAll("{}", "10"),
                      message: "",
                      selectedValue: trainerReportAndGraphViewModel.selectedYearForHip.value,
                      onChanged: (value) {
                        if (value != null) {
                          trainerReportAndGraphViewModel.selectedYearForHip.value = value;
                          trainerReportAndGraphViewModel.hipList.assignAll(
                            trainerReportAndGraphViewModel.calculateHistoryDataByYear(
                              selectedYear: trainerReportAndGraphViewModel.selectedYearForHip.value,
                              circumference:
                              trainerReportAndGraphViewModel.userData.value.circumferences ?? [],
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
                      firstValue: trainerReportAndGraphViewModel.waistList.isNotEmpty
                          ? "${trainerReportAndGraphViewModel.waistList.first.value ?? ""} ${StringConstants.cm}"
                          : "-",
                      lastValue: trainerReportAndGraphViewModel.waistList.isNotEmpty
                          ? "${trainerReportAndGraphViewModel.waistList.last.value ?? ""} ${StringConstants.cm}"
                          : "-",
                      onTabTable: () {
                        trainerReportAndGraphViewModel.isWaistChart.value = false;
                      },
                      onTapChart: () {
                        trainerReportAndGraphViewModel.isWaistChart.value = true;
                      },
                      isChartShow: trainerReportAndGraphViewModel.isWaistChart.value,
                      dataList: trainerReportAndGraphViewModel.waistList,
                      // message: StringConstants.lostWeight.replaceAll("{}", "10"),
                      message: "",
                      selectedValue: trainerReportAndGraphViewModel.selectedYearForWaist.value,
                      onChanged: (value) {
                        if (value != null) {
                          trainerReportAndGraphViewModel.selectedYearForWaist.value = value;
                          trainerReportAndGraphViewModel.waistList.assignAll(
                            trainerReportAndGraphViewModel.calculateHistoryDataByYear(
                              selectedYear: trainerReportAndGraphViewModel.selectedYearForWaist.value,
                              circumference:
                              trainerReportAndGraphViewModel.userData.value.circumferences ?? [],
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
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  _initialize() {
    trainerReportAndGraphViewModel.weightList.assignAll(
      trainerReportAndGraphViewModel.calculateHistoryDataByMonth(
        selectedMonth: trainerReportAndGraphViewModel.selectedMonthForWeight.value,
        weights: trainerReportAndGraphViewModel.userData.value.weights ?? [],
      ),
    );
    trainerReportAndGraphViewModel.chestList.assignAll(
      trainerReportAndGraphViewModel.calculateHistoryDataByYear(
        selectedYear: trainerReportAndGraphViewModel.selectedYearForChest.value,
        circumference: trainerReportAndGraphViewModel.userData.value.circumferences ?? [],
        circumferenceType: 'chest',
      ),
    );
    trainerReportAndGraphViewModel.hipList.assignAll(
      trainerReportAndGraphViewModel.calculateHistoryDataByYear(
        selectedYear: trainerReportAndGraphViewModel.selectedYearForHip.value,
        circumference: trainerReportAndGraphViewModel.userData.value.circumferences ?? [],
        circumferenceType: 'hip',
      ),
    );
    trainerReportAndGraphViewModel.waistList.assignAll(
      trainerReportAndGraphViewModel.calculateHistoryDataByYear(
        selectedYear: trainerReportAndGraphViewModel.selectedYearForWaist.value,
        circumference: trainerReportAndGraphViewModel.userData.value.circumferences ?? [],
        circumferenceType: 'waist',
      ),
    );
  }
}
