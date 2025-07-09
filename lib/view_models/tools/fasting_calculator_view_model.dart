import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:revalesuva/model/empty_model/empty_model.dart';
import 'package:revalesuva/model/tools/fasting_calculator/create_fasting_model.dart'
    as create_fasting_model;
import 'package:revalesuva/model/tools/fasting_calculator/fasting_calculator_list_model.dart'
    as fasting_calculator_list_model;
import 'package:revalesuva/repository/repository.dart';
import 'package:revalesuva/services/api_constant.dart';
import 'package:revalesuva/services/api_status.dart';
import 'package:revalesuva/utils/date_format_helper.dart';
import 'package:revalesuva/utils/helper_method.dart';
import 'package:revalesuva/utils/strings_constant.dart';

class FastingCalculatorViewModel extends GetxController {
  var targetHoursDisplay = "".obs;
  var targetHours = "".obs;
  var timeBlinker = true.obs;
  var currentDateTime = DateTime.now();

  var fastingHours = "".obs;
  var fastingMinutes = "".obs;

  var todayStartTime = "".obs;
  var currentSlot = fasting_calculator_list_model.Datum().obs;
  var timerPercentage = 0.0.obs;

  var listHistory = <fasting_calculator_list_model.Datum>[].obs;
  var perPage = "20";
  var currentPage = 1.obs;
  var isLoadingMore = false.obs;
  var isLoading = false.obs;
  var total = 1.obs;
  ScrollController scrollController = ScrollController();

  onCreate() {}

  Future<bool> startFasting({required Map<String, dynamic> param}) async {
    if (targetHours.value.isEmpty) {
      showToast(msg: "${StringConstants.numberOfTargetHours} ${StringConstants.required}");
    } else {
      showLoader();
      var response = await Repository.instance.createFastingApi(param: param);
      hideLoader();
      if (response is Success) {
        var result = create_fasting_model.createFastingModelFromJson(response.response.toString());
        var endTime =
            addHoursToTime(result.data?.startTime.toString() ?? "", result.data?.noOfFastingHours ?? 0);
        var param = {
          APIConstant.instance.kFastingId: result.data?.id,
          APIConstant.instance.kEndTime: convertToTimeString(endTime),
        };
        await updateForAllFasting(params: param);
        targetHours.value = "";
        targetHoursDisplay.value = "";
        showToast(msg: result.message ?? "");
        return true;
      } else if (response is Failure) {
        showToast(msg: "${response.errorResponse ?? ""}");
      }
    }
    return false;
  }

  updateFasting({required String startTime, required String date}) async {
    if (targetHours.value.isEmpty) {
      showToast(msg: "${StringConstants.numberOfTargetHours} ${StringConstants.required}");
    } else {
      var param = {
        APIConstant.instance.kFastingId: currentSlot.value.id,
        APIConstant.instance.kDate: date,
        APIConstant.instance.kNoOfFastingHours: int.tryParse(targetHours.value) ?? 0,
        APIConstant.instance.kStartTime: convertToTimeString(startTime),
      };
      showLoader();
      var response = await Repository.instance.updateFastingApi(
        params: param,
      );
      hideLoader();
      if (response is Success) {
        var result = emptyModelFromJson(response.response.toString());
        targetHours.value = "";
        targetHoursDisplay.value = "";
        showToast(msg: result.message ?? "");
        getTodayFastingData();
      } else if (response is Failure) {
        showToast(msg: "${response.errorResponse ?? ""}");
      }
    }
  }

  updateForAllFasting({required Map<String, dynamic> params}) async {
    showLoader();
    var response = await Repository.instance.updateFastingApi(
      params: params,
    );
    hideLoader();
    if (response is Success) {
      var result = emptyModelFromJson(response.response.toString());
      targetHours.value = "";
      targetHoursDisplay.value = "";
      showToast(msg: result.message ?? "");
      getTodayFastingData();
    } else if (response is Failure) {
      showToast(msg: "${response.errorResponse ?? ""}");
    }
  }

