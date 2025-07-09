import 'dart:convert';

import 'package:get/get.dart';
import 'package:revalesuva/components/custom_image_picker.dart';
import 'package:revalesuva/model/empty_model/empty_model.dart';
import 'package:revalesuva/model/login/login_model.dart' as login_model;
import 'package:revalesuva/model/my_plan/plans/user_plan_model.dart' as user_plan_model;
import 'package:revalesuva/model/personal_detail/after_before_image_model.dart'
    as after_before_image_model;
import 'package:revalesuva/model/personal_detail/set_user_model.dart' as set_user;
import 'package:revalesuva/model/personal_detail/user_model.dart' as user_model;
import 'package:revalesuva/model/store/store_model.dart' as store_model;
import 'package:revalesuva/repository/repository.dart';
import 'package:revalesuva/services/api_status.dart';
import 'package:revalesuva/utils/helper_method.dart';
import 'package:revalesuva/utils/local_storage.dart';
import 'package:revalesuva/utils/router.dart';

class UserViewModel extends GetxController {
  var userProfilePath = "".obs;
  var authToken = "".obs;
  var childActiveScreenName = "".obs;
  var userRole = "".obs;
  var userData = user_model.Data().obs;
  var userPlanDetail = user_plan_model.Datum().obs;
  var listUserStoreProductFavourite = <store_model.Datum>[].obs;

  var userBeforeBackPicURL = "".obs;
  var userBeforeSidePicURL = "".obs;
  var userBeforeFrontPicURL = "".obs;

  var userAfterBackPicURL = "".obs;
  var userAfterSidePicURL = "".obs;
  var userAfterFrontPicURL = "".obs;
  var gender = "".obs;

  var isVegetablesChallenge = false.obs;
  var vegetablesChallenge = "".obs;
  var isMeasurement = false.obs;
  var measurement = "".obs;
  var measurementDate = "".obs;
  var isWeightModule = false.obs;
  var weightModuleDate = "".obs;
  var weightModule = "".obs;
  var isFastingModule = false.obs;
  var fastingModule = "".obs;
  var isOvulationModule = false.obs;
  var ovulationModule = "".obs;
  var isDailyReport = false.obs;
  var dailyReportModule = "".obs;
  var isWeeklyReport = false.obs;
  var weeklyReportModule = "".obs;
  var isLessonSummary = false.obs;
  var lessonSummaryModule = "".obs;
  var isShowDailyNutrition = false.obs;

