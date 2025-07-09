import 'package:get/get.dart';
import 'package:revalesuva/model/my_plan/tasks/task_model.dart' as task_model;
import 'package:revalesuva/model/my_plan/tasks/user_task_model.dart' as user_task_model;
import 'package:revalesuva/repository/repository.dart';
import 'package:revalesuva/services/api_status.dart';
import 'package:revalesuva/utils/helper_method.dart';

class PuzzleViewModel extends GetxController {
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
  }
}
