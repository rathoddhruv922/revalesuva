import 'package:get/get.dart';
import 'package:revalesuva/model/empty_model/empty_model.dart';
import 'package:revalesuva/model/my_plan/tasks/task_model.dart' as task_model;
import 'package:revalesuva/model/my_plan/tasks/user_task_model.dart' as user_task_model;
import 'package:revalesuva/repository/repository.dart';
import 'package:revalesuva/services/api_status.dart';
import 'package:revalesuva/utils/helper_method.dart';

class MyTaskViewModel extends GetxController {
  var isShowAll = true.obs;
  var filterTaskList = <task_model.Datum>[].obs;
  var listTask = <task_model.Datum>[].obs;
  var listUserTask = <user_task_model.Datum>[].obs;
  var userTaskTotal = 0.obs;
  var taskTotal = 0.obs;
  var isLoading = false.obs;

  getTaskByPlanId({String? planId}) async {
    var response = await Repository.instance.getTaskByIdApi(
      planId: planId,
    );
    if (response is Success) {
      var result = task_model.taskModelFromJson(response.response.toString());
      filterTaskList.assignAll(result.data ?? []);
      listTask.assignAll(result.data ?? []);
    } else if (response is Failure) {
      if (response.code != 404) {
        showToast(msg: "${response.errorResponse ?? ""}");
      }
    }
    taskTotal.value = listTask.length;
  }

  getUserTaskByPlanId({required String planId}) async {
    var response = await Repository.instance.getUserTaskByIdApi(
      planId: planId,
    );
    if (response is Success) {
      var result = user_task_model.userTaskModelFromJson(response.response.toString());
      listUserTask.assignAll(result.data ?? []);
    } else if (response is Failure) {
      listUserTask.clear();
      if (response.code != 404) {
        showToast(msg: "${response.errorResponse ?? ""}");
      }
    }
    userTaskTotal.value = listUserTask.length;
    listUserTask.refresh();
  }

  Future<bool> createUserTask({
    required String lessonId,
    required String planId,
    required String taskId,
  }) async {
    showLoader();
    var response = await Repository.instance.createUserTask(
      lessonId: lessonId,
      planId: planId,
      taskId: taskId,
    );
    hideLoader();
    if (response is Success) {
      var result = emptyModelFromJson(response.response.toString());
      return true;
    } else if (response is Failure) {
      showToast(msg: "${response.errorResponse ?? ""}");
    }

    return false;
  }

  Future<bool> deleteUserTask({required String taskId, required String planId}) async {
    showLoader();
    var response = await Repository.instance.deleteUserTask(
      taskId: taskId,
    );
    hideLoader();
    if (response is Success) {
      var result = emptyModelFromJson(response.response.toString());
      return true;
    } else if (response is Failure) {
      showToast(msg: "${response.errorResponse ?? ""}");
    }
    return false;
  }

  filterListTask({required String planId, bool checkValue = true}) async {
    isShowAll.value = checkValue;
    isLoading.value = true;
    filterTaskList.clear();
    await getUserTaskByPlanId(
      planId: planId,
    );
    if (isShowAll.isTrue) {
      filterTaskList.assignAll(listTask);
    } else {
      filterTaskList.assignAll(
        listTask
            .where(
              (task) => !listUserTask.any(
                (userTask) => userTask.task?.id == task.id,
              ),
            )
            .toList(),
      );
    }
    filterTaskList.refresh();
    await Future.delayed(const Duration(seconds: 1));
    isLoading.value = false;
  }
}
