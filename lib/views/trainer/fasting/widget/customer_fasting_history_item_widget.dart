import 'package:flutter/material.dart';
import 'package:revalesuva/components/custom_text.dart';
import 'package:revalesuva/model/trainer/fasting_calculator/fasting_calculator_model.dart'
    as fasting_calculator_model;
import 'package:revalesuva/utils/app_colors.dart';
import 'package:revalesuva/utils/date_format_helper.dart';
import 'package:revalesuva/utils/helper_method.dart';

class CustomerFastingHistoryItemWidget extends StatelessWidget {
  const CustomerFastingHistoryItemWidget({super.key, required this.data});

  final fasting_calculator_model.Datum data;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Container(
        decoration: BoxDecoration(
          border: Border.symmetric(
            vertical: BorderSide(
              color: AppColors.borderSecondary.withValues(
                alpha: 0.5,
              ),
            ),
          ),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: TextBodySmall(
                      text: changeDateStringFormat(
                        date: data.date.toString(),
                        format: DateFormatHelper.mdyFormat,
                      ),
                      textAlign: TextAlign.center,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
                const VerticalDivider(
                  width: 1,
                  color: AppColors.borderTertiary,
                  endIndent: 0,
                  indent: 0,
                ),
                Expanded(
                  child: TextBodySmall(
                    text: getDuration(),
                    textAlign: TextAlign.center,
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
            Divider(
              height: 0,
              color: AppColors.borderSecondary.withValues(
                alpha: 0.5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String getDuration() {
    if (data.endTime != null) {
      DateTime? startDateTime = DateTime.tryParse(
          "${changeDateStringFormat(date: data.date.toString(), format: DateFormatHelper.ymdFormat)} ${data.startTime ?? ""}");
      DateTime? endDateTime = DateTime.tryParse(
          "${changeDateStringFormat(date: data.date.toString(), format: DateFormatHelper.ymdFormat)} ${data.endTime ?? ""}");

      if (startDateTime != null && endDateTime != null) {
        Duration duration = endDateTime.difference(startDateTime);
        if (duration.isNegative) {
          return "Invalid Time Range";
        }
        String twoDigits(int n) => n.toString().padLeft(2, '0');
        var fastingHours = twoDigits(duration.inHours);
        var fastingMinutes = twoDigits(duration.inMinutes.remainder(60));
        return "$fastingHours:$fastingMinutes";
      } else {
        return "Not Found";
      }
    } else {
      DateTime? startDateTime = DateTime.tryParse("${data.date} ${data.startTime}");
      DateTime? endDateTime = DateTime.now();

      if (startDateTime != null) {
        Duration duration = endDateTime.difference(startDateTime);
        if (duration.isNegative) {
          return "Invalid Time Range";
        }
        String twoDigits(int n) => n.toString().padLeft(2, '0');
        var fastingHours = twoDigits(duration.inHours);
        var fastingMinutes = twoDigits(duration.inMinutes.remainder(60));
        return "$fastingHours:$fastingMinutes";
      } else {
        return "Not Found";
      }
    }
  }
}
