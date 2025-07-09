import 'package:get/get.dart';
import 'package:revalesuva/model/my_plan/tasks/task_model.dart' as task_model;
import 'package:revalesuva/model/trainer/task/customer_task_model.dart' as customer_task_model;
import 'package:revalesuva/repository/repository.dart';
import 'package:revalesuva/services/api_status.dart';
import 'package:revalesuva/utils/helper_method.dart';

class TrainerTaskViewModel extends GetxController {
  var isLoading = false.obs;
  var listCustomerTask = <customer_task_model.Datum>[].obs;
  var listAllTask = <task_model.Datum>[].obs;

  getAllTask({String? lessonId, String? planId}) async {
    var response = await Repository.instance.getTaskByIdApi(
      lessonId: lessonId,
      planId: planId,
    );
    if (response is Success) {
      var result = task_model.taskModelFromJson(response.response.toString());
      listAllTask.assignAll(result.data ?? []);
    } else if (response is Failure) {
      if (response.code != 404) {
        showToast(msg: "${response.errorResponse ?? ""}");
      }
    }
  }

  getCustomerTaskList({required String planId, required String customerId}) async {
    var response = await Repository.instance.getCustomerTask(
      planId: planId.toString(),
      customerId: customerId,
    );
    if (response is Success) {
      var result = customer_task_model.customerTaskModelFromJson(response.response.toString());
      listCustomerTask.assignAll(result.data ?? []);
    } else if (response is Failure) {
      showToast(msg: "${response.errorResponse ?? ""}");
    }
  }
}
