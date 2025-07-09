import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:revalesuva/components/custom_dialog.dart';
import 'package:revalesuva/model/personal_detail/set_user_model.dart' as set_user;
import 'package:revalesuva/model/personal_detail/user_model.dart' as user_model;
import 'package:revalesuva/repository/repository.dart';
import 'package:revalesuva/services/api_status.dart';
import 'package:revalesuva/utils/helper_method.dart';
import 'package:revalesuva/utils/router.dart';
import 'package:revalesuva/utils/strings_constant.dart';
import 'package:revalesuva/view_models/user_view_model.dart';

class PersonalDetailsViewModel extends GetxController {
  var activePersonalDetailScreenId = 1.obs;
  var currentQuestion = 0.obs;
  var userData = Get.find<UserViewModel>().userData;
  var userPlanDetail = Get.find<UserViewModel>().userPlanDetail.value;

  //main detail
  var txtName = TextEditingController(text: Get.find<UserViewModel>().userData.value.name ?? "");
  var txtPhoneNo =
      TextEditingController(text: Get.find<UserViewModel>().userData.value.contactNumber ?? "");
  var txtUserName = TextEditingController(text: Get.find<UserViewModel>().userData.value.userName ?? "");

  //general detail
  var txtStreet = TextEditingController();
  var txtHouse = TextEditingController();
  var txtApartment = TextEditingController();
  var txtZipCode = TextEditingController();
  var txtOccupation = TextEditingController();
  var txtDateOfBirth = TextEditingController();

  var txtCity = "".obs;
  var txtPersonalStatus = "".obs;
  var txtGender = "".obs;

  //Third form
  var txtInitialWeight = TextEditingController();
  var txtHeight = TextEditingController();
  var txtUploadBloodTests = TextEditingController();
  var selectBloodFiles = <String>[].obs;
  var txtChestCircumference = TextEditingController();
  var txtWaistCircumference = TextEditingController();
  var txtHipCircumference = TextEditingController();
  var imgBackPath = "".obs;
  var imgSidePath = "".obs;
  var imgFrontPath = "".obs;

  @override
  void onInit() {
    debugPrint("onInit");
    txtName.text = userData.value.name ?? "";
    txtPhoneNo.text = userData.value.contactNumber ?? "";
    txtUserName.text = userData.value.userName ?? "";
    txtStreet.text = userData.value.street ?? "";
    txtHouse.text = userData.value.house ?? "";
    txtApartment.text = userData.value.apartment ?? "";
    txtZipCode.text = userData.value.zipcode ?? "";
    txtOccupation.text = userData.value.occupation ?? "";
    txtDateOfBirth.text = userData.value.dateOfBirth ?? "";
    txtCity.value = userData.value.city ?? "";
    txtPersonalStatus.value = userData.value.personalStatus ?? "";
    if ((userData.value.gender?.toLowerCase() == "male")) {
      txtGender.value = StringConstants.male;
    } else if ((userData.value.gender?.toLowerCase() == "female")) {
      txtGender.value = StringConstants.female;
    } else {
      txtGender.value = userData.value.gender ?? "";
    }

    super.onInit();
  }

  @override
  void onReady() {
    debugPrint("onReady");
    super.onReady();
  }

  @override
  void onClose() {
    debugPrint("onClose");
    super.onClose();
  }

  @override
  void dispose() {
    debugPrint("dispose");
    super.dispose();
  }

  Future<void> selectBloodReport() async {
    selectBloodFiles.clear();
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: true,
        type: FileType.custom,
        allowedExtensions: ['pdf', 'jpg', 'jpeg', 'png'],
      );

