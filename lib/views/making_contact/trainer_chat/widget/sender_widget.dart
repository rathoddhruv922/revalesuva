import 'package:flutter/material.dart';
import 'package:revalesuva/components/custom_text.dart';
import 'package:revalesuva/utils/app_colors.dart';
import 'package:revalesuva/utils/app_corner.dart';
import 'package:revalesuva/utils/date_format_helper.dart';
import 'package:revalesuva/utils/helper_method.dart';

class SenderWidget extends StatelessWidget {
  const SenderWidget({super.key, required this.message});

  final Map<dynamic, dynamic> message;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.centerEnd,
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsetsDirectional.only(
          start: 40,
        ),
        decoration: const BoxDecoration(
          color: AppColors.surfaceBrand,
          borderRadius: BorderRadiusDirectional.only(
            bottomStart: Radius.circular(AppCorner.messageBox),
            topStart: Radius.circular(AppCorner.messageBox),
            topEnd: Radius.circular(AppCorner.messageBox),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextBodyMedium(
              text: "${message["message"]}",
              color: AppColors.textPrimary,
            ),
            TextBodySmall(
              text: changeDateStringFormat(date: message["timestamp"] ?? "", format: DateFormatHelper.dateTimeFormat),
              size: -2,
              color: AppColors.textSecondary.withValues(alpha: 0.5),
            ),
          ],
        ),
      ),
    );
  }
}
