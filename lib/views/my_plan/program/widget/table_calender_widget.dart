import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:revalesuva/components/custom_click.dart';
import 'package:revalesuva/components/custom_text.dart';
import 'package:revalesuva/utils/app_colors.dart';
import 'package:revalesuva/utils/helper_method.dart';
import 'package:table_calendar/table_calendar.dart';

class TableCalenderWidget extends StatelessWidget {
  const TableCalenderWidget({
    super.key,
    required this.selectedDate,
    required this.onTab,
  });

  final DateTime selectedDate;
  final Function(DateTime day) onTab;

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      locale: '${Get.locale?.languageCode}_${Get.locale?.countryCode}',
      focusedDay: selectedDate,
      firstDay: DateTime(DateTime.now().year, DateTime.now().month - 1, 1),
      lastDay: DateTime(DateTime.now().year, DateTime.now().month + 6, 0),
      calendarFormat: CalendarFormat.week,
      availableGestures: AvailableGestures.horizontalSwipe,
      daysOfWeekStyle: DaysOfWeekStyle(
        weekdayStyle: Theme.of(context).textTheme.bodyMedium?.apply(color: AppColors.textTertiary) ??
            const TextStyle(),
        weekendStyle: Theme.of(context).textTheme.bodyMedium?.apply(color: AppColors.textTertiary) ??
            const TextStyle(),
      ),
      headerStyle: HeaderStyle(
        formatButtonShowsNext: false,
        formatButtonVisible: false,
        titleTextStyle: Theme.of(context).textTheme.bodyMedium?.apply(color: AppColors.textTertiary) ??
            const TextStyle(),
        titleCentered: true,
        leftChevronVisible: true,
        rightChevronVisible: true,
        headerPadding: const EdgeInsets.symmetric(vertical: 10),
        rightChevronPadding: const EdgeInsets.symmetric(horizontal: 10),
        leftChevronPadding: const EdgeInsets.symmetric(horizontal: 10),
        leftChevronMargin: const EdgeInsets.all(0),
        rightChevronMargin: const EdgeInsets.all(0),
      ),
      calendarBuilders: CalendarBuilders(
        defaultBuilder: (context, day, focusedDay) {
          return CustomClick(
            onTap: () {
              onTab(day);
            },
            child: Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: compareTwoDate(date1: day.toString(), date2: selectedDate.toString()) ?? false
                      ? AppColors.surfaceBlueLight
                      : null),
              child: TextBodyMedium(
                text: day.day.toString(),
                color: compareTwoDate(date1: day.toString(), date2: selectedDate.toString()) ?? false
                    ? AppColors.textPrimary
                    : AppColors.textTertiary,
                size: -1,
              ),
            ),
          );
        },
        outsideBuilder: (context, day, focusedDay) {
          return CustomClick(
            onTap: () {
              onTab(day);
            },
            child: Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: compareTwoDate(date1: day.toString(), date2: selectedDate.toString()) ?? false
                      ? AppColors.surfaceBlueLight
                      : null),
              child: TextBodyMedium(
                text: day.day.toString(),
                color: compareTwoDate(date1: day.toString(), date2: selectedDate.toString()) ?? false
                    ? AppColors.textPrimary
                    : AppColors.textTertiary,
                size: -1,
              ),
            ),
          );
        },
      ),
      sixWeekMonthsEnforced: false,
      weekNumbersVisible: false,
      daysOfWeekVisible: true,
      calendarStyle: const CalendarStyle(
        isTodayHighlighted: false,
        outsideDaysVisible: true,
      ),
    );
  }
}
