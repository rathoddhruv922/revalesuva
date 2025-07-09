import 'package:get/get.dart';
import 'package:revalesuva/model/empty_model/empty_model.dart';
import 'package:revalesuva/model/my_plan/program/program_schedule_model.dart' as program_schedule_model;
import 'package:revalesuva/repository/repository.dart';
import 'package:revalesuva/services/api_status.dart';
import 'package:revalesuva/utils/date_format_helper.dart';
import 'package:revalesuva/utils/helper_method.dart';
import 'package:revalesuva/utils/strings_constant.dart';

class ProgramViewModel extends GetxController {
  var isLoading = false.obs;
  var selectedDate = DateTime.now().obs;
  var listSchedules = <program_schedule_model.Datum>[].obs;

  getScheduleByDate({required String programId}) async {
    var response = await Repository.instance.getProgramSchedule(
      date: changeDateStringFormat(
        date: selectedDate.value.toString(),
        format: DateFormatHelper.ymdFormat,
      ),
      programId: programId,
    );
    if (response is Success) {
      var result = program_schedule_model.programScheduleModelFromJson(response.response.toString());
      listSchedules.assignAll(result.data ?? []);
    } else if (response is Failure) {
      listSchedules.clear();
    }
  }

  addSchedule({
    required String programId,
    required String scheduleId,
    required String status,
  }) async {
    showLoader();
    var response = await Repository.instance.addScheduleApi(
      date: changeDateStringFormat(
        date: selectedDate.value.toString(),
        format: DateFormatHelper.ymdFormat,
      ),
      programId: programId,
      scheduleId: scheduleId,
      status: status,
    );
    hideLoader();
    if (response is Success) {
      var result = emptyModelFromJson(response.response.toString());
      await getScheduleByDate(programId: programId);
    } else if (response is Failure) {
      if (response.code != 404) {
        showToast(msg: "${response.errorResponse ?? ""}");
      }
    }
  }

  exitSchedule({
    required String programId,
    required String scheduleId,
    required String status,
  }) async {
    showLoader();
    var response = await Repository.instance.exitScheduleApi(
      date: changeDateStringFormat(
        date: selectedDate.value.toString(),
        format: DateFormatHelper.ymdFormat,
      ),
      programId: programId,
      scheduleId: scheduleId,
      status: status,
    );
    hideLoader();
    if (response is Success) {
      var result = emptyModelFromJson(response.response.toString());
      await getScheduleByDate(programId: programId);
    } else if (response is Failure) {
      if (response.code != 404) {
        showToast(msg: "${response.errorResponse ?? ""}");
      }
    }
  }

  Map<String, dynamic> getScheduleStatus({required program_schedule_model.Datum data}) {
    final isFull = (data.totalCapacity ?? 0) < (data.totalRegister ?? 0);
    final userStatus = data.user?.status;
    final participantsMessage = isFull
        ? StringConstants.theHourIsFullOnTheWaitingList.replaceAll(
            "{}",
            "${data.totalInWaiting ?? 0}",
          )
        : StringConstants.participantsData.replaceAll(
            "{}",
            "${data.totalCapacity}/${data.totalRegister}",
          );

    String showMessage;
    if (userStatus == "registered") {
      showMessage = StringConstants.cancelRegistration;
    } else if (userStatus == "waiting") {
      showMessage = StringConstants.exitFromWaitingList;
    } else {
      showMessage = StringConstants.registration;
    }

    return {
      "show_message": showMessage,
      "status": userStatus,
      "participants_message": participantsMessage,
    };
  }
}
