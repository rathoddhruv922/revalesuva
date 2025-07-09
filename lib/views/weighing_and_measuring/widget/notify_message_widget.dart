import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:revalesuva/components/custom_text.dart';
import 'package:revalesuva/utils/app_colors.dart';
import 'package:revalesuva/utils/helper_method.dart';

class NotifyMessageWidget extends StatelessWidget {
  const NotifyMessageWidget({
    super.key,
    required this.title,
    required this.icons,
    required this.description,
    required this.backgroundColor,
  });

  final String title;
  final String icons;
  final String description;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      color: backgroundColor,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Image.asset(
              icons,
              width: 25,
            ),
          ),
          const Gap(10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                title.isNotEmpty ? TextTitleMedium(
                  text: title,
                  color: AppColors.textTertiary,
                ) : const SizedBox(),
                description.isNotEmpty ? TextBodySmall(text: description) : const SizedBox(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class NotifyMessageWidget2 extends StatelessWidget {
  const NotifyMessageWidget2({
    super.key,
    required this.title,
    required this.icons,
    required this.description,
    required this.backgroundColor,
  });

  final String title;
  final String icons;
  final String description;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      color: backgroundColor,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            icons,
            width: 20,
            color: AppColors.iconTertiary,
          ),
          const Gap(10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              description.isNotEmpty ? TextBodySmall(text: description) : const SizedBox(),
              TextTitleMedium(
                text: title,
                color: AppColors.textTertiary,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
