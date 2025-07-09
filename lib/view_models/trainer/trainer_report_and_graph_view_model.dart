import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:revalesuva/model/empty_model/empty_model.dart';
import 'package:revalesuva/model/excluded_day/excluded_day_model.dart' as excluded_day_model;
import 'package:revalesuva/model/personal_detail/user_model.dart' as user_model;
import 'package:revalesuva/model/tools/ovulation_calculator/get_ovulation_model.dart'
    as get_ovulation_model;
import 'package:revalesuva/model/weight_and_measuring/chart_model.dart';
import 'package:revalesuva/repository/repository.dart';
import 'package:revalesuva/services/api_status.dart';
import 'package:revalesuva/utils/date_format_helper.dart';
import 'package:revalesuva/utils/helper_method.dart';
import 'package:revalesuva/utils/strings_constant.dart';
import 'package:revalesuva/view_models/user_view_model.dart';

class TrainerReportAndGraphViewModel extends GetxController {
  var userData = user_model.Data().obs;
  var isLoading = false.obs;
  var listExcludedDate = <excluded_day_model.Datum>[].obs;

  var selectedMonthForWeight = "".obs;
  var selectedYearForChest = "".obs;
  var selectedYearForWaist = "".obs;
  var selectedYearForHip = "".obs;

  var isWeightChart = true.obs;
  var isChestChart = true.obs;
  var isWaistChart = true.obs;
  var isHipChart = true.obs;

  var weightMessageTitle = "".obs;
  var weightMessageDescription = "".obs;
  var weightIsError = false.obs;
  var nextWeightDate = "".obs;
  var previousWeightDate = "".obs;
  var previousWeight = "".obs;

  var previousBMI = "".obs;
  var bmiMessage = "".obs;

  var canUpdateWeight = false.obs;
  var canShowBMI = false.obs;

  var canUpdateCircumference = false.obs;
  var canShowCircumference = false.obs;

  var weightList = <ChartModel>[].obs;
  var chestList = <ChartModel>[].obs;
  var hipList = <ChartModel>[].obs;
  var waistList = <ChartModel>[].obs;

  var circumferenceTitle = "".obs;
  var circumferenceMessageDescription = "".obs;
  var nextCircumferenceDate = "".obs;
  var previousCircumferenceDate = "".obs;
  var previousCircumferenceChest = "".obs;
  var previousCircumferenceWaist = "".obs;
  var previousCircumferenceHip = "".obs;

  DateTime currentDate = DateTime.now();
  var txtWeight = "".obs;
  var txtHip = TextEditingController().obs;
  var txtWaist = TextEditingController().obs;
  var txtChest = TextEditingController().obs;

  onCreate() async {
    selectedMonthForWeight.value = getCurrentMonthInHebrew();
    selectedYearForChest.value = getCurrentYearInHebrew();
    selectedYearForWaist.value = getCurrentYearInHebrew();
    selectedYearForHip.value = getCurrentYearInHebrew();
    await Get.find<UserViewModel>().getUserDetail(isShowLoader: false);
    await getExcludedDate();
    await getOvulationDate();
    calculateWeightData();
    calculateCircumference();
  }

  getCustomerDetailById({required String customerId}) async {
    var response = await Repository.instance.getCustomerDetailByIdApi(
      customerId: customerId,
    );
    if (response is Success) {
      var result = user_model.userModelFromJson(response.response.toString());
      userData.value = result.data ?? user_model.Data();
    } else if (response is Failure) {
      showToast(msg: "${response.errorResponse ?? ""}");
    }
  }

