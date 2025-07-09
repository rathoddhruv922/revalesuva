import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:revalesuva/model/empty_model/empty_model.dart';
import 'package:revalesuva/repository/repository.dart';
import 'package:revalesuva/services/api_status.dart';
import 'package:revalesuva/utils/helper_method.dart';
import 'package:revalesuva/utils/router.dart';

class ForgotPasswordViewModel extends GetxController {
  var txEmail = TextEditingController();
  var txOtpCode = TextEditingController();
  var txNewPassword = TextEditingController();
  var txConfirmPassword = TextEditingController();
  var isShowPassword = false.obs;
  var isConfirmPassword = false.obs;

  onEyeClick() {
    isShowPassword.value = !isShowPassword.value;
  }

  requestForgotPasswordApi() async {
    showLoader();
    var response = await Repository.instance.forgotPasswordRequestApi(
      email: txEmail.text.trim(),
    );
    hideLoader();
    if (response is Success) {
      if (response.code == 200) {
        var result = emptyModelFromJson(response.response.toString());
        Get.offAllNamed(RoutesName.verifyOtpView);
      }
    } else if (response is Failure) {
      showToast(msg: "${response.errorResponse ?? ""}");
    }
  }

  verifyOtp() async {
    showLoader();
    var response = await Repository.instance.verifyApi(
      email: txEmail.text,
      otp: txOtpCode.text,
    );
    hideLoader();
    if (response is Success) {
      if (response.code == 200) {
        var result = emptyModelFromJson(response.response.toString());
        showToast(msg: result.message ?? "");
        Get.toNamed(RoutesName.resetPasswordView);
      }
    } else if (response is Failure) {
      showToast(msg: "${response.errorResponse ?? ""}");
    }
  }

  resetPasswordApi() async {
    showLoader();
    var response = await Repository.instance.resetPassword(
      email: txEmail.text,
      otp: txOtpCode.text,
      newPassword: txNewPassword.text,
    );
    hideLoader();
    if (response is Success) {
      if (response.code == 200) {
        var result = emptyModelFromJson(response.response.toString());
        showToast(msg: result.message ?? "");
        Get.toNamed(RoutesName.login);
      }
    } else if (response is Failure) {
      showToast(msg: "${response.errorResponse ?? ""}");
    }
  }
}
