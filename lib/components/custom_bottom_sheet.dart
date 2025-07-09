import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:revalesuva/components/custom_text.dart';
import 'package:revalesuva/generated/assets.dart';
import 'package:revalesuva/utils/app_colors.dart';
import 'package:revalesuva/utils/app_corner.dart';

class CustomBottomSheet extends StatelessWidget {
  const CustomBottomSheet({super.key, required this.bottomSheetTitle, required this.widget, required this.onDone});

  final String bottomSheetTitle;
  final Widget widget;
  final void Function() onDone;

  @override
  Widget build(BuildContext context) {
    FocusManager.instance.primaryFocus?.unfocus();
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 20,
          horizontal: 20,
        ),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(AppCorner.cardBoarder),
            topLeft: Radius.circular(AppCorner.cardBoarder),
          ),
          color: AppColors.surfaceSecondary,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (bottomSheetTitle.isNotEmpty)
              Row(
                children: [
                  InkWell(
                    onTap: onDone,
                    child: SizedBox(
                      width: 10.w,
                      child: const TextTitleMedium(
                        text: "Done",
                        color: AppColors.iconGreen,
                      ),
                    ),
                  ),
                  Expanded(
                    child: TextTitleMedium(
                      textAlign: TextAlign.center,
                      text: bottomSheetTitle,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      if (Get.isBottomSheetOpen ?? false) {
                        Get.back();
                      }
                    },
                    child: SizedBox(
                      width: 10.w,
                      child: Image.asset(
                        Assets.iconsIcClose,
                        height: 20,
                        color: AppColors.iconGreen,
                      ),
                    ),
                  ),
                ],
              ),
            if (bottomSheetTitle.isNotEmpty) const Gap(20),
            Flexible(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppCorner.cardBoarder),
                  // color: AppColors.surfaceSecondary,
                ),
                padding: const EdgeInsets.symmetric(vertical: 0),
                child: widget,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