  // var isShowFasting = false.obs;
  // var isShowOvulation = false.obs;
  // var isShowDailyNutrition = false.obs;
  // var isShowDailyReport = false.obs;
  // var isShowWeeklyReport = false.obs;
  // var isShowWeightAndMeasurements = false.obs;
  // var isShowLesson = false.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    authToken.value = LocalStorage.instance.getAuthToken();
    var localUserData = LocalStorage.instance.getUserData();
    if (localUserData.isNotEmpty) {
      userData.value = user_model.Data.fromJson(jsonDecode(localUserData));
      gender.value = userData.value.gender ?? "";
      await getActivePlan();
    }
  }

  // onCreate() async {
  //   authToken.value = LocalStorage.instance.getAuthToken();
  //   var localUserData = LocalStorage.instance.getUserData();
  //   if (localUserData.isNotEmpty) {
  //     userData.value = user_model.Data.fromJson(jsonDecode(localUserData));
  //     gender.value = userData.value.gender ?? "";
  //     await getActivePlan();
  //   }
  // }

  updateUserProfile() async {
    userProfilePath.value = await CustomImagePicker.pickFromBoth();
    if (userProfilePath.value.isNotEmpty) {
      showLoader();
      set_user.SetUserModel setUserModel = set_user.SetUserModel(
        profileImage: userProfilePath.value,
      );
      var response = await Repository.instance.updateUserApi(userData: setUserModel);
      hideLoader();
      if (response is Success) {
        if (response.code == 200) {
          var result = user_model.userModelFromJson(response.response.toString());
          await Get.find<UserViewModel>().getUserDetail(isShowLoader: true);
        }
      } else if (response is Failure) {
        showToast(msg: "${response.errorResponse ?? ""}");
      }
    }
  }

  setUserAuth({required login_model.Data loginData}) async {
    await LocalStorage.instance.setAuthToken(loginData.token);
    await LocalStorage.instance.setIsUserPlan(loginData.isSubscribedToPlan);
    await LocalStorage.instance.setIsUserProgram(loginData.isSubscribedToProgram);
    await LocalStorage.instance.setUserRole(loginData.role);
    userRole.value = loginData.role ?? "";
    authToken.value = loginData.token ?? "";
  }

  setUserData({required user_model.Data? userDetail}) async {
    if (userDetail != null) {
      var user = jsonEncode(userDetail.toJson());
      await LocalStorage.instance.setUserData(user);
      onInit();
    }
  }

  getUserDetail({bool isShowLoader = true}) async {
    userRole.value = LocalStorage.instance.getUserRole();
    if (isShowLoader) {
      showLoader();
    }
    var response = await Repository.instance.getUserApi();
    if (isShowLoader) {
      hideLoader();
    }
    if (response is Success) {
      if (response.code == 200) {
        var result = user_model.userModelFromJson(response.response.toString());
        await setUserData(userDetail: result.data);

        onInit();
      }
    } else if (response is Failure) {
      showToast(msg: "${response.errorResponse ?? ""}");
    }
  }

  logoutUser() async {
    showLoader();
    var response = await Repository.instance.userLogout();
    hideLoader();
    if (response is Success) {
      if (response.code == 200) {
        var result = emptyModelFromJson(response.response.toString());
        showToast(msg: result.message ?? "");
        clearUser();
        Get.offAllNamed(RoutesName.login);
      }
    } else if (response is Failure) {
      showToast(msg: "${response.errorResponse ?? ""}");
      clearUser();
    }
  }

  clearUser() {
    userProfilePath.value = "";
    authToken.value = "";
    childActiveScreenName.value = "";
    LocalStorage.instance.clearData();
    userData.value = user_model.Data();
    gender.value = "";
  }

  redirection() {
    if (authToken.isEmpty) {
      Get.offAllNamed(RoutesName.login);
    } else if (userRole.value == "trainer") {
      Get.offAllNamed(RoutesName.trainerHome);
    } else if ((userData.value.name?.isNotEmpty ?? false) &&
        (userData.value.email?.isNotEmpty ?? false) &&
        (userData.value.contactNumber?.isNotEmpty ?? false) &&
        (userData.value.dateOfBirth?.isNotEmpty ?? false) &&
        (userData.value.gender?.isNotEmpty ?? false)) {
      Get.offAllNamed(RoutesName.home);
    } else {
      Get.offAllNamed(RoutesName.personalDetail);
    }
  }

  getUserPictures() async {
    var response = await Repository.instance.getUserAfterBeforePhotosApi();

    if (response is Success) {
      var result = after_before_image_model.afterBeforeImageModelFromJson(response.response.toString());
      userBeforeBackPicURL.value = result.data?.beforePhoto?.backPic ?? "";
      userBeforeSidePicURL.value = result.data?.beforePhoto?.sidePic ?? "";
      userBeforeFrontPicURL.value = result.data?.beforePhoto?.frontPic ?? "";

      userAfterBackPicURL.value = result.data?.afterPhoto?.backPic ?? "";
      userAfterSidePicURL.value = result.data?.afterPhoto?.sidePic ?? "";
      userAfterFrontPicURL.value = result.data?.afterPhoto?.frontPic ?? "";
    } else if (response is Failure) {
      showToast(msg: "${response.errorResponse ?? ""}");
    }
  }

  Future<void> getActivePlan() async {
    var response = await Repository.instance.getUserPlanApiByStatus(status: "active");
    if (response is Success) {
      var result = user_plan_model.userPlanModelFromJson(response.response.toString());
      userPlanDetail.value = result.data?.first ?? user_plan_model.Datum();

      if (userPlanDetail.value.id != null &&
          (userPlanDetail.value.plan?.planCycles?.isNotEmpty ?? false)) {
        DateTime? startDate = userPlanDetail.value.plan?.planCycles?.first.startDate;
        String weekDay = userPlanDetail.value.plan?.weekDays ?? "";
        String activeDay = userPlanDetail.value.plan?.activeDay ?? "";

        if (startDate != null) {
          // Assign module day values or default to "-1" if not available.
          vegetablesChallenge.value =
              userPlanDetail.value.plan?.settings?.vegetablesChallenge?.day ?? "-1";
          measurement.value = userPlanDetail.value.plan?.settings?.measurement?.day ?? "-1";
          weightModule.value = userPlanDetail.value.plan?.settings?.weightModule?.day ?? "-1";
          fastingModule.value = userPlanDetail.value.plan?.settings?.fastingModule?.day ?? "-1";
          ovulationModule.value = userPlanDetail.value.plan?.settings?.periodModule?.day ?? "-1";
          weeklyReportModule.value = userPlanDetail.value.plan?.settings?.weightModule?.day ?? "-1";
          dailyReportModule.value = userPlanDetail.value.plan?.settings?.dailyReport?.day ?? "-1";
          lessonSummaryModule.value = userPlanDetail.value.plan?.settings?.lessonSummary?.day ?? "-1";

          // Helper to update module status based on the module day.
          bool updateModuleStatus(String moduleDay) {
            if (moduleDay == "-1") return false;

            return checkIsAvailableOrNot(startDate, int.parse(moduleDay), weekDay, activeDay);
          }

          isVegetablesChallenge.value = updateModuleStatus(vegetablesChallenge.value);
          isMeasurement.value = updateModuleStatus(measurement.value);
          isWeightModule.value = updateModuleStatus(weightModule.value);
          isFastingModule.value = updateModuleStatus(fastingModule.value);
          isOvulationModule.value = updateModuleStatus(ovulationModule.value);
          isDailyReport.value = updateModuleStatus(dailyReportModule.value);
          isLessonSummary.value = updateModuleStatus(lessonSummaryModule.value);

          bool updateWeeklyReport(String moduleDay) {
            if (moduleDay == "-1") return false;

            var isCurrentDayAndAfter = DateTime.now().isAfter(startDate.add(Duration(days: int.parse(moduleDay))));

            var checkWeekly = weekDay.contains(activeDay) || activeDay == "saturday";
            return isCurrentDayAndAfter && checkWeekly;
          }

          isWeeklyReport.value = updateWeeklyReport(weeklyReportModule.value);
          measurementDate.value = startDate.add(Duration(days: int.parse(measurement.value))).toString();
          weightModuleDate.value =
              startDate.add(Duration(days: int.parse(weightModule.value))).toString();
        }
        isShowDailyNutrition.value = true;
      } else {
        isVegetablesChallenge.value = false;
        isMeasurement.value = false;
        isWeightModule.value = false;
        isFastingModule.value = false;
        isOvulationModule.value = false;
        isWeeklyReport.value = false;
        isDailyReport.value = false;
        isLessonSummary.value = false;
        isShowDailyNutrition.value = false;
      }
    } else if (response is Failure) {
      userPlanDetail.value = user_plan_model.Datum();
      if (response.code != 404) {
        showToast(msg: "${response.errorResponse ?? ""}");
      }
    }
  }

  bool checkIsAvailableOrNot(DateTime date, int day, String weekDay, String activeDay) {
    var isCurrentDayAndAfter = DateTime.now().isAfter(date.add(Duration(days: day)));
    return isCurrentDayAndAfter && weekDay.contains(activeDay);
  }
}
