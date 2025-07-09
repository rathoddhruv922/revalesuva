import 'package:get/get.dart';
import 'package:revalesuva/model/my_plan/libraries/content_libraries_model.dart'
    as content_libraries_model;
import 'package:revalesuva/model/my_plan/plans/user_plan_model.dart' as user_plan_model;
import 'package:revalesuva/model/my_plan/tasks/task_model.dart' as task_model;
import 'package:revalesuva/model/my_plan/tasks/user_task_model.dart' as user_task_model;
import 'package:revalesuva/model/my_plan/program/user_program_model.dart' as user_program_model;
import 'package:revalesuva/repository/repository.dart';
import 'package:revalesuva/services/api_status.dart';
import 'package:revalesuva/utils/helper_method.dart';

class MyPlanViewModel extends GetxController {
  var userPlanDetail = user_plan_model.Datum().obs;
  var userContinuationProgramsDetail = user_plan_model.Datum().obs;
  var listUserCompletedPlan = <user_plan_model.Datum>[].obs;
  var listTask = <task_model.Datum>[].obs;
  var listUserTask = <user_task_model.Datum>[].obs;
  var listTaskTotal = 0.obs;
  var listUserTaskTotal = 0.obs;
  var isLoading = false.obs;

  var listContentLibraries = <content_libraries_model.Datum>[].obs;
  var listActiveProgram = <user_program_model.Datum>[].obs;

  getActivePlan() async {
    var response = await Repository.instance.getUserPlanApiByStatus(
      status: "active",
    );
    if (response is Success) {
      var result = user_plan_model.userPlanModelFromJson(response.response.toString());
      userPlanDetail.value = result.data?.first ?? user_plan_model.Datum();
    } else if (response is Failure) {
      userPlanDetail.value = user_plan_model.Datum();
      if (response.code != 404) {
        showToast(msg: "${response.errorResponse ?? ""}");
      }
    }
  }

  getContinuationPlan() async {
    var response = await Repository.instance.getUserPlanApiByStatus(
      status: "inprogress",
    );
    if (response is Success) {
      var result = user_plan_model.userPlanModelFromJson(response.response.toString());
      userContinuationProgramsDetail.value = result.data?.first ?? user_plan_model.Datum();
    } else if (response is Failure) {
      if (response.code != 404) {
        userContinuationProgramsDetail.value = user_plan_model.Datum();
        showToast(msg: "${response.errorResponse ?? ""}");
      }
    }
  }

  getCompletedPlan() async {
    var response = await Repository.instance.getUserPlanApiByStatus(
      status: "completed",
    );
    if (response is Success) {
      var result = user_plan_model.userPlanModelFromJson(response.response.toString());
      listUserCompletedPlan.assignAll(result.data ?? []);
    } else if (response is Failure) {
      listUserCompletedPlan.clear();
      if (response.code != 404) {
        showToast(msg: "${response.errorResponse ?? ""}");
      }
    }
  }

  getUserTaskByPlan({required String planId}) async {
    var response = await Repository.instance.getUserTaskByIdApi(planId: planId);
    if (response is Success) {
      var result = user_task_model.userTaskModelFromJson(response.response.toString());
      listUserTask.assignAll(result.data ?? []);
    } else if (response is Failure) {
      listUserTask.clear();
      if (response.code != 404) {
        showToast(msg: "${response.errorResponse ?? ""}");
      }
    }
    listUserTaskTotal.value = listUserTask.length;
  }

  getTaskByPlan({required String planId}) async {
    var response = await Repository.instance.getTaskByIdApi(planId: planId);
    if (response is Success) {
      var result = task_model.taskModelFromJson(response.response.toString());
      listTask.assignAll(result.data ?? []);
    } else if (response is Failure) {
      listTask.clear();
      if (response.code != 404) {
        showToast(msg: "${response.errorResponse ?? ""}");
      }
    }
    listTaskTotal.value = listTask.length;
  }

  getContentLibrariesByPlan({required String planId}) async {
    var response = await Repository.instance.getContentLibrariesByPlan(
      perPage: "1",
      page: "1",
      planId: planId,
    );

    if (response is Success) {
      var result = content_libraries_model.contentLibrariesModelFromJson(response.response.toString());
      listContentLibraries.assignAll(result.data?.data ?? []);
    } else if (response is Failure) {
      listContentLibraries.clear();
    }
  }

  getUserActiveProgram() async {
    var response = await Repository.instance.getUserProgram();
    if (response is Success) {
      var result = user_program_model.userProgramModelFromJson(response.response.toString());
      listActiveProgram.assignAll(result.data ?? []);
    } else if (response is Failure) {
      listActiveProgram.clear();
    }
  }
}
