import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:revalesuva/components/custom_click.dart';
import 'package:revalesuva/components/custom_text.dart';
import 'package:revalesuva/generated/assets.dart';
import 'package:revalesuva/model/general_message/general_message_model.dart' as general_message_model;
import 'package:revalesuva/utils/app_colors.dart';
import 'package:revalesuva/utils/app_corner.dart';
import 'package:revalesuva/utils/date_format_helper.dart';
import 'package:revalesuva/utils/helper_method.dart';
import 'package:revalesuva/utils/navigation_helper.dart';
import 'package:revalesuva/utils/strings_constant.dart';
import 'package:revalesuva/view_models/general_message/general_message_view_model.dart';

class GeneralMessageDetailView extends StatelessWidget {
  const GeneralMessageDetailView({super.key, required this.data});

  final general_message_model.Datum data;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        NavigationHelper.onBackScreen(
            widget: GeneralMessageDetailView(
          data: data,
        ));
      },
      canPop: true,
      child: Scaffold(
        body: ListView(
          padding: const EdgeInsets.all(20),
          physics: const BouncingScrollPhysics(),
          children: [
            CustomClick(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: TextBodySmall(
                text: "< ${StringConstants.backTo} ${StringConstants.generalMessages}",
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
            TextBodySmall(
              text:
                  changeDateStringFormat(date: data.createdAt ?? "", format: DateFormatHelper.ymdFormat),
              color: AppColors.textPrimary.withValues(alpha: 0.5),
            ),
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
              child: customHtmlWidget(data.description ?? ""),
            ),
            const Gap(10),
            CustomClick(
              onTap: () async {
                await Get.find<GeneralMessageViewModel>().deleteGeneralMessage(id: data.id ?? 0);
                if(context.mounted){
                  Navigator.of(context).pop();
                }
              },
              child: Row(
                children: [
                  const ImageIcon(
                    AssetImage(Assets.iconsTrash),
                    size: 20,
                    color: AppColors.textError,
                  ),
                  const SizedBox(width: 10),
                  TextBodyMedium(
                    text: StringConstants.delete,
                    color: AppColors.textError,
                    letterSpacing: 0,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
