import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:revalesuva/components/custom_click.dart';
import 'package:revalesuva/components/custom_text.dart';
import 'package:revalesuva/generated/assets.dart';
import 'package:revalesuva/model/workshop_events/workshop_event_model.dart' as workshop_event_model;
import 'package:revalesuva/utils/app_colors.dart';
import 'package:revalesuva/utils/app_corner.dart';
import 'package:revalesuva/utils/extension.dart';
import 'package:revalesuva/utils/helper_method.dart';
import 'package:revalesuva/utils/navigation_helper.dart';
import 'package:revalesuva/view_models/home/home_view_model.dart';
import 'package:revalesuva/view_models/workshop_events/workshop_event_view_model.dart';
import 'package:revalesuva/views/home/home_components_widget/widget/calender_event_item_widget.dart';
import 'package:revalesuva/views/my_plan/program/program_detail_view.dart';
import 'package:revalesuva/views/workshop_events/workshop_events_detail_view.dart';
import 'package:table_calendar/table_calendar.dart';

class EventCalenderWidget extends StatefulWidget {
  const EventCalenderWidget({super.key});

  @override
  State<EventCalenderWidget> createState() => _EventCalenderWidgetState();
}

class _EventCalenderWidgetState extends State<EventCalenderWidget> {
  final HomeViewModel homeViewModel = Get.find<HomeViewModel>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        await homeViewModel.getEventsForCalender();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
      decoration: BoxDecoration(
        color: AppColors.surfaceTertiary,
        borderRadius: BorderRadius.circular(
          AppCorner.messageBox,
        ),
      ),
      child: Column(
        children: [
          Obx(
            () => TableCalendar(
              locale: '${Get.locale?.languageCode}_${Get.locale?.countryCode}',
              focusedDay: homeViewModel.selectedDateForCalender.value,
              firstDay: DateTime(DateTime.now().year, DateTime.now().month - 1, 1),
              lastDay: DateTime(DateTime.now().year, DateTime.now().year + 1, 0),
              calendarFormat: CalendarFormat.week,
              availableGestures: AvailableGestures.none,
              daysOfWeekStyle: DaysOfWeekStyle(
                weekdayStyle:
                    Theme.of(context).textTheme.bodyMedium?.apply(color: AppColors.textPrimary) ??
                        const TextStyle(),
                weekendStyle:
                    Theme.of(context).textTheme.bodyMedium?.apply(color: AppColors.textPrimary) ??
                        const TextStyle(),
              ),
              headerStyle: customizedHeader(context),
              calendarBuilders: CalendarBuilders(
                defaultBuilder: (context, day, focusedDay) {
                  return CustomClick(
                    onTap: () {
                      homeViewModel.updateCalenderDate(date: day);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: compareTwoDate(
                                    date1: day.toString(),
                                    date2: homeViewModel.selectedDateForCalender.value.toString()) ??
                                false
                            ? AppColors.textSecondary
                            : null,
                      ),
                      child: TextBodyMedium(
                        text: day.day.toString(),
                        color: compareTwoDate(
                                  date1: day.toString(),
                                  date2: homeViewModel.selectedDateForCalender.value.toString(),
                                ) ??
                                false
                            ? AppColors.textTertiary
                            : AppColors.textPrimary,
                        size: -1,
                      ),
                    ),
                  );
                },
                outsideBuilder: (context, day, focusedDay) {
                  return CustomClick(
                    onTap: () {
                      homeViewModel.updateCalenderDate(date: day);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: compareTwoDate(
                                    date1: day.toString(),
                                    date2: homeViewModel.selectedDateForCalender.value.toString(),
                                  ) ??
                                  false
                              ? AppColors.textSecondary
                              : null),
                      child: TextBodyMedium(
                        text: day.day.toString(),
                        color: compareTwoDate(
                                  date1: day.toString(),
                                  date2: homeViewModel.selectedDateForCalender.value.toString(),
                                ) ??
                                false
                            ? AppColors.textTertiary
                            : AppColors.textPrimary,
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
            ),
          ),
          Obx(
            () => homeViewModel.calenderLoader.isTrue
                ? const CustomShimmer(
                    radius: AppCorner.eventInfoCard,
                    height: 80,
                  )
                : homeViewModel.listEvents.isEmpty
                    ? const SizedBox() //noDataFoundWidget(height: 10)
                    : ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Get.put(WorkshopEventViewModel());
                              NavigationHelper.pushScreenWithNavBar(
                                widget: WorkshopEventsDetailView(
                                  data: workshop_event_model.Datum(
                                    date: homeViewModel.listEvents[index].date,
                                    image: homeViewModel.listEvents[index].image,
                                    id: homeViewModel.listEvents[index].id,
                                    title: homeViewModel.listEvents[index].title,
                                    createdAt: homeViewModel.listEvents[index].createdAt,
                                    isActive: homeViewModel.listEvents[index].isActive,
                                    description: homeViewModel.listEvents[index].description,
                                    startTime: homeViewModel.listEvents[index].startTime,
                                    noOfPeople: homeViewModel.listEvents[index].noOfPeople,
                                    endTime: homeViewModel.listEvents[index].endTime,
                                    updatedAt: homeViewModel.listEvents[index].updatedAt,
                                    price: homeViewModel.listEvents[index].price,
                                  ),
                                  fromScreen: "main",
                                ),
                                context:
                                    homeViewModel.persistentNavKey[0].currentState?.context ?? context,
                              );
                            },
                            child: CalenderEventItemWidget(
                              data: homeViewModel.listEvents[index],
                            ),
                          );
                        },
                        separatorBuilder: (context, index) => const Gap(10),
                        itemCount: homeViewModel.listEvents.length,
                      ),
          ),
          const Gap(10),
          Obx(
            () => homeViewModel.calenderLoader.isTrue
                ? const CustomShimmer(
                    radius: AppCorner.eventInfoCard,
                    height: 50,
                  )
                : homeViewModel.programData.value.time == null
                    ? const SizedBox()
                    : CustomClick(
                        onTap: () {
                          NavigationHelper.pushScreenWithNavBar(
                            widget: ProgramDetailView(
                              programId: homeViewModel.programData.value.id.toString(),
                            ),
                            context: homeViewModel.persistentNavKey[0].currentState?.context ?? context,
                          );
                        },
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsetsDirectional.only(top: 0, start: 0),
                              child: TextBodySmall(
                                text: convertToTimeString(homeViewModel.programData.value.time ?? ""),
                                color: AppColors.textPrimary,
                              ),
                            ),
                            const Gap(30),
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: AppColors.surfaceBlueLight,
                                  borderRadius: BorderRadius.circular(
                                    AppCorner.messageBox,
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: TextTitleSmall(
                                        text:
                                            homeViewModel.programData.value.name?.toCapitalized() ?? "",
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                          color: AppColors.surfaceTertiary.withValues(alpha: 0.7),
                                          borderRadius: BorderRadius.circular(AppCorner.videoCard)),
                                      child: const ImageIcon(
                                        AssetImage(Assets.iconsIcCalendar),
                                        size: 15,
                                      ),
                                    ),
                                    const Gap(5),
                                    Container(
                                      padding: const EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                          color: AppColors.surfaceTertiary.withValues(alpha: 0.7),
                                          borderRadius: BorderRadius.circular(AppCorner.videoCard)),
                                      child: const ImageIcon(
                                        AssetImage(Assets.iconsIcEdit2),
                                        size: 15,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
          )
        ],
      ),
    );
  }

  customizedHeader(BuildContext context) {
    return HeaderStyle(
      decoration: const BoxDecoration(
        color: AppColors.surfacePrimary,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(AppCorner.calenderHeader),
          bottomRight: Radius.circular(AppCorner.calenderHeader),
        ),
      ),
      headerMargin: const EdgeInsets.only(right: 50, left: 50, bottom: 20),
      formatButtonShowsNext: false,
      formatButtonVisible: false,
      titleTextStyle: Theme.of(context).textTheme.bodyMedium?.apply(color: AppColors.textPrimary) ??
          const TextStyle(),
      titleCentered: true,
      leftChevronVisible: true,
      rightChevronVisible: true,
      headerPadding: const EdgeInsets.symmetric(vertical: 5),
      rightChevronPadding: const EdgeInsets.symmetric(horizontal: 0),
      leftChevronPadding: const EdgeInsets.symmetric(horizontal: 0),
      leftChevronMargin: const EdgeInsets.symmetric(horizontal: 0),
      rightChevronMargin: const EdgeInsets.all(0),
    );
  }
}
