import 'package:flutter/material.dart';
import 'package:revalesuva/components/list_item.dart';
import 'package:revalesuva/model/my_plan/plans/user_plan_model.dart' as user_plan_model;
import 'package:revalesuva/utils/app_colors.dart';

class PlanItem extends StatelessWidget {
  const PlanItem({
    super.key,
    required this.planData,
    required this.icon,
    this.backgroundColor = AppColors.surfaceTertiary,
    required this.onTab, this.reminder,
  });

  final user_plan_model.Datum planData;
  final String icon;
  final Color backgroundColor;
  final Function() onTab;
  final String? reminder;

  @override
  Widget build(BuildContext context) {
    return ListItem(
      title: planData.plan?.name ?? "",
      backgroundColor: backgroundColor,
      onTab: onTab,
      icon: icon,
      reminder: reminder ?? "",
      reminderColor: AppColors.textPrimary,
    );
  }
}
