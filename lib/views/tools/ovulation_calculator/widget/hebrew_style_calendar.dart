import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:revalesuva/components/custom_text.dart';
import 'package:revalesuva/utils/app_colors.dart';
import 'package:revalesuva/utils/date_format_helper.dart';
import 'package:revalesuva/utils/helper_method.dart';
import 'package:revalesuva/view_models/tools/ovulation_calculator_view_model.dart';
import 'package:table_calendar/table_calendar.dart';

class HebrewStyleCalendar extends StatelessWidget {
  HebrewStyleCalendar({
    super.key,
  });

  final OvulationCalculatorViewModel ovulationCalculatorViewModel =
      Get.find<OvulationCalculatorViewModel>();

  @override
  Widget build(BuildContext context) {
    return CustomCard2(
      color: AppColors.surfaceTertiary,
      child: TableCalendar(
        locale: '${Get.locale?.languageCode}_${Get.locale?.countryCode}',
        focusedDay: DateTime.now(),
        firstDay: DateTime(DateTime.now().year, DateTime.now().month - 1, 1),
        lastDay: DateTime(DateTime.now().year, DateTime.now().year + 1, 0),
        daysOfWeekHeight: 40,
        availableGestures: AvailableGestures.none,
        headerStyle: HeaderStyle(
          formatButtonShowsNext: false,
          formatButtonVisible: false,
          titleTextStyle: Theme.of(context).textTheme.titleLarge ?? const TextStyle(),
          leftChevronVisible: true,
          rightChevronVisible: true,
          headerPadding: const EdgeInsets.symmetric(vertical: 10),
          rightChevronPadding: const EdgeInsets.all(0),
          leftChevronPadding: const EdgeInsets.all(0),
          leftChevronMargin: const EdgeInsets.all(0),
          rightChevronMargin: const EdgeInsets.all(0),
        ),
        calendarBuilders: CalendarBuilders(
          defaultBuilder: (context, day, focusedDay) {
            return Stack(
              children: [
                Obx(
                  () => Container(
                    height: 20,
                    width: double.infinity,
                    margin: const EdgeInsets.only(top: 5),
                    decoration: boxDecoration(calDate: day),
                  ),
                ),
                Container(
                  alignment: Alignment.topCenter,
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  padding: const EdgeInsets.only(top: 5),
                  decoration: BoxDecoration(
                    border: changeDateStringFormat(
                                date: day.toString(), format: DateFormatHelper.ymdFormat) ==
                            changeDateStringFormat(
                                date: DateTime.now().toString(), format: DateFormatHelper.ymdFormat)
                        ? const Border(
                            bottom: BorderSide(
                              color: AppColors.textPrimary,
                              width: 2,
                            ),
                          )
                        : null,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextBodyMedium(
                        text: day.day.toString(),
                        color: AppColors.textPrimary,
                        size: -1,
                      ),
                      const Gap(0),
                      TextBodySmall(
                        text: getHebrewDay(date: day),
                        color: AppColors.textPrimary,
                        size: -1,
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
        daysOfWeekStyle: DaysOfWeekStyle(
          weekdayStyle: Theme.of(context).textTheme.titleMedium ?? const TextStyle(),
        ),
        sixWeekMonthsEnforced: false,
        weekNumbersVisible: false,
        rowHeight: 50,
        calendarStyle: const CalendarStyle(
          isTodayHighlighted: false,
          outsideDaysVisible: false,
        ),
      ),
    );
  }

  Decoration? boxDecoration({required DateTime calDate}) {
    final formattedCalDate = changeDateStringFormat(
      date: calDate.toString(),
      format: DateFormatHelper.ymdFormat,
    );

    final selectedDate = ovulationCalculatorViewModel.listSelectedDate.toList().firstWhereOrNull(
          (datum) =>
              changeDateStringFormat(
                date: datum.date.toString(),
                format: DateFormatHelper.ymdFormat,
              ) ==
              formattedCalDate,
        );

    if (selectedDate == null) return null;

    final sortedDates = ovulationCalculatorViewModel.listSelectedDate.toList()
      ..sort((a, b) => a.date!.compareTo(b.date!));

    final currentIndex = sortedDates.indexOf(selectedDate);

    final isStartRadius = currentIndex == 0 ||
        sortedDates[currentIndex - 1].date!.add(const Duration(days: 1)) != selectedDate.date;

    final isEndRadius = currentIndex == sortedDates.length - 1 ||
        sortedDates[currentIndex + 1].date!.subtract(const Duration(days: 1)) != selectedDate.date;

    final color = switch (selectedDate.type ?? "") {
      "hormonal" => AppColors.surfaceYellow,
      "menstrual" => AppColors.surfaceBrand,
      "ovulation" => AppColors.surfaceGreen,
      String() => AppColors.surfaceTertiary,
    };

    return BoxDecoration(
      color: color,
      borderRadius: BorderRadiusDirectional.horizontal(
        start: Radius.circular(isStartRadius ? 10 : 0),
        end: Radius.circular(isEndRadius ? 10 : 0),
      ),
    );
  }

// Decoration? boxDecoration({required DateTime calDate}) {
//   final formattedCalDate =
//       changeDateStringFormat(date: calDate.toString(), format: DateFormatHelper.ymdFormat);
//
//   final selectedDate = ovulationCalculatorViewModel.listSelectedDate.toList().firstWhereOrNull(
//       (date) =>
//           changeDateStringFormat(date: date.toString(), format: DateFormatHelper.ymdFormat) ==
//           formattedCalDate);
//
//   if (selectedDate == null) return null;
//
//   final sortedDates = ovulationCalculatorViewModel.listSelectedDate.toList()..sort();
//   final currentIndex = sortedDates.indexOf(selectedDate);
//
//   final isStartRadius =
//       currentIndex == 0 || sortedDates[currentIndex - 1].add(const Duration(days: 1)) != selectedDate;
//
//   final isEndRadius = currentIndex == sortedDates.length - 1 ||
//       sortedDates[currentIndex + 1].subtract(const Duration(days: 1)) != selectedDate;
//
//   final color = switch (ovulationCalculatorViewModel.selectedOvulationType.value) {
//     OvulationType.hormonalDays => AppColors.surfaceYellow,
//     OvulationType.ovulation => AppColors.surfaceGreen,
//     OvulationType.menstruation => AppColors.surfaceBrand,
//   };
//
//   return BoxDecoration(
//     color: color,
//     borderRadius: BorderRadiusDirectional.horizontal(
//       start: Radius.circular(isStartRadius ? 10 : 0),
//       end: Radius.circular(isEndRadius ? 10 : 0),
//     ),
//   );
// }
}
