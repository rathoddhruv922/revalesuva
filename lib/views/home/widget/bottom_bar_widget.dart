import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:revalesuva/components/custom_click.dart';
import 'package:revalesuva/views/home/widget/bottom_bar_item_widget.dart';

class BottomBarWidget extends StatelessWidget {
  const BottomBarWidget({super.key, required this.navBarConfig});

  final NavBarConfig navBarConfig;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: navBarConfig.items.map(
        (item) {
          final int index = navBarConfig.items.indexOf(item);
          return Expanded(
            child: CustomClick(
              onTap: () {
                navBarConfig.onItemSelected(index);
              },
              child: BottomBarItemWidget(
                navBarConfig: navBarConfig,
                index: index,
                item: item,
              ),
            ),
          );
        },
      ).toList(),
    );
  }
}
