import 'dart:async';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:revalesuva/components/custom_dialog.dart';
import 'package:revalesuva/model/empty_model/empty_model.dart';
import 'package:revalesuva/model/personal_detail/set_user_model.dart' as set_user;
import 'package:revalesuva/model/personal_detail/user_model.dart' as user_model;
import 'package:revalesuva/repository/repository.dart';
import 'package:revalesuva/services/api_status.dart';
import 'package:revalesuva/utils/helper_method.dart';
import 'package:revalesuva/utils/localization.dart';
import 'package:revalesuva/utils/strings_constant.dart';
import 'package:revalesuva/view_models/user_view_model.dart';

class PersonalProfileViewModel extends GetxController {
  var isGeneralInfoEditable = false.obs;
  var isAuthInfoEditable = false.obs;
  var isBodyInfoEditable = false.obs;
  var isMedicalQuestionEditable = false.obs;
  var userData = Get.find<UserViewModel>().userData;

  var txtName = TextEditingController().obs;
  var txtEmail = TextEditingController().obs;
  var txtUserName = TextEditingController().obs;
  var txtPhoneNo = TextEditingController().obs;
  var txtStreet = TextEditingController().obs;
  var txtHouse = TextEditingController().obs;
  var txtApartment = TextEditingController().obs;
  var txtPostalCode = TextEditingController().obs;
  var txtCity = "".obs;
  var txtOccupation = TextEditingController().obs;
  var imgBackPath = "".obs;
  var imgSidePath = "".obs;
  var imgFrontPath = "".obs;

  var txtWeight = TextEditingController().obs;
  var txtHeight = TextEditingController().obs;
  var txtChest = TextEditingController().obs;
  var txtWaist = TextEditingController().obs;
  var txtHip = TextEditingController().obs;
  var txtDateOfBirth = TextEditingController().obs;
  var txtGender = "".obs;

  var selectBloodFiles = <String>[].obs;
  var uploadBloodTests = "".obs;

  var txOldPassword = TextEditingController().obs;
  var txNewPassword = TextEditingController().obs;
  var isShowPasswordChangesMeg = false.obs;
  var isLoading = false.obs;

  var listBloodTest = <user_model.BloodTest>[].obs;

  @override
  void onInit() {
    super.onInit();
    onCreate();
  }

  getCustomerDetailById() async {

    await Get.find<UserViewModel>().getUserDetail(isShowLoader: false);
    userData = Get.find<UserViewModel>().userData;
    listBloodTest.assignAll(userData.value.bloodTests?.reversed ?? []);
  }

  onCreate() {
    txtName.value.text = userData.value.name ?? "";
    txtEmail.value.text = userData.value.email ?? "";
    txtUserName.value.text = userData.value.userName ?? "";
    txtPhoneNo.value.text = userData.value.contactNumber ?? "";
    txtStreet.value.text = userData.value.street ?? "";
    txtHouse.value.text = userData.value.house ?? "";
    txtApartment.value.text = userData.value.apartment ?? "";
    txtPostalCode.value.text = userData.value.zipcode ?? "";
    txtCity.value = userData.value.city ?? "";
    txtOccupation.value.text = userData.value.occupation ?? "";

    try {
      txtWeight.value.text = userData.value.weights?.last.weight ?? "";
    } catch (e) {
      txtWeight.value.text = userData.value.initialWeight ?? "";
    }
    txtHeight.value.text = userData.value.height ?? "";

    if (userData.value.circumferences?.isNotEmpty ?? false) {
      txtChest.value.text = userData.value.circumferences?.last.chest ?? "";
      txtWaist.value.text = userData.value.circumferences?.last.waist ?? "";
      txtHip.value.text = userData.value.circumferences?.last.hip ?? "";
    } else {
      txtChest.value.text = "";
      txtWaist.value.text = "";
      txtHip.value.text = "";
    }

    txtDateOfBirth.value.text = userData.value.dateOfBirth ?? "";

    var beforePicture = userData.value.pictures?.firstWhereOrNull(
      (element) => element.pictureType == "before",
    );

    imgBackPath.value = beforePicture?.backPic ?? "";
    imgSidePath.value = beforePicture?.sidePic ?? "";
    imgFrontPath.value = beforePicture?.frontPic ?? "";

    if ((userData.value.gender?.toLowerCase() == "male")) {
      txtGender.value = StringConstants.male;
    } else if ((userData.value.gender?.toLowerCase() == "female")) {
      txtGender.value = StringConstants.female;
    } else {
      txtGender.value = userData.value.gender ?? "";
    }
  }