  calculateWeightData() {
    if ((userData.value.weights?.isNotEmpty ?? false) ||
        (userData.value.initialWeight?.isNotEmpty ?? false)) {
      if (userData.value.weights?.isNotEmpty ?? false) {
        previousWeightDate.value = changeDateStringFormat(
          date: userData.value.weights?.last.createdAt ?? "",
          format: DateFormatHelper.ymdFormat,
        );
        previousWeight.value = userData.value.weights?.last.weight ?? "";
        previousBMI.value = calculateBMI(
                height: double.tryParse(userData.value.height ?? "0") ?? 0,
                weight: double.tryParse(previousWeight.value) ?? 0)
            .toStringAsFixed(2);

        nextWeightDate.value = changeDateStringFormat(
          date: getNextUpcomingWeightDate().toString(),
          format: DateFormatHelper.ymdFormat,
        );
        var currDate = changeDateStringFormat(
          date: currentDate.toString(),
          format: DateFormatHelper.ymdFormat,
        );
        if (nextWeightDate.value.toString() != currDate) {
          weightMessageTitle.value =
              StringConstants.weWillMeetOnNextWeighIn.replaceFirst("{}", nextWeightDate.value);
          weightMessageDescription.value = "";
          weightIsError.value = false;
          canUpdateWeight.value = false;
          if (previousWeightDate.value == currDate) {
            canShowBMI.value = true;
          } else {
            canShowBMI.value = false;
          }
        } else {
          weightMessageTitle.value = StringConstants.timeForWeeklyWeighIn;
          weightMessageDescription.value = "";
          weightIsError.value = false;
          canUpdateWeight.value = true;
          canShowBMI.value = true;
        }
      } else {
        previousWeightDate.value = changeDateStringFormat(
            date: userData.value.createdAt ?? "", format: DateFormatHelper.ymdFormat);
        previousWeight.value = userData.value.initialWeight ?? "";
        previousBMI.value = calculateBMI(
                height: double.tryParse(userData.value.height ?? "0") ?? 0,
                weight: double.tryParse(previousWeight.value) ?? 0)
            .toStringAsFixed(2);

        nextWeightDate.value = changeDateStringFormat(
            date: getNextUpcomingWeightDate().toString(), format: DateFormatHelper.ymdFormat);
        var currDate =
            changeDateStringFormat(date: currentDate.toString(), format: DateFormatHelper.ymdFormat);

        if (nextWeightDate.value.toString() != currDate) {
          weightMessageTitle.value =
              StringConstants.weWillMeetOnNextWeighIn.replaceFirst("{}", nextWeightDate.value);
          weightMessageDescription.value = "";
          weightIsError.value = false;
          canUpdateWeight.value = false;
          if (previousWeightDate.value == currDate) {
            canShowBMI.value = true;
          } else {
            canShowBMI.value = false;
          }
        } else {
          weightMessageTitle.value = StringConstants.timeForWeeklyWeighIn;
          weightMessageDescription.value = "";
          weightIsError.value = false;
          canUpdateWeight.value = true;
          canShowBMI.value = true;
        }
      }
      setBMIMessage();
    } else {
      weightIsError.value = true;
      weightMessageTitle.value = StringConstants.youHaveNotEnteredCurrentWeightYet;
      weightMessageDescription.value = StringConstants.clickHereToWeighYourself;
    }
  }

  calculateCircumference() {
    if (userData.value.circumferences?.isNotEmpty ?? false) {
      previousCircumferenceDate.value = changeDateStringFormat(
        date: userData.value.circumferences?.last.createdAt ?? "",
        format: DateFormatHelper.ymdFormat,
      );

      previousCircumferenceChest.value = userData.value.circumferences?.last.chest ?? "";
      previousCircumferenceWaist.value = userData.value.circumferences?.last.waist ?? "";
      previousCircumferenceHip.value = userData.value.circumferences?.last.hip ?? "";

      nextCircumferenceDate.value = changeDateStringFormat(
          date: getNextUpcomingCircumferenceDate().toString(), format: DateFormatHelper.ymdFormat);
      var currDate =
          changeDateStringFormat(date: currentDate.toString(), format: DateFormatHelper.ymdFormat);

      if (nextCircumferenceDate.value.toString() != currDate) {
        circumferenceTitle.value = StringConstants.youAreOnTheRightTrack;
        circumferenceMessageDescription.value =
            StringConstants.weWillMeetOnNextMeasurement.replaceFirst("{}", nextCircumferenceDate.value);
        canUpdateCircumference.value = false;
        if (previousCircumferenceDate.value == currDate) {
          canShowCircumference.value = true;
        } else {
          canShowCircumference.value = false;
        }
      } else {
        circumferenceTitle.value = StringConstants.timeToMeasureCircumference;
        weightMessageDescription.value = StringConstants.howToMeasure;
        canUpdateCircumference.value = true;
        canShowCircumference.value = true;
      }
    } else {
      canUpdateCircumference.value = false;
    }
  }

