import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:revalesuva/components/custom_text.dart';
import 'package:revalesuva/utils/app_colors.dart';

class BottomBarItemWidget extends StatelessWidget {
  const BottomBarItemWidget({super.key, required this.navBarConfig, required this.item, required this.index});

  final NavBarConfig navBarConfig;
  final ItemConfig item;
  final int index;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        IconTheme(
          data: IconThemeData(
            size: item.iconSize,
          ),
          child: navBarConfig.selectedIndex == index ? item.icon : item.inactiveIcon,
        ),
        const Gap(3),
        TextTitleSmall(
          text: item.title ?? "",
          size: -3,
          textAlign: TextAlign.center,
          color: AppColors.textTertiary,
        ),
      ],
    );
  }
}
