import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:revalesuva/components/custom_text.dart';
import 'package:revalesuva/utils/app_colors.dart';
import 'package:revalesuva/utils/app_corner.dart';

class SimpleButton extends StatelessWidget {
  const SimpleButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.backgroundColor = AppColors.surfaceBrand,
    this.width,
    this.height = 40,
  });

  final String text;
  final Color backgroundColor;
  final double? width;
  final double? height;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
            elevation: 0, backgroundColor: backgroundColor, padding: const EdgeInsets.all(0)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(text),
        ),
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.backgroundColor = AppColors.surfaceBrand,
    this.width,
    this.borderColor,
    this.textColor = AppColors.textPrimary,
  });

  final String text;
  final Color backgroundColor;
  final double? width;
  final Color? borderColor;
  final Color textColor;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: 30,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: backgroundColor,
          side: BorderSide(
            color: borderColor ?? AppColors.borderTertiary,
            width: borderColor == null ? 0 : 1,
          ),
          foregroundColor: textColor,
        ),
        child: Text(
          text,
        ),
      ),
    );
  }
}

class CustomIconButton extends StatelessWidget {
  const CustomIconButton({
    super.key,
    required this.text,
    required this.onPressed,
    required this.icon,
    this.width,
    this.iconSize = 12,
    this.backgroundColor = AppColors.surfaceBrand,
  });

  final String text;
  final IconData icon;
  final double iconSize;
  final double? width;
  final void Function() onPressed;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: 40,
        width: width,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(AppCorner.button),
            border: Border.all(color: AppColors.borderBrand, width: 2)),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 3.0),
                child: TextLabelMedium(
                  text: text,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
            const Gap(2),
            Icon(
              icon,
              size: iconSize,
              textDirection: Get.locale?.languageCode == "he" ? TextDirection.rtl : TextDirection.ltr,
              color: AppColors.textPrimary,
            ),
          ],
        ),
      ),
    );
  }
}

class CustomTextButton extends StatelessWidget {
  const CustomTextButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.underline = false,
    this.icon,
    this.textColor = AppColors.textPrimary,
    this.size = 0,
    this.weight = 0,
    this.isFront = true, this.iconSize,

  });

  final String text;
  final bool underline;
  final IconData? icon;
  final double? iconSize;
  final Color textColor;
  final double size;
  final int weight;
  final bool isFront;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          border: underline
              ? Border(
                  bottom: BorderSide(
                    color: textColor,
                    width: 0.5, // This would be the width of the underline
                  ),
                )
              : null,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if(isFront)
            icon != null
                ? Icon(
                    icon,
                    size: iconSize ?? 15,
                    textDirection:
                        Get.locale?.languageCode == "he" ? TextDirection.rtl : TextDirection.ltr,
                    color: textColor,
                  )
                : const SizedBox.shrink(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: TextLabelSmall(
                text: text,
                color: textColor,
                size: size,
                weight: weight,
              ),
            ),
            if(!isFront)
              icon != null
                  ? Icon(
                icon,
                size: iconSize ?? 15,
                textDirection:
                Get.locale?.languageCode == "he" ? TextDirection.rtl : TextDirection.ltr,
                color: textColor,
              )
                  : const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}

class CustomTextButtonWithIcon extends StatelessWidget {
  const CustomTextButtonWithIcon({
    super.key,
    required this.text,
    required this.onPressed,
    this.underline = false,
    this.icon,
    this.color = AppColors.textPrimary,
    this.size = 0,
  });

  final String text;
  final bool underline;
  final String? icon;
  final Color color;
  final double size;

  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          icon != null
              ? ImageIcon(
                  AssetImage(icon!),
                  color: color,
                  size: 20 + size,
                )
              : const SizedBox.shrink(),
          const Gap(5),
          Container(
            decoration: BoxDecoration(
              border: underline
                  ? Border(
                      bottom: BorderSide(
                        color: color,
                        width: 0.5, // This would be the width of the underline
                      ),
                    )
                  : null,
            ),
            child: TextLabelSmall(
              text: text,
              color: color,
              size: size,
              maxLine: 2,
            ),
          ),
        ],
      ),
    );
  }
}
