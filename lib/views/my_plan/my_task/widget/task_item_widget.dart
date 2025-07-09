import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:revalesuva/components/custom_click.dart';
import 'package:revalesuva/components/custom_text.dart';
import 'package:revalesuva/generated/assets.dart';
import 'package:revalesuva/model/my_plan/tasks/task_model.dart' as task_model;
import 'package:revalesuva/model/my_plan/tasks/user_task_model.dart' as user_task_model;
import 'package:revalesuva/utils/app_colors.dart';
import 'package:revalesuva/utils/navigation_helper.dart';
import 'package:revalesuva/utils/strings_constant.dart';
import 'package:revalesuva/views/my_plan/my_task/task_detail_view.dart';

class TaskItemWidget extends StatefulWidget {
  const TaskItemWidget({
    super.key,
    required this.data,
    required this.listUserData,
    required this.onchange,
  });

  final task_model.Datum data;
  final List<user_task_model.Datum>? listUserData;
  final Function(bool?) onchange;

  @override
  State<TaskItemWidget> createState() => _TaskItemWidgetState();
}

class _TaskItemWidgetState extends State<TaskItemWidget> {
  bool checkStatus = false;
  user_task_model.Datum? userData;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        //checkStatus = widget.listUserData?.any((element) => element.task?.id == widget.data.id) ?? false;
        userData = widget.listUserData?.firstWhereOrNull((element) => element.task?.id == widget.data.id);
        if (userData != null) {
          checkStatus = true;
        }
        setState(() {});
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Checkbox(
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          value: checkStatus,
          onChanged: (value) {
            widget.onchange(value);
            checkStatus = value ?? !checkStatus;
            setState(() {});
          },
          activeColor: AppColors.surfaceGreen,
        ),
        Expanded(
          child: TextBodyMedium(
            text: widget.data.title ?? "",
            color: AppColors.textPrimary,
            maxLine: 1,
          ),
        ),
        const Gap(10),
        CustomClick(
          onTap: () {
            NavigationHelper.pushScreenWithNavBar(
              widget: TaskDetailView(
                taskData: widget.data,
                userTaskData: userData,
              ),
              context: context,
            );
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextBodySmall(
                text: StringConstants.inSummary,
                color: AppColors.textPrimary,
              ),
              const Gap(5),
              const Padding(
                padding: EdgeInsets.only(top: 2),
                child: ImageIcon(
                  AssetImage(Assets.iconsIcEndArrow),
                  size: 10,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
