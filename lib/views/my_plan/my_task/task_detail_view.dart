import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:revalesuva/components/custom_click.dart';
import 'package:revalesuva/components/custom_text.dart';
import 'package:revalesuva/model/my_plan/tasks/task_model.dart' as task_model;
import 'package:revalesuva/model/my_plan/tasks/user_task_model.dart' as user_task_model;
import 'package:revalesuva/utils/app_colors.dart';
import 'package:revalesuva/utils/app_corner.dart';
import 'package:revalesuva/utils/helper_method.dart';
import 'package:revalesuva/utils/navigation_helper.dart';
import 'package:revalesuva/utils/strings_constant.dart';

class TaskDetailView extends StatelessWidget {
  const TaskDetailView({
    super.key,
    required this.taskData,
    required this.userTaskData,
  });

  final task_model.Datum taskData;
  final user_task_model.Datum? userTaskData;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        NavigationHelper.onBackScreen(
          widget: TaskDetailView(
            taskData: taskData,
            userTaskData: userTaskData,
          ),
        );
      },
      canPop: true,
      child: Scaffold(
        body: ListView(
          padding: const EdgeInsets.all(20),
          physics: const BouncingScrollPhysics(),
          children: [
            CustomClick(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: TextBodySmall(
                text: "< ${StringConstants.backTo} ${StringConstants.myTasks}",
                color: AppColors.textPrimary,
                letterSpacing: 0,
              ),
            ),
            const Gap(10),
            TextHeadlineMedium(
              text: taskData.title ?? "",
              color: AppColors.textPrimary,
              letterSpacing: 0,
            ),
            const Gap(20),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: AppColors.surfaceTertiary,
                borderRadius: BorderRadiusDirectional.only(
                  bottomStart: Radius.circular(AppCorner.cardBoarder),
                  topEnd: Radius.circular(AppCorner.cardBoarder),
                ),
              ),
              child: customHtmlWidget(taskData.description ?? ""),
            ),
            const Gap(60),
          ],
        ),
      ),
    );
  }
}
