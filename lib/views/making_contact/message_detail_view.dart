import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:revalesuva/components/custom_click.dart';
import 'package:revalesuva/components/custom_text.dart';
import 'package:revalesuva/model/making_contact/get_support_service_model.dart'
    as get_support_service_model;
import 'package:revalesuva/utils/app_colors.dart';
import 'package:revalesuva/utils/app_corner.dart';
import 'package:revalesuva/utils/date_format_helper.dart';
import 'package:revalesuva/utils/helper_method.dart';
import 'package:revalesuva/utils/navigation_helper.dart';
import 'package:revalesuva/utils/strings_constant.dart';

class MessageDetailView extends StatelessWidget {
  const MessageDetailView({super.key, required this.data});

  final get_support_service_model.Datum data;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        NavigationHelper.onBackScreen(
            widget: MessageDetailView(
          data: data,
        ));
      },
      canPop: true,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomClick(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: TextBodySmall(
                  text: "< ${StringConstants.backTo} ${StringConstants.contactUs}",
                  color: AppColors.textPrimary,
                  letterSpacing: 0,
                ),
              ),
              const Gap(10),
              TextHeadlineMedium(
                text: data.helpQuestion.toString(),
                color: AppColors.textPrimary,
                letterSpacing: 0,
              ),
              TextBodySmall(
                text: changeDateStringFormat(
                    date: data.createdAt ?? "", format: DateFormatHelper.ymdFormat),
                color: AppColors.textPrimary.withValues(alpha: 0.5),
              ),
              Expanded(
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  children: [
                    const Gap(20),
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: const BoxDecoration(
                        color: AppColors.surfaceTertiary,
                        borderRadius: BorderRadiusDirectional.only(
                          bottomStart: Radius.circular(AppCorner.cardBoarder),
                          topEnd: Radius.circular(AppCorner.cardBoarder),
                        ),
                      ),
                      child: TextBodyMedium(
                        text: data.helpDetails.toString(),
                        color: AppColors.textPrimary,
                        letterSpacing: 0,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