      if (result != null) {
        List<File> files = result.paths.map((path) => File(path!)).toList();
        for (var file in files) {
          selectBloodFiles.add(file.path);
        }
        selectBloodFiles.refresh();
        if (selectBloodFiles.isNotEmpty) {
          txtUploadBloodTests.text = "${selectBloodFiles.length} is Document selected";
        }
      }
    } on PlatformException catch (_) {
      CustomDialog.positiveNegativeButtons(
        title: "Permission is denied, you want to redirect app permission",
        onNegativePressed: () {
          if (Get.isDialogOpen ?? false) {
            Get.back();
          }
          openAppSettings();
        },
        onPositivePressed: () {
          if (Get.isDialogOpen ?? false) {
            Get.back();
          }
        },
      );
    }
  }

  selectProfileImage() {
    Get.find<UserViewModel>().updateUserProfile();
  }

  checkUserName() async {
    if (userData.value.userName?.isEmpty ?? false) {
      showLoader();
      var response = await Repository.instance.checkUsernameApi(
        username: txtUserName.text,
      );
      hideLoader();
      if (response is Success) {
        if (response.code == 200) {
          // username_model.checkUsernameModelFromJson(response.response.toString());
          onNextStepClick();
        }
      } else if (response is Failure) {
        showToast(msg: "${response.errorResponse ?? ""}");
      }
    } else {
      onNextStepClick();
    }
  }

  updateUserData() async {
    showLoader();
    set_user.SetUserModel setUserModel = set_user.SetUserModel(
      name: txtName.text.isNotEmpty ? txtName.text : null,
      userName: txtUserName.text.isNotEmpty ? txtUserName.text : null,
      contactNumber: txtPhoneNo.text.isNotEmpty ? txtPhoneNo.text : null,
      dateOfBirth: txtDateOfBirth.text.isNotEmpty ? txtDateOfBirth.text : null,
      height: txtHeight.text.isNotEmpty ? txtHeight.text : null,
      initialWeight: txtInitialWeight.text.isNotEmpty ? txtInitialWeight.text : null,
      gender: txtGender.value == StringConstants.male ? "Male" : "Female",
      street: txtStreet.text.isNotEmpty ? txtStreet.text : null,
      house: txtHouse.text.isNotEmpty ? txtHouse.text : null,
      apartment: txtApartment.text.isNotEmpty ? txtApartment.text : null,
      zipcode: txtZipCode.text.isNotEmpty ? txtZipCode.text : null,
      city: txtCity.value.isNotEmpty ? txtCity.value : null,
      personalStatus: txtPersonalStatus.value.isNotEmpty ? txtPersonalStatus.value : null,
      occupation: txtOccupation.text.isNotEmpty ? txtOccupation.text : null,
      chest: txtChestCircumference.text.isNotEmpty ? txtChestCircumference.text : null,
      waist: txtWaistCircumference.text.isNotEmpty ? txtWaistCircumference.text : null,
      hip: txtHipCircumference.text.isNotEmpty ? txtHipCircumference.text : null,
      backPic: imgBackPath.value.isNotEmpty ? imgBackPath.value : null,
      sidePic: imgSidePath.value.isNotEmpty ? imgSidePath.value : null,
      frontPic: imgFrontPath.value.isNotEmpty ? imgFrontPath.value : null,
      bloodTestReport: selectBloodFiles.isNotEmpty ? selectBloodFiles : null,
    );
    var response = await Repository.instance.updateUserApi(userData: setUserModel);
    hideLoader();
    if (response is Success) {
      if (response.code == 200) {
        var result = user_model.userModelFromJson(response.response.toString());
        await Get.find<UserViewModel>().setUserData(userDetail: result.data);
        showToast(msg: result.message ?? "");
        onNextStepClick();
      }
    } else if (response is Failure) {
      showToast(msg: "${response.errorResponse ?? ""}");
    }
  }

  onNextStepClick() async {
    if (userPlanDetail.id != null) {
      if (activePersonalDetailScreenId.value < 4) {
        activePersonalDetailScreenId.value++;
      } else {
        Get.toNamed(RoutesName.videoTutorial);
      }
    } else {
      if (activePersonalDetailScreenId.value < 2) {
        activePersonalDetailScreenId.value++;
      } else {
        Get.toNamed(RoutesName.videoTutorial);
      }
    }
  }

  onPreviousStepClick() {
    activePersonalDetailScreenId.value--;
  }

  onNextQuestion() {
    currentQuestion.value++;
  }

  onPreviousQuestion() {
    currentQuestion.value--;
  }
}