  updateGeneralInfo() async {
    showLoader();
    set_user.SetUserModel setUserModel = set_user.SetUserModel(
      name: txtName.value.text.isNotEmpty ? txtName.value.text : null,
      userName: txtUserName.value.text.isNotEmpty ? txtUserName.value.text : null,
      contactNumber: txtPhoneNo.value.text.isNotEmpty ? txtPhoneNo.value.text : null,
      street: txtStreet.value.text.isNotEmpty ? txtStreet.value.text : null,
      house: txtHouse.value.text.isNotEmpty ? txtHouse.value.text : null,
      apartment: txtApartment.value.text.isNotEmpty ? txtApartment.value.text : null,
      city: txtCity.value.isNotEmpty ? txtCity.value : null,
      dateOfBirth: txtDateOfBirth.value.text.isNotEmpty ? txtDateOfBirth.value.text : null,
      gender:
          (txtGender.value.isNotEmpty ? txtGender.value : null)?.translateValue("en_US").toLowerCase(),
    );
    var response = await Repository.instance.updateUserApi(userData: setUserModel);
    hideLoader();
    if (response is Success) {
      if (response.code == 200) {
        var result = user_model.userModelFromJson(response.response.toString());
        await Get.find<UserViewModel>().setUserData(userDetail: result.data);
        showToast(msg: result.message ?? "");
        await Get.find<UserViewModel>().getUserDetail(isShowLoader: true);
        isGeneralInfoEditable.value = false;
      }
    } else if (response is Failure) {
      showToast(msg: "${response.errorResponse ?? ""}");
    }
  }

  changePassword() async {
    showLoader();
    var response = await Repository.instance.changePassword(
      newPassword: txNewPassword.value.text,
      oldPassword: txOldPassword.value.text,
    );
    hideLoader();
    if (response is Success) {
      var result = emptyModelFromJson(response.response.toString());
      showToast(msg: result.message ?? "");
      isAuthInfoEditable.value = false;
      isShowPasswordChangesMeg.value = true;
    } else if (response is Failure) {
      showToast(msg: "${response.errorResponse ?? ""}");
    }
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
          uploadBloodTests.value = "${selectBloodFiles.length} is Document selected";
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

  updateBodyDetailInfo() async {
    showLoader();
    set_user.SetUserModel setUserModel = set_user.SetUserModel(
      initialWeight: txtWeight.value.text.isNotEmpty ? txtWeight.value.text : null,
      height: txtHeight.value.text.isNotEmpty ? txtHeight.value.text : null,
      chest: txtChest.value.text.isNotEmpty ? txtChest.value.text : null,
      waist: txtWaist.value.text.isNotEmpty ? txtWaist.value.text : null,
      hip: txtHip.value.text.isNotEmpty ? txtHip.value.text : null,
      bloodTestReport: selectBloodFiles.isNotEmpty ? selectBloodFiles : null,
    );
    var response = await Repository.instance.updateUserApi(userData: setUserModel);
    hideLoader();
    if (response is Success) {
      if (response.code == 200) {
        var result = user_model.userModelFromJson(response.response.toString());
        await Get.find<UserViewModel>().setUserData(userDetail: result.data);
        showToast(msg: result.message ?? "");
        await Get.find<UserViewModel>().getUserDetail(isShowLoader: true);
        isBodyInfoEditable.value = false;
      }
    } else if (response is Failure) {
      showToast(msg: "${response.errorResponse ?? ""}");
    }
  }
}