  void setBMIMessage() {
    if (previousBMI.value.isEmpty) {
      bmiMessage.value = "";
      return;
    }

    double bmi = double.tryParse(previousBMI.value) ?? 0.0;

    if (bmi <= 0) {
      bmiMessage.value = "";
    } else if (bmi < 18.5) {
      bmiMessage.value = StringConstants.keepItUp;
    } else if (bmi >= 18.5 && bmi < 24.9) {
      bmiMessage.value = StringConstants.champion;
    } else if (bmi >= 25 && bmi < 29.9) {
      bmiMessage.value = StringConstants.veryNiceProgress;
    } else {
      bmiMessage.value = StringConstants.keepItUp;
    }
  }

  getNextUpcomingWeightDate() {
    DateTime? weightIntDate = DateTime.tryParse(userData.value.createdAt ?? "");
    int daysUntilNext = ((weightIntDate?.weekday ?? 0) - currentDate.weekday + 7) % 7;
    DateTime nextDate = currentDate.add(Duration(days: daysUntilNext));

    String lastWeight = changeDateStringFormat(
      date: previousWeightDate.value,
      format: DateFormatHelper.ymdFormat,
    );
    while (listExcludedDate.any(
          (element) => changeDateStringFormat(
            date: nextDate.toString(),
            format: DateFormatHelper.ymdFormat,
          ).contains(
            changeDateStringFormat(
              date: element.date.toString(),
              format: DateFormatHelper.ymdFormat,
            ),
          ),
        ) ||
        changeDateStringFormat(
          date: nextDate.toString(),
          format: DateFormatHelper.ymdFormat,
        ).contains(lastWeight)) {
      nextDate = nextDate.add(const Duration(days: 7));
    }
    return nextDate;
  }

  getNextUpcomingCircumferenceDate() {
    DateTime? weightIntDate = DateTime.tryParse(userData.value.createdAt ?? "");
    if (weightIntDate == null) {
      return DateTime.now(); // Handle the case where weightIntDate is null
    }

    DateTime nextDate = DateTime(weightIntDate.year, weightIntDate.month + 1, weightIntDate.day);
    DateTime? lastWeight = DateTime.tryParse(previousWeightDate.value);

    while (listExcludedDate.any(
          (element) => changeDateStringFormat(
            date: nextDate.toString(),
            format: DateFormatHelper.ymdFormat,
          ).contains(
            changeDateStringFormat(
              date: element.date.toString(),
              format: DateFormatHelper.ymdFormat,
            ),
          ),
        ) ||
        changeDateStringFormat(
          date: nextDate.toString(),
          format: DateFormatHelper.ymdFormat,
        ).contains(
          changeDateStringFormat(
            date: lastWeight?.toString() ?? "",
            format: DateFormatHelper.ymdFormat,
          ),
        )) {
      nextDate = DateTime(nextDate.year, nextDate.month + 1, nextDate.day);
    }

    return nextDate;
  }

  Future<void> getExcludedDate() async {
    var response = await Repository.instance.getPublicExcludeDayApi();
    if (response is Success) {
      var result = excluded_day_model.excludedDayModelFromJson(response.response.toString());
      listExcludedDate.assignAll(result.data ?? []);
    } else if (response is Failure) {
      showToast(msg: "${response.errorResponse ?? ""}");
    }
  }

  Future<void> getOvulationDate() async {
    var response = await Repository.instance.getOvulation();
    if (response is Success) {
      var result = get_ovulation_model.getOvulationModelFromJson(response.response.toString());
      var ovulationList = <excluded_day_model.Datum>[];
      for (var item in result.data ?? <get_ovulation_model.Datum>[]) {
        ovulationList.add(
          excluded_day_model.Datum(
            id: item.id,
            createdAt: item.createdAt,
            updatedAt: item.updatedAt,
            isActive: 1,
            type: item.type,
            date: item.date.toString(),
          ),
        );
      }
      listExcludedDate.assignAll(ovulationList);
    } else if (response is Failure) {
      showToast(msg: "${response.errorResponse ?? ""}");
    }
  }

  String getCurrentMonthInHebrew({DateTime? date}) {
    if (date == null) {
      final now = DateTime.now();
      final formatter = DateFormat.MMMM('he');
      return formatter.format(now);
    } else {
      final now = date;
      final formatter = DateFormat.MMMM('he');
      return formatter.format(now);
    }
  }

