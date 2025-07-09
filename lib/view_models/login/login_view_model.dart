import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:revalesuva/model/login/login_model.dart' as login_model;
import 'package:revalesuva/repository/repository.dart';
import 'package:revalesuva/services/api_status.dart';
import 'package:revalesuva/utils/helper_method.dart';
import 'package:revalesuva/view_models/user_view_model.dart';

class LoginViewModel extends GetxController {
  var txEmail = TextEditingController(text: kDebugMode ? "trainer@trainer.com" : "");
  var txPassword = TextEditingController(text: kDebugMode ? "123456" : "");
  var isShowPassword = false.obs;

  @override
  void onInit() {
    debugPrint("onInit");
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

  onLoginClick() async {
    showLoader();

    var response = await Repository.instance.loginApi(
      email: txEmail.text.trim(),
      password: txPassword.text,
    );
    hideLoader();
    if (response is Success) {
      if (response.code == 200) {
        var result = login_model.loginModelFromJson(response.response.toString());
        if (result.data != null) {
          await Get.find<UserViewModel>().setUserAuth(loginData: result.data ?? login_model.Data());
          if (Get.find<UserViewModel>().authToken.value.isNotEmpty) {
            await Get.find<UserViewModel>().getUserDetail(isShowLoader: true);
            Get.find<UserViewModel>().redirection();
          }
        }
      }
    } else if (response is Failure) {
      showToast(msg: "${response.errorResponse ?? ""}");
    }
  }

  onEyeClick() {
    isShowPassword.value = !isShowPassword.value;
  }
}