  Future<bool> getTodayFastingData({bool isShowLoader = true}) async {
    fastingHours.value = "";
    fastingMinutes.value = "";
    todayStartTime.value = "";
    if (isShowLoader) {
      showLoader();
    }
    var response = await Repository.instance.getFastingListListApi(
      page: "1",
      perPage: "1",
    );
    if (isShowLoader) {
      hideLoader();
    }

    if (response is Success) {
      var result =
          fasting_calculator_list_model.fastingCalculatorListModelFromJson(response.response.toString());
      currentSlot.value = result.data?.data?.first ?? fasting_calculator_list_model.Datum();
      if (result.data?.data?.isNotEmpty ?? false) {
        if (changeDateStringFormat(
                date: currentSlot.value.date.toString(), format: DateFormatHelper.ymdFormat) ==
            changeDateStringFormat(
                date: currentDateTime.toString(), format: DateFormatHelper.ymdFormat)) {
          var startTime = DateTime.tryParse(
            "${changeDateStringFormat(date: currentSlot.value.date.toString(), format: DateFormatHelper.ymdFormat)} ${currentSlot.value.startTime ?? ""}",
          );
          if (startTime != null) {
            todayStartTime.value = startTime.toString();
            getDifferenceBetweenStartTimeAndCurrentTime();
            return timerPercentage.value < 1;
          }
        }
      }
    } else if (response is Failure) {
      showToast(msg: "${response.errorResponse ?? ""}");
    }
    return false;
  }

  void getDifferenceBetweenStartTimeAndCurrentTime() {
    var startTime = DateTime.tryParse(todayStartTime.value);
    if (startTime != null) {
      DateTime now = DateTime.now();

      if (startTime.isAfter(now)) {
        startTime = startTime.subtract(const Duration(days: 1));
      }

      Duration elapsedTime = now.difference(startTime);
      int targetHours = currentSlot.value.noOfFastingHours ?? 0;
      int targetMinutes = targetHours * 60;

      int elapsedMinutes = elapsedTime.inMinutes;
      int remainingMinutes = targetMinutes - elapsedMinutes;

      String twoDigits(int n) => n.toString().padLeft(2, '0');

      if (remainingMinutes > 0) {
        fastingHours.value = twoDigits(remainingMinutes ~/ 60);
        fastingMinutes.value = twoDigits(remainingMinutes % 60);
      } else {
        fastingHours.value = "00";
        fastingMinutes.value = "00";
      }

      // Show percentage of time **left**, clamped between 0 and 1
      timerPercentage.value = (remainingMinutes / targetMinutes).clamp(0.0, 1.0);
    }
  }


  setupScrollController() {
    scrollController = ScrollController();
    scrollController.addListener(() {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent &&
          !isLoadingMore.value) {
        loadMore();
      }
    });
  }

  void loadMore() {
    if (listHistory.length < total.value) {
      currentPage.value++;
      getHistoryFastingData(isLoadMore: true);
    }
  }

  getHistoryFastingData({bool isLoadMore = false}) async {
    try {
      if (isLoadMore) {
        isLoadingMore.value = true;
      } else {
        isLoading.value = true;
      }
      var response = await Repository.instance.getFastingListListApi(
        perPage: perPage,
        page: currentPage.value.toString(),
      );
      if (response is Success) {
        var result = fasting_calculator_list_model
            .fastingCalculatorListModelFromJson(response.response.toString());
        if (isLoadMore) {
          listHistory.addAll(result.data?.data ?? <fasting_calculator_list_model.Datum>[]);
        } else {
          listHistory.value = result.data?.data ?? [];
        }
        total.value = result.data?.totalItems ?? 1;
      } else if (response is Failure) {
        showToast(msg: "${response.errorResponse ?? ""}");
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      if (isLoadMore) {
        isLoadingMore.value = false;
      } else {
        isLoading.value = false;
      }
    }
  }

  stopFasting() async {
    var param = {
      APIConstant.instance.kFastingId: currentSlot.value.id,
      APIConstant.instance.kEndTime: changeDateStringFormat(
        date: DateTime.now().toString(),
        format: DateFormatHelper.hmFormat,
      ),
    };
    await updateForAllFasting(params: param);
  }

  updateDuration({
    required int fastingId,
    required String startTime,
    required String date,
    required int hours,
    required int min,
  }) async {
    String dateString = date;
    String startTimeString = startTime;
    int durationInHours = hours;
    int durationInMinutes = min;

    DateTime startDateTime = DateTime.parse("$dateString $startTimeString");
    DateTime endDateTime =
        startDateTime.add(Duration(hours: durationInHours, minutes: durationInMinutes));
    String formattedEndTime =
        "${endDateTime.hour.toString().padLeft(2, '0')}:${endDateTime.minute.toString().padLeft(2, '0')}";

    if (compareTwoDate(date1: startDateTime.toString(), date2: endDateTime.toString()) ?? false) {
      var param = {
        APIConstant.instance.kFastingId: fastingId,
        APIConstant.instance.kEndTime: formattedEndTime,
      };
      await updateForAllFasting(params: param);
      currentPage.value = 1;
      total.value = 1;
      await getHistoryFastingData();
    } else {
      showToast(msg: "Duration is invalid because it extends to the next date");
    }
  }
}
