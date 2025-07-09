import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:revalesuva/components/custom_click.dart';
import 'package:revalesuva/components/custom_text.dart';
import 'package:revalesuva/generated/assets.dart';
import 'package:revalesuva/model/my_plan/tasks/task_model.dart' as task_model;
import 'package:revalesuva/model/my_plan/tasks/user_task_model.dart' as user_task_model;
import 'package:revalesuva/utils/app_colors.dart';
import 'package:revalesuva/utils/helper_method.dart';
import 'package:revalesuva/utils/navigation_helper.dart';
import 'package:revalesuva/utils/strings_constant.dart';
import 'package:revalesuva/view_models/my_plan/lessons_view_model.dart';
import 'package:revalesuva/views/my_plan/my_task/task_list_view.dart';
import 'package:revalesuva/views/my_plan/my_task/widget/task_item_widget.dart';

class LessonTaskWidget extends StatelessWidget {
  const LessonTaskWidget({
    super.key,
    required this.listData,
    required this.listUserData,
    required this.planId,
  });

  final List<task_model.Datum> listData;
  final List<user_task_model.Datum> listUserData;
  final String planId;

  @override
  Widget build(BuildContext context) {
    return CustomCard2(
      color: AppColors.surfaceTertiary,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const ImageIcon(
                AssetImage(Assets.iconsIcTasks),
                size: 20,
              ),
              const Gap(10),
              Expanded(
                child: TextHeadlineMedium(
                  text: StringConstants.myTasksFromTheLesson,
                ),
              ),
            ],
          ),
          listData.isNotEmpty
              ? ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    task_model.Datum item = listData[index];
                    return TaskItemWidget(
                      data: item,
                      listUserData: listUserData,
                      onchange: (value) {
                        if (value ?? false) {
                          Get.find<LessonsViewModel>().createUserTask(
                            lessonId: "${item.lesson?.id ?? ""}",
                            planId: "${item.lesson?.planId ?? ""}",
                            taskId: "${item.id ?? ""}",
                          );
                        } else {
                          Get.find<LessonsViewModel>().deleteUserTask(
                            taskId: "${item.id ?? ""}",
                          );
                        }
                      },
                    );
                  },
                  separatorBuilder: (context, index) => Divider(
                    height: 20,
                    thickness: 2,
                    color: AppColors.borderGreen.withValues(
                      alpha: 0.2,
                    ),
                  ),
                  itemCount: listData.length,
                )
              : noDataFoundWidget(height: 10),
          listData.isNotEmpty
              ? Align(
                  alignment: AlignmentDirectional.centerEnd,
                  child: CustomClick(
                    onTap: () {
                      NavigationHelper.pushScreenWithNavBar(
                        widget: TaskListView(
                          planId: planId,
                        ),
                        context: context,
                      );
                    },
                    child: TextBodySmall(
                      text: "${StringConstants.backTo} ${StringConstants.allTasks} >",
                      color: AppColors.textPrimary,
                      letterSpacing: 0,
                    ),
                  ),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
