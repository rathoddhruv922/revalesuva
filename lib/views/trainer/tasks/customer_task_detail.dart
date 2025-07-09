import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:revalesuva/components/custom_appbar.dart';
import 'package:revalesuva/components/custom_click.dart';
import 'package:revalesuva/components/custom_text.dart';
import 'package:revalesuva/model/my_plan/tasks/task_model.dart' as task_model;
import 'package:revalesuva/utils/app_colors.dart';
import 'package:revalesuva/utils/app_corner.dart';
import 'package:revalesuva/utils/helper_method.dart';
import 'package:revalesuva/utils/strings_constant.dart';
import 'package:revalesuva/views/trainer/widget/drawer_widget.dart';

class CustomerTaskDetail extends StatelessWidget {
  CustomerTaskDetail({super.key, required this.taskData, required this.isCompleted});

  final task_model.Datum taskData;
  final bool isCompleted;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: customAppBarTrainer(
        key: scaffoldKey,
      ),
      drawer: DrawerWidget(
        drawerKey: scaffoldKey,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomClick(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: TextBodySmall(
                text: "< ${StringConstants.backTo} ${StringConstants.tasks}",
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
            const Gap(10),
            Align(
              alignment: AlignmentDirectional.centerEnd,
              child: Container(
                decoration: BoxDecoration(
                  color: isCompleted ? AppColors.surfaceGreen : AppColors.surfaceError,
                  borderRadius: BorderRadius.circular(AppCorner.button),
                ),
                padding: const EdgeInsets.symmetric(
                  vertical: 3,
                  horizontal: 10,
                ),
                child: TextTitleMedium(
                  text: isCompleted ? "Completed" : "Pending",
                  color: AppColors.textTertiary,
                ),
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(vertical: 20),
                physics: const BouncingScrollPhysics(),
                children: [
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
          ],
        ),
      ),
    );
  }
}
