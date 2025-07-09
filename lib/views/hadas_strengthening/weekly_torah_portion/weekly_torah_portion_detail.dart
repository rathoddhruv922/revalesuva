import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:gap/gap.dart';
import 'package:revalesuva/components/custom_click.dart';
import 'package:revalesuva/components/custom_text.dart';
import 'package:revalesuva/model/hadas_strengthening/weekly_torah_portion_model.dart'
    as weekly_torah_portion_model;
import 'package:revalesuva/utils/app_colors.dart';
import 'package:revalesuva/utils/helper_method.dart';
import 'package:revalesuva/utils/navigation_helper.dart';
import 'package:revalesuva/utils/strings_constant.dart';

class WeeklyTorahPortionDetail extends StatelessWidget {
  const WeeklyTorahPortionDetail({
    super.key,
    required this.data,
  });

  final weekly_torah_portion_model.Datum data;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        NavigationHelper.onBackScreen(
          widget: WeeklyTorahPortionDetail(
            data: data,
          ),
        );
      },
      canPop: true,
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Gap(20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomClick(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: TextBodySmall(
                      text: "< ${StringConstants.backTo} ${StringConstants.weeklyTorahPortion}",
                      color: AppColors.textPrimary,
                      letterSpacing: 0,
                    ),
                  ),
                  const Gap(10),
                  TextHeadlineMedium(
                    text: data.title ?? "",
                    color: AppColors.textPrimary,
                    letterSpacing: 0,
                  ),
                  const Gap(5),
                  CustomCard2(
                    color: AppColors.surfaceTertiary,
                    child: customHtmlWidget(
                      data.description ?? "",
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
