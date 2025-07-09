import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:revalesuva/components/custom_click.dart';
import 'package:revalesuva/components/custom_text.dart';
import 'package:revalesuva/generated/assets.dart';
import 'package:revalesuva/model/my_plan/tasks/task_model.dart' as task_model;
import 'package:revalesuva/utils/app_colors.dart';
import 'package:revalesuva/utils/app_corner.dart';
import 'package:revalesuva/utils/helper_method.dart';
import 'package:revalesuva/utils/navigation_helper.dart';
import 'package:revalesuva/utils/strings_constant.dart';
import 'package:revalesuva/view_models/my_plan/my_task_view_model.dart';
import 'package:revalesuva/views/my_plan/my_task/widget/task_item_widget.dart';

class TaskListView extends StatefulWidget {
  const TaskListView({
    super.key,
    required this.planId,
  });

  final String planId;

  @override
  State<TaskListView> createState() => _TaskListViewState();
}

class _TaskListViewState extends State<TaskListView> {
  MyTaskViewModel myTaskViewModel = Get.put(MyTaskViewModel());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        myTaskViewModel.isLoading.value = true;
        await myTaskViewModel.getTaskByPlanId(
          planId: widget.planId,
        );
        await myTaskViewModel.getUserTaskByPlanId(
          planId: widget.planId,
        );
        myTaskViewModel.isLoading.value = false;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        NavigationHelper.onBackScreen(
          widget: TaskListView(
            planId: widget.planId,
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
              const Gap(10),
              TextHeadlineMedium(text: StringConstants.myTasks),
              const Gap(10),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () async {
                    await myTaskViewModel.getTaskByPlanId(
                      planId: widget.planId,
                    );
                    await myTaskViewModel.getUserTaskByPlanId(
                      planId: widget.planId,
                    );
                    myTaskViewModel.filterListTask(planId: widget.planId);
                  },
                  child: ListView(
                    shrinkWrap: false,
                    physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                    children: [
                      Obx(
                        () => Row(
                          children: [
                            CustomClick(
                              onTap: () {
                                myTaskViewModel.filterListTask(
                                  planId: widget.planId,
                                  checkValue: !myTaskViewModel.isShowAll.value,
                                );
                              },
                              child: Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(3),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: myTaskViewModel.isShowAll.value
                                          ? AppColors.surfaceGreen
                                          : null,
                                    ),
                                    child: ImageIcon(
                                      const AssetImage(Assets.iconsIcTaskFilter),
                                      size: 15,
                                      color: myTaskViewModel.isShowAll.value
                                          ? AppColors.iconTertiary
                                          : AppColors.textError,
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  TextBodyMedium(
                                    text: myTaskViewModel.isShowAll.value
                                        ? StringConstants.selectAll
                                        : StringConstants.showAllIncompleteTasks,
                                    color: AppColors.textError,
                                    letterSpacing: 0,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Gap(10),
                      Obx(
                        () => myTaskViewModel.isLoading.isTrue
                            ? const CustomShimmer(
                                height: 100,
                                radius: AppCorner.listTile,
                              )
                            : CustomCard2(
                                color: AppColors.surfaceTertiary,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Obx(
                                      () => TextBodySmall(
                                        text: StringConstants.myTaskStatus.replaceAll(
                                          "{1}",
                                          "${myTaskViewModel.userTaskTotal.value}/${myTaskViewModel.taskTotal.value}",
                                        ),
                                        color: AppColors.textPrimary,
                                      ),
                                    ),
                                    const Gap(10),
                                    Obx(
                                      () => myTaskViewModel.filterTaskList.isNotEmpty
                                          ? Obx(() => ListView.separated(
                                        physics: const NeverScrollableScrollPhysics(),
                                        padding: const EdgeInsets.symmetric(vertical: 0),
                                        shrinkWrap: true,
                                        itemBuilder: (context, index) {
                                          task_model.Datum item =
                                          myTaskViewModel.filterTaskList[index];
                                          return TaskItemWidget(
                                            data: item,
                                            listUserData: myTaskViewModel.listUserTask,
                                            onchange: (value) async {
                                              if (value ?? false) {
                                                await myTaskViewModel.createUserTask(
                                                  lessonId: "${item.lesson?.id ?? ""}",
                                                  planId: "${item.lesson?.planId ?? ""}",
                                                  taskId: "${item.id ?? ""}",
                                                );
                                              } else {
                                                await myTaskViewModel.deleteUserTask(
                                                  taskId: "${item.id ?? ""}",
                                                  planId: "${item.lesson?.planId ?? ""}",
                                                );
                                              }
                                              await myTaskViewModel.getUserTaskByPlanId(
                                                planId: widget.planId,
                                              );
                                              myTaskViewModel.userTaskTotal.value = myTaskViewModel.listUserTask.length;
                                            },
                                          );
                                        },
                                        separatorBuilder: (context, index) => Divider(
                                          height: 5,
                                          thickness: 2,
                                          color: AppColors.borderGreen.withValues(
                                            alpha: 0.2,
                                          ),
                                        ),
                                        itemCount: myTaskViewModel.filterTaskList.length,
                                      ),)
                                          : noDataFoundWidget(height: 10),
                                    )
                                  ],
                                ),
                              ),
                      ),
                    ],
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
