import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:revalesuva/model/personal_detail/set_user_model.dart' as set_user;
import 'package:revalesuva/model/personal_detail/user_model.dart' as user_model;
import 'package:revalesuva/model/trainer/home/customer_model.dart' as customer_model;
import 'package:revalesuva/repository/repository.dart';
import 'package:revalesuva/services/api_status.dart';
import 'package:revalesuva/utils/helper_method.dart';
import 'package:revalesuva/utils/strings_constant.dart';
import 'package:revalesuva/view_models/user_view_model.dart';

class TrainerHomeViewModel extends GetxController {
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

  var txOldPassword = TextEditingController().obs;
  var txNewPassword = TextEditingController().obs;
  var isShowPasswordChangesMeg = false.obs;
  var userData = Get.find<UserViewModel>().userData;
  var txtGender = "".obs;
  var isLoading = false.obs;
  var listCustomers = <customer_model.Datum>[].obs;

  setupUserInfo() async {
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
      contactNumber: txtPhoneNo.value.text.isNotEmpty ? txtPhoneNo.value.text : null,
      street: txtStreet.value.text.isNotEmpty ? txtStreet.value.text : null,
      house: txtHouse.value.text.isNotEmpty ? txtHouse.value.text : null,
      apartment: txtApartment.value.text.isNotEmpty ? txtApartment.value.text : null,
      zipcode: txtPostalCode.value.text.isNotEmpty ? txtPostalCode.value.text : null,
      gender: txtGender.value.isNotEmpty ? txtGender.value : null,
      city: txtCity.value.isNotEmpty ? txtCity.value : null,
      occupation: txtOccupation.value.text.isNotEmpty ? txtOccupation.value.text : null,
      userName: txtUserName.value.text.isNotEmpty ? txtUserName.value.text : null,
    );
    var response = await Repository.instance.updateUserApi(userData: setUserModel);
    hideLoader();
    if (response is Success) {
      if (response.code == 200) {
        var result = user_model.userModelFromJson(response.response.toString());
        await Get.find<UserViewModel>().setUserData(userDetail: result.data);
        showToast(msg: result.message ?? "");
        await Get.find<UserViewModel>().getUserDetail(isShowLoader: true);
        setupUserInfo();
      }
    } else if (response is Failure) {
      showToast(msg: "${response.errorResponse ?? ""}");
    }
  }

  getCustomerByTrainer() async {
    var response = await Repository.instance.getCustomerByTrainer();
    if (response is Success) {
      var result = customer_model.customerModelFromJson(response.response.toString());
      listCustomers.assignAll(result.data ?? []);
    } else {
      showToast(msg: "${response.errorResponse ?? ""}");
    }
  }
}
