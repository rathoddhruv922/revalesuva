import 'dart:async';

import 'package:get/get.dart';
import 'package:revalesuva/view_models/personal_detail/common_media_view_model.dart';
import 'package:revalesuva/view_models/user_view_model.dart';

class SplashViewModel extends GetxController {
  var progressStreamController = StreamController<int>.broadcast();
  var isShow = false.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    await Future.delayed(const Duration(seconds: 2));
    isShow.value = true;
    await Get.find<CommonMediaViewModel>().callCommonMedia();
    await Get.find<CommonMediaViewModel>().callGetCms();
    if (Get.find<UserViewModel>().authToken.value.isNotEmpty) {

      await Get.find<UserViewModel>().getUserDetail(isShowLoader: false);

    }
    await Future.delayed(const Duration(seconds: 2));
    onCreate();
  }

  onCreate() async {
    Get.find<UserViewModel>().redirection();
  }
}
