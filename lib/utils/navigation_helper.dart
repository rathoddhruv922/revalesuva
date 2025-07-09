import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:revalesuva/view_models/home/home_view_model.dart';
import 'package:revalesuva/view_models/user_view_model.dart';

class NavigationHelper {
  NavigationHelper._();

  static pushScreenWithNavBar({required Widget widget, required BuildContext context}) {
    if (Get.find<UserViewModel>().childActiveScreenName.value != "$widget") {
      Get.find<UserViewModel>().childActiveScreenName.value = "$widget";

      if ("$widget" == "ProgramDetailView") {
        Get.find<HomeViewModel>().updateIceDeepTheme(
          active: true,
        );
      }
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => widget,
        ),
      );
    }
  }

  static pushReplaceScreenWithNavBar({required Widget widget, required BuildContext context}) {
    if (Get.find<UserViewModel>().childActiveScreenName.value != "$widget") {
      Get.find<UserViewModel>().childActiveScreenName.value = "$widget";
      if ("$widget" == "ProgramDetailView") {
        Get.find<HomeViewModel>().updateIceDeepTheme(
          active: true,
        );
      }
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => widget,
        ),
      );
    }
  }

  static onBackScreen({required Widget widget}) {
    if (Get.find<UserViewModel>().childActiveScreenName.value == "$widget") {
      Get.find<UserViewModel>().childActiveScreenName.value = "";
    }
    if ("$widget" == "ProgramDetailView") {
      Get.find<HomeViewModel>().updateIceDeepTheme(
        active: false,
      );
    }
  }
}
