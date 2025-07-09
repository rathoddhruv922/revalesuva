import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:revalesuva/components/custom_click.dart';
import 'package:revalesuva/components/custom_text.dart';
import 'package:revalesuva/generated/assets.dart';
import 'package:revalesuva/utils/app_colors.dart';
import 'package:revalesuva/utils/strings_constant.dart';

class EditButtonWidget extends StatelessWidget {
  const EditButtonWidget({
    super.key,
    required this.title,
    this.onTab,
    this.icon = "",
  });

  final String title;
  final String icon;
  final void Function()? onTab;

  @override
  Widget build(BuildContext context) {
    return CustomClick(
      onTap: onTab,
      child: Row(
        textDirection: Get.locale?.languageCode == "he" ? TextDirection.rtl : TextDirection.ltr,
        children: [
          icon.isNotEmpty
              ? Padding(
                  padding: const EdgeInsetsDirectional.only(end: 10),
                  child: ImageIcon(
                    AssetImage(icon),
                    size: 20,
                  ),
                )
              : const SizedBox(),
          Expanded(
            child: TextTitleMedium(
              text: title,
            ),
          ),
          if (onTab != null)
            const ImageIcon(
              AssetImage(Assets.iconsIcEdit2),
              size: 15,
              color: AppColors.textPrimary,
            ),
          const Gap(5),
          if (onTab != null)
            TextLabelMedium(
              text: StringConstants.edit,
              color: AppColors.textPrimary,
            ),
        ],
      ),
    );
  }
}