  String getCurrentYearInHebrew({DateTime? date}) {
    final now = date ?? DateTime.now();
    final formatter = DateFormat.y('he');
    return formatter.format(now);
  }

  Future<void> updateWeightData() async {
    if (txtWeight.value.isEmpty) {
      showToast(msg: "${StringConstants.weight} ${StringConstants.required}");
    } else {
      showLoader();
      var response = await Repository.instance.setUserWeight(
        date: changeDateStringFormat(
          date: currentDate.toString(),
          format: DateFormatHelper.ymdFormat,
        ),
        weight: double.tryParse(txtWeight.value) ?? 0.0,
      );
      hideLoader();
      if (response is Success) {
        if (response.code == 200) {
          var result = emptyModelFromJson(response.response.toString());
          showToast(msg: result.message ?? "");
          onCreate();
        }
      } else if (response is Failure) {
        showToast(msg: "${response.errorResponse ?? ""}");
      }
    }
  }

  Future<void> updateCircumference() async {
    if (txtWaist.value.text.isEmpty || txtChest.value.text.isEmpty || txtHip.value.text.isEmpty) {
      showToast(msg: "${StringConstants.circumference} ${StringConstants.required}");
    } else {
      showLoader();
      var response = await Repository.instance.setUserCircumference(
        date: changeDateStringFormat(
          date: currentDate.toString(),
          format: DateFormatHelper.ymdFormat,
        ),
        chest: double.tryParse(txtChest.value.text) ?? 0.0,
        hip: double.tryParse(txtHip.value.text) ?? 0.0,
        waist: double.tryParse(txtWaist.value.text) ?? 0.0,
      );
      hideLoader();
      if (response is Success) {
        if (response.code == 200) {
          var result = emptyModelFromJson(response.response.toString());
          showToast(msg: result.message ?? "");
          onCreate();
        }
      } else if (response is Failure) {
        showToast(msg: "${response.errorResponse ?? ""}");
      }
    }
  }

  List<ChartModel> calculateHistoryDataByMonth({
    required List<user_model.Weight> weights,
    required String selectedMonth,
  }) {
    List<ChartModel> tempList = [];
    for (user_model.Weight item in weights) {
      DateTime? tempDate = DateTime.tryParse(item.createdAt ?? "");
      if (tempDate != null) {
        if (selectedMonth == getCurrentMonthInHebrew(date: tempDate)) {
          tempList.add(
            ChartModel(
              date: changeDateStringFormat(
                date: item.createdAt.toString(),
                format: DateFormatHelper.dmyFormat,
              ),
              value: double.tryParse(item.weight ?? "") ?? 0.0,
            ),
          );
        }
      }
    }
    return tempList;
  }

  List<ChartModel> calculateHistoryDataByYear({
    required List<user_model.Circumference> circumference,
    required String selectedYear,
    required String circumferenceType,
  }) {
    List<ChartModel> tempList = [];
    for (user_model.Circumference item in circumference) {
      DateTime? tempDate = DateTime.tryParse(item.createdAt ?? "");
      if (tempDate != null && selectedYear == getCurrentYearInHebrew(date: tempDate)) {
        if (circumferenceType == "chest") {
          tempList.add(
            ChartModel(
              date: changeDateStringFormat(
                date: item.createdAt.toString(),
                format: DateFormatHelper.dmyFormat,
              ),
              value: double.tryParse(item.chest ?? "") ?? 0.0,
            ),
          );
        } else if (circumferenceType == "hip") {
          tempList.add(
            ChartModel(
              date: changeDateStringFormat(
                date: item.createdAt.toString(),
                format: DateFormatHelper.dmyFormat,
              ),
              value: double.tryParse(item.hip ?? "") ?? 0.0,
            ),
          );
        } else if (circumferenceType == "waist") {
          tempList.add(
            ChartModel(
              date: changeDateStringFormat(
                date: item.createdAt.toString(),
                format: DateFormatHelper.dmyFormat,
              ),
              value: double.tryParse(item.waist ?? "") ?? 0.0,
            ),
          );
        }
      }
    }
    return tempList;
  }
}
