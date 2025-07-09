import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:revalesuva/components/custom_click.dart';
import 'package:revalesuva/components/custom_text.dart';
import 'package:revalesuva/generated/assets.dart';
import 'package:revalesuva/model/tools/daily_report/daily_report_model.dart' as daily_report_model;
import 'package:revalesuva/utils/app_colors.dart';
import 'package:revalesuva/utils/app_corner.dart';
import 'package:revalesuva/utils/date_format_helper.dart';
import 'package:revalesuva/utils/helper_method.dart';
import 'package:revalesuva/utils/navigation_helper.dart';
import 'package:revalesuva/utils/strings_constant.dart';
import 'package:revalesuva/views/tools/weekly_report/weekly_report_ans_view.dart';

class WeeklyReportListItem extends StatelessWidget {
  const WeeklyReportListItem({super.key, required this.data, required this.count, required this.weeks});

  final daily_report_model.Datum data;
  final String count;
  final String weeks;

  @override
  Widget build(BuildContext context) {
    return CustomClick(
      onTap: () {
        NavigationHelper.pushScreenWithNavBar(
          widget: WeeklyReportAnsView(
            date: changeDateStringFormat(
              date: data.date.toString(),
              format: DateFormatHelper.ymdFormat,
            ),
            week: weeks,
          ),
          context: context,
        );
      },
      child: Container(
        width: 100.w,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          color: AppColors.surfaceTertiary,
          borderRadius: BorderRadius.circular(
            AppCorner.listTile,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 10,
          ),
          child: Row(
            children: [
              Expanded(
                child: TextTitleMedium(
                  text: "${StringConstants.dailyReport} $weeks",
                  maxLine: 1,
                ),
              ),
              TextBodySmall(
                text: changeDateStringFormat(
                  date: data.date.toString(),
                  format: DateFormatHelper.ymdFormat,
                ),
                color: AppColors.textSecondary,
              ),
              const Gap(10),
              const ImageIcon(
                AssetImage(Assets.iconsIcArrowLeft),
                size: 15,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
