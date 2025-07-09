import 'package:flutter/material.dart';
import 'package:revalesuva/components/custom_click.dart';
import 'package:revalesuva/components/custom_text.dart';
import 'package:revalesuva/model/hadas_strengthening/weekly_torah_portion_model.dart'
    as weekly_torah_portion_model;
import 'package:revalesuva/utils/app_colors.dart';
import 'package:revalesuva/utils/app_corner.dart';
import 'package:revalesuva/utils/date_format_helper.dart';
import 'package:revalesuva/utils/helper_method.dart';
import 'package:revalesuva/utils/navigation_helper.dart';
import 'package:revalesuva/views/hadas_strengthening/weekly_torah_portion/weekly_torah_portion_detail.dart';

class WeeklyTorahPortionItemWidget extends StatelessWidget {
  const WeeklyTorahPortionItemWidget({super.key, required this.data, required this.index});

  final weekly_torah_portion_model.Datum data;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColors.surfaceTertiary,
        borderRadius: BorderRadius.circular(AppCorner.listTile),
      ),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextTitleMedium(
                        text: data.title ?? "",
                        maxLine: 1,
                      ),
                      TextBodySmall(
                        text: changeDateStringFormat(
                          date: data.date.toString(),
                          format: DateFormatHelper.mdyFormat,
                        ),
                        color: AppColors.textPrimary,
                        maxLine: 1,
                      ),
                    ],
                  )),
            ),
            if(checkIsAfter())
            CustomClick(
              onTap: () {
                NavigationHelper.pushScreenWithNavBar(
                  widget: WeeklyTorahPortionDetail(
                    data: data,
                  ),
                  context: context,
                );
              },
              child: Container(
                color: AppColors.surfaceBrand,
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.0),
                  child: Align(
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.keyboard_arrow_down_rounded,
                      size: 30,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  bool checkIsAfter() {
    var itemDate = data.date;
    var currentDate = DateTime.now();
    var isAfter = false;
    if (itemDate != null) {
      isAfter = itemDate.isAfter(currentDate);
    }
    return isAfter;
  }
}
