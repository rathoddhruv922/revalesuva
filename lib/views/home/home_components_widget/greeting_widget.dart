import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:revalesuva/components/custom_text.dart';
import 'package:revalesuva/utils/app_colors.dart';
import 'package:revalesuva/utils/strings_constant.dart';
import 'package:revalesuva/view_models/user_view_model.dart';

class GreetingWidget extends StatelessWidget {
  const GreetingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextHeadlineMedium(
          text: getGreeting().replaceAll("{}", Get.find<UserViewModel>().userData.value.name ?? ""),
        ),
        TextBodySmall(
          text: StringConstants.soWhatsOnTheAgenda,
          color: AppColors.textPrimary,
        ),
      ],
    );
  }

  String getGreeting() {
    final hour = DateTime.now().hour;

    if (hour < 12) {
      return StringConstants.goodMorning;
    } else if (hour < 17) {
      return StringConstants.goodAfternoon;
    } else {
      return StringConstants.goodEvening;
    }
  }
}
