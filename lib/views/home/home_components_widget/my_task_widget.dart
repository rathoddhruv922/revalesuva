import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:revalesuva/components/custom_button.dart';
import 'package:revalesuva/components/custom_text.dart';
import 'package:revalesuva/generated/assets.dart';
import 'package:revalesuva/model/my_plan/tasks/task_model.dart' as task_model;
import 'package:revalesuva/utils/app_colors.dart';
import 'package:revalesuva/utils/app_corner.dart';
import 'package:revalesuva/utils/helper_method.dart';
import 'package:revalesuva/utils/navigation_helper.dart';
import 'package:revalesuva/utils/strings_constant.dart';
import 'package:revalesuva/view_models/home/home_view_model.dart';
import 'package:revalesuva/view_models/user_view_model.dart';
import 'package:revalesuva/views/my_plan/my_task/task_list_view.dart';
import 'package:revalesuva/views/my_plan/my_task/widget/task_item_widget.dart';

class MyTaskWidget extends StatelessWidget {
  MyTaskWidget({super.key});

  final HomeViewModel homeViewModel = Get.find<HomeViewModel>();

  initialCall() async {
    await homeViewModel.getActivePlan();
    if (homeViewModel.userPlanDetail.value.plan?.name?.isNotEmpty ?? false) {
      await homeViewModel.getTaskByPlanId(planId: homeViewModel.userPlanDetail.value.planId.toString());
      await homeViewModel.getUserTaskByPlanId(
          planId: homeViewModel.userPlanDetail.value.planId.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: initialCall(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 20.0),
            child: CustomShimmer(
              height: 150,
              radius: AppCorner.listTile,
            ),
          );
        } else {
          if ((homeViewModel.userPlanDetail.value.plan?.name?.isNotEmpty ?? false) &&
              (homeViewModel.listUserTask.isNotEmpty ?? false)) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: CustomCard2(
                color: AppColors.surfaceTertiary,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      children: [
                        const ImageIcon(
                          AssetImage(Assets.iconsIcTasks),
                          size: 25,
                        ),
                        const Gap(10),
                        Expanded(
                          child: TextHeadlineMedium(text: StringConstants.myTasks),
                        ),
                        const Gap(10),
                        Obx(
                          () => TextBodySmall(
                            text: StringConstants.myTaskStatus.replaceAll(
                              "{1}",
                              "${homeViewModel.userTaskTotal.value}/${homeViewModel.taskTotal.value}",
                            ),
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ],
                    ),
                    const Gap(10),
                    Obx(
                      () => homeViewModel.listTask.isNotEmpty
                          ? ListView.separated(
                              physics: const NeverScrollableScrollPhysics(),
                              padding: const EdgeInsets.symmetric(vertical: 0),
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                task_model.Datum item = homeViewModel.listTask[index];
                                return TaskItemWidget(
                                  data: item,
                                  listUserData: homeViewModel.listUserTask,
                                  onchange: (value) async {
                                    if (value ?? false) {
                                      await homeViewModel.createUserTask(
                                        lessonId: "${item.lesson?.id ?? ""}",
                                        planId: "${item.lesson?.planId ?? ""}",
                                        taskId: "${item.id ?? ""}",
                                      );
                                    } else {
                                      await homeViewModel.deleteUserTask(
                                        taskId: "${item.id ?? ""}",
                                        planId: "${item.lesson?.planId ?? ""}",
                                      );
                                    }
                                    await homeViewModel.getUserTaskByPlanId(
                                      planId: Get.find<UserViewModel>()
                                              .userData
                                              .value
                                              .plans
                                              ?.first
                                              .id
                                              .toString() ??
                                          "",
                                    );
                                    homeViewModel.userTaskTotal.value =
                                        homeViewModel.listUserTask.length;
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
                              itemCount:
                                  homeViewModel.listTask.length > 3 ? 3 : homeViewModel.listTask.length,
                            )
                          : noDataFoundWidget(height: 10),
                    ),
                    Divider(
                      height: 5,
                      thickness: 2,
                      color: AppColors.borderGreen.withValues(
                        alpha: 0.2,
                      ),
                    ),
                    CustomTextButton(
                      isFront: false,
                      icon: Icons.arrow_forward_ios_rounded,
                      text: StringConstants.allTasks,
                      iconSize: 10,
                      size: 4,
                      onPressed: () {
                        NavigationHelper.pushScreenWithNavBar(
                          widget: TaskListView(
                            planId: homeViewModel.userPlanDetail.value.planId.toString(),
                          ),
                          context: homeViewModel.persistentNavKey[0].currentState?.context ?? context,
                        );
                      },
                    )
                  ],
                ),
              ),
            );
          } else {
            return const SizedBox();
          }
        }
      },
    );
  }
}
