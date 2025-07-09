import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:revalesuva/utils/app_colors.dart';
import 'package:revalesuva/utils/app_corner.dart';
import 'package:revalesuva/views/home/widget/bottom_bar_widget.dart';

class CustomBottomNavWidget extends StatelessWidget {
  const CustomBottomNavWidget({
    super.key,
    required this.navBarConfig,
    required this.backgroundColor,
  });

  final NavBarConfig navBarConfig;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: navBarConfig.navBarHeight,
      padding: const EdgeInsets.only(top: 15),
      decoration:  BoxDecoration(
        color: backgroundColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(AppCorner.bottomNavCard),
          topRight: Radius.circular(AppCorner.bottomNavCard),
        ),
      ),
      child: BottomBarWidget(
        navBarConfig: navBarConfig,
      ),
    );
  }
}
