import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:revalesuva/components/custom_text.dart';
import 'package:revalesuva/utils/app_colors.dart';
import 'package:revalesuva/utils/app_corner.dart';
import 'package:revalesuva/utils/date_format_helper.dart';
import 'package:revalesuva/utils/helper_method.dart';

class ReceiverWidget extends StatelessWidget {
  const ReceiverWidget({super.key, required this.message, required this.receiverName});

  final Map<dynamic, dynamic> message;
  final String receiverName;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsetsDirectional.only(
          end: 40,
        ),
        decoration: const BoxDecoration(
          color: AppColors.surfaceTertiary,
          borderRadius: BorderRadiusDirectional.only(
            topStart: Radius.circular(AppCorner.messageBox),
            bottomEnd: Radius.circular(AppCorner.messageBox),
            topEnd: Radius.circular(AppCorner.messageBox),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextTitleMedium(
              text: receiverName,
              color: AppColors.surfaceGreenLight,
            ),
            const Gap(5),
            TextBodyMedium(
              text: "${message["message"]}",
              color: AppColors.textPrimary,
            ),
            TextBodySmall(
              text: changeDateStringFormat(
                  date: message["timestamp"] ?? "", format: DateFormatHelper.dateTimeFormat),
              size: -2,
              color: AppColors.textSecondary.withValues(alpha: 0.5),
            ),
          ],
        ),
      ),
    );
  }
}
