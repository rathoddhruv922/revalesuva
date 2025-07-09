import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:revalesuva/components/custom_click.dart';
import 'package:revalesuva/components/custom_text.dart';
import 'package:revalesuva/utils/app_colors.dart';
import 'package:revalesuva/utils/app_corner.dart';
import 'package:revalesuva/utils/helper_method.dart';
import 'package:revalesuva/utils/navigation_helper.dart';
import 'package:revalesuva/utils/strings_constant.dart';
import 'package:revalesuva/view_models/my_plan/program_view_model.dart';
import 'package:revalesuva/views/my_plan/program/widget/schedule_item_widget.dart';
import 'package:revalesuva/views/my_plan/program/widget/table_calender_widget.dart';

class ProgramDetailView extends StatefulWidget {
  const ProgramDetailView({super.key, required this.programId});

  final String programId;

  @override
  State<ProgramDetailView> createState() => _ProgramDetailViewState();
}

class _ProgramDetailViewState extends State<ProgramDetailView> {
  final ProgramViewModel programViewModel = Get.put(ProgramViewModel());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        programViewModel.isLoading.value = true;
        await programViewModel.getScheduleByDate(
          programId: widget.programId,
        );
        programViewModel.isLoading.value = false;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        NavigationHelper.onBackScreen(
          widget: ProgramDetailView(
            programId: widget.programId,
          ),
        );
      },
      canPop: true,
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Gap(10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: CustomClick(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: TextBodySmall(
                  text: "< ${StringConstants.backTo} ${StringConstants.myPlan}",
                  color: AppColors.textPrimary,
                  letterSpacing: 0,
                ),
              ),
            ),
            const Gap(10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: TextHeadlineMedium(text: StringConstants.iceTherapy),
            ),
            const Gap(20),
            Container(
              color: AppColors.surfaceBlue,
              child: Obx(
                () => TableCalenderWidget(
                  onTab: (day) async {
                    programViewModel.selectedDate.value = day;
                    programViewModel.isLoading.value = true;
                    await programViewModel.getScheduleByDate(
                      programId: widget.programId,
                    );
                    programViewModel.isLoading.value = false;
                  },
                  selectedDate: programViewModel.selectedDate.value,
                ),
              ),
            ),
            Expanded(
              child: Obx(
                () => RefreshIndicator(
                  onRefresh: () async {
                    programViewModel.isLoading.value = true;
                    await programViewModel.getScheduleByDate(
                      programId: widget.programId,
                    );
                    programViewModel.isLoading.value = false;
                  },
                  child: ListView(
                    physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                    children: [
                      programViewModel.isLoading.value
                          ? ListView.separated(
                              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return const Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    CustomShimmer(
                                      height: 30,
                                      width: 50,
                                      radius: AppCorner.listTile,
                                    ),
                                    Gap(30),
                                    Expanded(
                                      child: CustomShimmer(
                                        height: 120,
                                        radius: AppCorner.listTile,
                                      ),
                                    )
                                  ],
                                );
                              },
                              itemCount: 3,
                              separatorBuilder: (context, index) => const Gap(10),
                            )
                          : programViewModel.listSchedules.isEmpty
                              ? noDataFoundWidget(
                                  message: StringConstants.heySorryClassesAreClosedToday,
                                )
                              : ListView.separated(
                                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return ScheduleItemWidget(
                                      data: programViewModel.listSchedules[index],
                                      programId: widget.programId,
                                    );
                                  },
                                  separatorBuilder: (context, index) => const Gap(10),
                                  itemCount: programViewModel.listSchedules.length,
                                ),
                    ],
                  ),
                ),
              ),
            ),
            const Gap(60)
          ],
        ),
      ),
    );
  }
}
