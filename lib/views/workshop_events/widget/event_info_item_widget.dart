import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:revalesuva/components/custom_text.dart';
import 'package:revalesuva/generated/assets.dart';
import 'package:revalesuva/utils/app_colors.dart';

class EventInfoItemWidget extends StatelessWidget {
  const EventInfoItemWidget({super.key, required this.title, required this.description, required this.icon});

  final String title;
  final String description;
  final String icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
         ImageIcon(
          AssetImage(icon),
          size: 30,
        ),
        const Gap(5),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FittedBox(
                child: TextTitleSmall(
                  text: title,
                  maxLine: 1,
                ),
              ),
              if(description.isNotEmpty)
              FittedBox(
                child: TextBodySmall(
                  text: description,
                  color: AppColors.textPrimary,
                  maxLine: 1,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
