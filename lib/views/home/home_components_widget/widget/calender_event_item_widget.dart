import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:revalesuva/components/custom_button.dart';
import 'package:revalesuva/components/custom_text.dart';
import 'package:revalesuva/model/home/event_model.dart' as event_model;
import 'package:revalesuva/model/workshop_events/workshop_event_model.dart' as workshop_event_model;
import 'package:revalesuva/utils/app_colors.dart';
import 'package:revalesuva/utils/app_corner.dart';
import 'package:revalesuva/utils/date_format_helper.dart';
import 'package:revalesuva/utils/helper_method.dart';
import 'package:revalesuva/utils/navigation_helper.dart';
import 'package:revalesuva/view_models/home/home_view_model.dart';
import 'package:revalesuva/views/workshop_events/workshop_events_detail_view.dart';

class CalenderEventItemWidget extends StatelessWidget {
  const CalenderEventItemWidget({super.key, required this.data});

  final event_model.Datum data;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.surfaceYellow,
        borderRadius: BorderRadius.circular(AppCorner.messageBox),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextHeadlineMedium(
            text: data.title ?? "",
          ),
          const Gap(5),
          Row(
            children: [
              Expanded(
                child: TextBodyMedium(
                  text: changeDateStringFormat(
                      date: data.date.toString(), format: DateFormatHelper.yyyyMMMddFormat),
                  color: AppColors.textPrimary,
                ),
              ),
              CustomTextButton(
                isFront: false,
                icon: Icons.arrow_forward_ios_rounded,
                text: "פרטים והרשמה",
                iconSize: 10,
                size: 1,
                onPressed: () {},
              ),
            ],
          )
        ],
      ),
    );
  }
}
