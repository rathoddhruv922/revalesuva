import 'package:get/get.dart';
import 'package:revalesuva/model/empty_model/empty_model.dart';
import 'package:revalesuva/model/my_plan/lessons/lessons_model.dart' as lessons_model;
import 'package:revalesuva/model/my_plan/lessons/local_video_player_model.dart';
import 'package:revalesuva/model/my_plan/tasks/task_model.dart' as task_model;
import 'package:revalesuva/model/my_plan/tasks/user_task_model.dart' as user_task_model;
import 'package:revalesuva/repository/repository.dart';
import 'package:revalesuva/services/api_status.dart';
import 'package:revalesuva/utils/helper_method.dart';
import 'package:revalesuva/utils/local_lessons_video_helper.dart';

class LessonsViewModel extends GetxController {
  var listLessons = <lessons_model.Datum>[].obs;
  var listTask = <task_model.Datum>[].obs;
  var lisUserTask = <user_task_model.Datum>[].obs;
  var totalLessons = 0.obs;
  var viewLessons = 0.obs;
  var isLoading = false.obs;
  var isShowProgramCompletionReport = false.obs;

  getLessonsByPlanId({required String planId}) async {
    isLoading.value = true;
    var response = await Repository.instance.getLessonByPlanIdApi(
      planId: planId,
      page: "1",
      perPage: "10"
    );
    isLoading.value = false;
    if (response is Success) {
      var result = lessons_model.lessonsModelFromJson(response.response.toString());
      listLessons.assignAll(result.data ?? []);

      totalLessons.value = listLessons.length;
      viewLessons.value = listLessons.where((element) => element.userLessons != null).toList().length;
      isShowProgramCompletionReport.value = !(listLessons.any(
            (element) => (element.userLessons?.watchStatus?.isEmpty ?? true) || (element.userLessons?.watchStatus ?? "pending") == "pending",
      ));
    } else if (response is Failure) {
      if (response.code != 404) {
        showToast(msg: "${response.errorResponse ?? ""}");
      }
    }
  }

  getTaskByLessonId({String? lessonId, String? planId}) async {
    var response = await Repository.instance.getTaskByIdApi(
      lessonId: lessonId,
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
  }

  getUserTaskByLessonId({String? lessonId, String? planId}) async {
    var response = await Repository.instance.getUserTaskByIdApi(
      lessonId: lessonId,
      planId: planId,
    );
    if (response is Success) {
      var result = user_task_model.userTaskModelFromJson(response.response.toString());
      lisUserTask.assignAll(result.data ?? []);
    } else if (response is Failure) {
      lisUserTask.clear();
      if (response.code != 404) {
        showToast(msg: "${response.errorResponse ?? ""}");
      }
    }
  }

  List<LocalVideoPlayerModel> getVideoInfoFromLocalStorage() {
    return LocalLessonsVideoHelper.instance.getAllProducts();
  }

  LocalVideoPlayerModel? getVideoById({required int index}) {
    return LocalLessonsVideoHelper.instance.getProductsByIndex(index: index);
  }

  addVideoInfoInLocalStorage({
    required lessons_model.Datum data,
    required String playedLength,
    required String totalLength,
  }) async {
    await LocalLessonsVideoHelper.instance.addProduct(
      LocalVideoPlayerModel(
        id: "${data.id ?? ""}",
        status: data.userLessons?.watchStatus ?? "",
        playedLength: playedLength,
        totalLength: totalLength,
        videoUrl: data.video,
      ),
    );
  }

  updateVideoInfoInLocalStorage({
    required int index,
    required String playedLength,
    required String totalLength,
    required String status,
  }) async {
    await LocalLessonsVideoHelper.instance.updateQty(
      index: index,
      playedLength: playedLength,
      totalLength: totalLength,
    );
  }

  createUserLessonByLessonId({required String lessonId}) async {
    var response = await Repository.instance.createUserLessonByLessonId(
      lessonId: lessonId,
    );
    if (response is Success) {
      var result = emptyModelFromJson(response.response.toString());
      return true;
    } else if (response is Failure) {
      showToast(msg: "${response.errorResponse ?? ""}");
    }
    return false;
  }

  Future<bool> lessonUpdateWatchStatus({required String lessonId, required String status}) async {
    showLoader();
    var response = await Repository.instance.updateLessonWatchStatusApi(
      lessonId: lessonId,
      watchStatus: status,
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

  Future<bool> deleteUserTask({required String taskId}) async {
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
}
