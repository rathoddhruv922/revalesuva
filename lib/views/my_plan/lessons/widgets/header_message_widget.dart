import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:revalesuva/components/custom_click.dart';
import 'package:revalesuva/components/custom_text.dart';
import 'package:revalesuva/generated/assets.dart';
import 'package:revalesuva/utils/app_colors.dart';
import 'package:revalesuva/utils/app_corner.dart';
import 'package:revalesuva/utils/navigation_helper.dart';
import 'package:revalesuva/utils/strings_constant.dart';
import 'package:revalesuva/views/my_plan/program_completion_report/program_completion_report_view.dart';
import 'package:revalesuva/views/my_plan/program_completion_report/see_your_progress_view.dart';

class HeaderMessageWidget extends StatelessWidget {
  const HeaderMessageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.surfaceGreen,
        borderRadius: BorderRadius.circular(
          AppCorner.messageBox,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 5.0),
                child: ImageIcon(
                  AssetImage(Assets.iconsIcLikeBlank),
                  size: 18,
                  color: AppColors.textTertiary,
                ),
              ),
              const Gap(10),
              Expanded(
                child: TextTitleMedium(
                  text: StringConstants.programCompletionMessage,
                  color: AppColors.textTertiary,
                ),
              ),
            ],
          ),
          CustomClick(
            onTap: () {
              NavigationHelper.pushReplaceScreenWithNavBar(
                widget: const ProgramCompletionReportView(),
                context: context,
              );
            },
            child: Align(
              alignment: AlignmentDirectional.centerEnd,
              child: TextBodySmall(
                text: "${StringConstants.clickHereToFillOut} >",
                color: AppColors.textTertiary,
                letterSpacing: 0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
