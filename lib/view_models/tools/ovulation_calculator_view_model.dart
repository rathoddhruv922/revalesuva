import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:revalesuva/model/tools/ovulation_calculator/get_ovulation_model.dart'
    as get_ovulation_model;
import 'package:revalesuva/repository/repository.dart';
import 'package:revalesuva/services/api_status.dart';
import 'package:revalesuva/utils/date_format_helper.dart';
import 'package:revalesuva/utils/default_list.dart';
import 'package:revalesuva/utils/extension.dart';
import 'package:revalesuva/utils/helper_method.dart';
import 'package:revalesuva/utils/localization.dart';
import 'package:revalesuva/view_models/user_view_model.dart';

class OvulationCalculatorViewModel extends GetxController {
  // static const String _typeHormonal = 'hormonal';
  // static const String _typeOvulation = 'ovulation';
  // static const String _typeMenstrual = 'menstrual';

  var menstruationStatus = "".obs;
  var isLoader = false.obs;
  var numberOfCycleDays = "".obs;
  var listSelectedDate = <get_ovulation_model.Datum>[].obs;
  var showMoreDetail = false.obs;
  var userData = Get.find<UserViewModel>().userData;

  var txtDateOfLastPeriod = TextEditingController().obs;
  var isAvailable = false.obs;

  Future<void> onCreate() async {
    await Get.find<UserViewModel>().getUserDetail(isShowLoader: false);

    final user = userData.value;
    final periodList = DefaultList.periodList;

    menstruationStatus.value = periodList.firstWhereOrNull(
          (element) =>
              user.regularPeriod == element.translateValue("en_US").toLowerCase().replaceAll(" ", "_"),
        ) ??
        "";
    menstruationStatus.refresh();
    final lastPeriodDate = DateTime.tryParse(user.dateOfLastPeriod ?? "");
    final daysDifference = lastPeriodDate?.difference(DateTime.now()).inDays.abs() ?? 30;

    txtDateOfLastPeriod.value.text = daysDifference < 28
        ? user.dateOfLastPeriod ?? ""
        : changeDateStringFormat(
            date: DateTime.now().toString(),
            format: DateFormatHelper.ymdFormat,
          );

    numberOfCycleDays.value =
        (user.numberOfCycleDays ?? 0).isBetween(20, 30) ? "${user.numberOfCycleDays}" : "";

    showMoreDetail.value =
        menstruationStatus.value.translateValue("en_US").toLowerCase().replaceAll(" ", "_") ==
            "regular_period";

    await fetchSelectedDate();
    if (listSelectedDate.isNotEmpty) {
      DateTime? date1 = listSelectedDate.last.date;
      DateTime date2 = DateTime.now();

      if (date1 != null) {
        isAvailable.value = date2.isAfter(date1) || date2.isAtSameMomentAs(date1);
      } else {
        isAvailable.value = true;
      }
    } else {
      isAvailable.value = true;
    }
  }

  void updateEditMode() {
    update(['calendar_selection']);
  }

  Future<void> onSubmitSelectedDate() async {
    await storeOvulationDates();
    await onCreate();
  }

  // Future<void> updateGeneralInfo() async {
  //   try {
  //     final setUserModel = set_user.SetUserModel(
  //       dateOfLastPeriod: txtDateOfLastPeriod.text.isNotEmpty ? txtDateOfLastPeriod.text : null,
  //       regularPeriod:
  //           menstruationStatus.value.translateValue("en_US").toLowerCase().replaceAll(" ", "_"),
  //       numberOfCycleDays: numberOfCycleDays.value.isNotEmpty ? numberOfCycleDays.value : null,
  //     );
  //
  //     print(setUserModel.toJson());
  //     // showLoader();
  //     // final response = await Repository.instance.updateUserApi(userData: setUserModel);
  //     //
  //     // if (response is Success) {
  //     //   if (response.code == 200) {
  //     //     final result = user_model.userModelFromJson(response.response.toString());
  //     //     await Get.find<UserViewModel>().setUserData(userDetail: result.data);
  //     //     showToast(msg: result.message ?? "");
  //     //     await Get.find<UserViewModel>().getUserDetail(isShowLoader: true);
  //     //   }
  //     // } else if (response is Failure) {
  //     //   showToast(msg: "${response.errorResponse ?? ""}");
  //     // }
  //   } finally {
  //     //  hideLoader();
  //   }
  // }

  Future<void> storeOvulationDates() async {
    try {
      showLoader();
      String? date;
      int? days;

      if (showMoreDetail.isTrue && isAvailable.isTrue) {
        days = int.tryParse(numberOfCycleDays.value) ?? 20;
        date = txtDateOfLastPeriod.value.text;
      }
      final response = await Repository.instance.storeOvulationApi(
          days: days,
          date: date,
          periodType:
              menstruationStatus.value.translateValue("en_US").toLowerCase().replaceAll(" ", "_"));

      if (response is Success) {
        final result = get_ovulation_model.getOvulationModelFromJson(response.response.toString());
        listSelectedDate.assignAll(result.data ?? []);
      } else if (response is Failure) {
        showToast(msg: "${response.errorResponse ?? ""}");
      }
    } finally {
      hideLoader();
    }
  }

  Future<void> fetchSelectedDate() async {
    listSelectedDate.clear();

    final response = await Repository.instance.getOvulation();

    if (response is Success) {
      final result = get_ovulation_model.getOvulationModelFromJson(response.response.toString());
      listSelectedDate.assignAll(result.data ?? []);
      //await _processOvulationData(result.data);
    } else if (response is Failure) {
      showToast(msg: "${response.errorResponse ?? ""}");
    }
  }

// Future<void> _processOvulationData(List<dynamic>? data) async {
//   if (data?.isEmpty ?? true) return;
//
//   for (final item in data!) {
//     final date = DateTime.tryParse(item.date.toString());
//     if (date != null && _shouldAddDate(item.type)) {
//       listSelectedDate.add(date);
//     }
//   }
//
//   final sortedDates = listSelectedDate.toList()
//     ..sort();
//   listSelectedDate
//     ..clear()
//     ..addAll(sortedDates);
//
//   update(['calendar_selection']);
// }
//
// bool _shouldAddDate(String type) {
//   return switch (selectedOvulationType.value) {
//     OvulationType.hormonalDays => type == _typeHormonal,
//     OvulationType.ovulation => type == _typeOvulation,
//     OvulationType.menstruation => type == _typeMenstrual,
//   };
// }
}
