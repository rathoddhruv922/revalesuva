import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:revalesuva/components/custom_click.dart';
import 'package:revalesuva/components/custom_text.dart';
import 'package:revalesuva/components/list_item.dart';
import 'package:revalesuva/generated/assets.dart';
import 'package:revalesuva/model/my_plan/plans/user_plan_model.dart' as user_plan_model;
import 'package:revalesuva/utils/app_colors.dart';
import 'package:revalesuva/utils/extension.dart';
import 'package:revalesuva/utils/helper_method.dart';
import 'package:revalesuva/utils/navigation_helper.dart';
import 'package:revalesuva/utils/strings_constant.dart';
import 'package:revalesuva/view_models/my_plan/my_plan_view_model.dart';
import 'package:revalesuva/views/my_plan/content_libraries/content_libraries_list_view.dart';
import 'package:revalesuva/views/my_plan/lessons/lessons_list_view.dart';
import 'package:revalesuva/views/my_plan/my_task/task_list_view.dart';
import 'package:revalesuva/views/my_plan/principles_puzzle/principles_puzzle_view.dart';

class MyPlanOptionListView extends StatefulWidget {
  const MyPlanOptionListView({super.key, required this.data});

  final user_plan_model.Datum data;

  @override
  State<MyPlanOptionListView> createState() => _MyPlanListViewState();
}

class _MyPlanListViewState extends State<MyPlanOptionListView> {
  MyPlanViewModel myPlanViewModel = Get.find<MyPlanViewModel>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        myPlanViewModel.isLoading.value = true;
        await myPlanViewModel.getUserTaskByPlan(planId: "${widget.data.plan?.id ?? ""}");
        await myPlanViewModel.getTaskByPlan(planId: "${widget.data.plan?.id ?? ""}");
        await myPlanViewModel.getContentLibrariesByPlan(planId: "${widget.data.plan?.id ?? ""}");
        myPlanViewModel.isLoading.value = false;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        NavigationHelper.onBackScreen(
          widget: MyPlanOptionListView(
            data: widget.data,
          ),
        );
      },
      canPop: true,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Gap(10),
              CustomClick(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: TextBodySmall(
                  text: "< ${StringConstants.backTo} ${StringConstants.myPlan}",
                  color: AppColors.textPrimary,
                  letterSpacing: 0,
                ),
              ),
              Expanded(
                child: Obx(
                  () => myPlanViewModel.isLoading.value
                      ? ListView(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          physics: const BouncingScrollPhysics(),
                          children: [
                            CustomShimmer(
                              height: 5.h,
                              width: 100.w,
                              radius: 15,
                            ),
                            const Gap(10),
                            CustomShimmer(
                              height: 5.h,
                              width: 100.w,
                              radius: 15,
                            ),
                            const Gap(10),
                            CustomShimmer(
                              height: 5.h,
                              width: 100.w,
                              radius: 15,
                            ),
                            const Gap(10),
                            CustomShimmer(
                              height: 5.h,
                              width: 100.w,
                              radius: 15,
                            ),
                          ],
                        )
                      : RefreshIndicator(
                          onRefresh: () async {
                            await myPlanViewModel.getUserTaskByPlan(
                                planId: "${widget.data.plan?.id ?? ""}");
                            await myPlanViewModel.getTaskByPlan(planId: "${widget.data.plan?.id ?? ""}");
                            await myPlanViewModel.getContentLibrariesByPlan(
                                planId: "${widget.data.plan?.id ?? ""}");
                          },
                          child: ListView(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            physics: const BouncingScrollPhysics(
                              parent: AlwaysScrollableScrollPhysics(),
                            ),
                            children: [
                              TextHeadlineMedium(
                                text: (widget.data.plan?.name ?? "").toCapitalized(),
                                color: AppColors.textPrimary,
                                letterSpacing: 0,
                              ),
                              const Gap(10),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 5.0),
                                child: ListItem(
                                  title: StringConstants.lessons,
                                  onTab: () {
                                    NavigationHelper.pushScreenWithNavBar(
                                      widget: LessonsListView(
                                        data: widget.data,
                                      ),
                                      context: context,
                                    );
                                  },
                                  icon: Assets.iconsIcLesson,
                                ),
                              ),
                              Obx(
                                () => Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                                  child: ListItem(
                                    title: StringConstants.tasks,
                                    onTab: () {
                                      NavigationHelper.pushScreenWithNavBar(
                                        widget: TaskListView(
                                          planId: "${widget.data.plan?.id ?? ""}",
                                        ),
                                        context: context,
                                      );
                                    },
                                    icon: Assets.iconsIcTasks,
                                    reminder: StringConstants.myTaskStatus.replaceAll("{1}",
                                        "${myPlanViewModel.listUserTaskTotal}/${myPlanViewModel.listTaskTotal}"),
                                  ),
                                ),
                              ),
                              Obx(
                                () => myPlanViewModel.listUserTask.isNotEmpty
                                    ? Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                                        child: ListItem(
                                          title: StringConstants.myPrinciplesPuzzle,
                                          onTab: () {
                                            NavigationHelper.pushScreenWithNavBar(
                                              widget: PrinciplesPuzzleView(
                                                planId: "${widget.data.plan?.id ?? ""}",
                                              ),
                                              context: context,
                                            );
                                          },
                                          icon: Assets.iconsIcPuzzle,
                                        ),
                                      )
                                    : const SizedBox(),
                              ),
                              Obx(
                                () => myPlanViewModel.listContentLibraries.isNotEmpty
                                    ? Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                                        child: ListItem(
                                          title: StringConstants.contentLibrary,
                                          onTab: () {
                                            NavigationHelper.pushScreenWithNavBar(
                                              widget: ContentLibrariesListView(
                                                data: widget.data,
                                              ),
                                              context: context,
                                            );
                                          },
                                          icon: Assets.iconsIcContentLibrary,
                                          // reminder: StringConstants.newInformationalVideoHasBeenUploaded,
                                          // reminderColor: AppColors.textError,
                                          // showReminderIcon: true,
                                        ),
                                      )
                                    : const SizedBox(),
                              ),
                            ],
                          ),
                        ),
                ),
              ),
              const Gap(80),
            ],
          ),
        ),
      ),
    );
  }
}
