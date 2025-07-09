import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:revalesuva/components/custom_text.dart';
import 'package:revalesuva/generated/assets.dart';
import 'package:revalesuva/utils/app_colors.dart';
import 'package:revalesuva/utils/app_corner.dart';

class ListItem extends StatelessWidget {
  const ListItem({
    super.key,
    required this.title,
    required this.onTab,
    required this.icon,
    this.notificationCount = "",
    this.reminder = "",
    this.showReminderIcon = false,
    this.reminderColor = AppColors.surfaceGreen,
    this.backgroundColor = AppColors.surfaceTertiary,
    this.isShowBoarder = false,
    this.textColor = AppColors.textPrimary,
  });

  final String title;
  final Color backgroundColor;
  final void Function() onTab;
  final String icon;
  final String notificationCount;
  final String reminder;
  final bool showReminderIcon;
  final Color reminderColor;
  final bool isShowBoarder;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTab,
      child: Container(
        height: 45,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(
            AppCorner.listTile,
          ),
          border: isShowBoarder ? Border.all(color: AppColors.borderLightGray) : null,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ImageIcon(
              AssetImage(icon),
              size: 25,
              color: textColor,
            ),
            const Gap(10),
            TextBodyMedium(
              text: title,
              maxLine: 1,
              color: textColor,
            ),
            const Gap(5),
            if (notificationCount.isNotEmpty)
              Container(
                padding: const EdgeInsets.all(5),
                decoration: const BoxDecoration(
                  color: AppColors.surfaceError,
                  shape: BoxShape.circle,
                ),
                child: TextBodySmall(
                  text: notificationCount,
                  maxLine: 1,
                ),
              ),
            if (reminder.isNotEmpty)
              Expanded(
                flex: 20,
                child: SizedBox(
                  height: 45,
                  width: 45.w,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      if (showReminderIcon)
                        Image.asset(
                          Assets.iconsIcErrorRed,
                          width: 20,
                        ),
                      const Gap(5),
                      Flexible(
                        child: TextBodySmall(
                          text: reminder,
                          size: -1,
                          maxLine: 1,
                          color: reminderColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            const Gap(5),
            Expanded(
              flex: 1,
              child: Align(
                alignment: AlignmentDirectional.centerEnd,
                child: ImageIcon(
                  const AssetImage(Assets.iconsIcEndArrow),
                  color: textColor,
                  size: 15,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
