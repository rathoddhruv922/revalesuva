import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:revalesuva/generated/assets.dart';
import 'package:revalesuva/utils/app_colors.dart';
import 'package:revalesuva/utils/strings_constant.dart';

getBottomBarItem({
  required String activeImage,
  required String inActiveImage,
  required String title,
}) {
  return ItemConfig(
    activeForegroundColor: AppColors.textTertiary,
    inactiveBackgroundColor: AppColors.textTertiary,
    icon: SizedBox(
      height: 25,
      width: 25,
      child: Image.asset(
        activeImage,
        width: 25,
      ),
    ),
    inactiveIcon: SizedBox(
      height: 25,
      width: 25,
      child: Image.asset(
        inActiveImage,
        width: 25,
      ),
    ),
    title: title,
  );
}
