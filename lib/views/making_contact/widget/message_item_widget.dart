import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:revalesuva/components/custom_click.dart';
import 'package:revalesuva/components/custom_text.dart';
import 'package:revalesuva/generated/assets.dart';
import 'package:revalesuva/model/making_contact/get_support_service_model.dart'
    as get_support_service_model;
import 'package:revalesuva/utils/app_colors.dart';
import 'package:revalesuva/utils/app_corner.dart';
import 'package:revalesuva/utils/helper_method.dart';
import 'package:revalesuva/utils/navigation_helper.dart';
import 'package:revalesuva/utils/strings_constant.dart';
import 'package:revalesuva/view_models/making_contact/making_contact_view_model.dart';
import 'package:revalesuva/views/making_contact/message_detail_view.dart';

import '../../../utils/date_format_helper.dart';

class MessageItemWidget extends StatelessWidget {
  MessageItemWidget({super.key, required this.data, required this.index, required this.messageType});

  final get_support_service_model.Datum data;
  final int index;
  final String messageType;
  final MakingContactViewModel makingContactViewModel = Get.find<MakingContactViewModel>();

  @override
  Widget build(BuildContext context) {
    return CustomClick(
      onTap: () {
        NavigationHelper.pushScreenWithNavBar(
          widget: MessageDetailView(
            data: data,
          ),
          context: context,
        );
      },
      child: Container(
        width: 100.w,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          color: AppColors.surfaceTertiary,
          borderRadius: BorderRadius.circular(
            AppCorner.cardBoarder,
          ),
        ),
        child: Dismissible(
          direction: DismissDirection.endToStart,
          dismissThresholds: const {
            DismissDirection.endToStart: 0.2,
          },
          onDismissed: (direction) {
            makingContactViewModel.deleteMessageSupport(
              messageType: messageType,
              id: data.id ?? 0,
            );
          },
          key: Key(data.id.toString()),
          background: Container(
            decoration: const BoxDecoration(color: AppColors.surfaceError),
            child: Container(
              width: 10.w,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              alignment: AlignmentDirectional.centerEnd,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Align(
                    alignment: AlignmentDirectional.centerEnd,
                    child: Image.asset(
                      height: 30,
                      width: 30,
                      Assets.iconsTrash,
                      color: AppColors.iconTertiary,
                    ),
                  ),
                  TextTitleMedium(
                    text: StringConstants.delete,
                    color: AppColors.textTertiary,
                  ),
                ],
              ),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Obx(
              () => Row(
                children: [
                  Checkbox(
                    activeColor: AppColors.surfaceGreen,
                    value: makingContactViewModel.listDelete.any(
                      (element) => element == data.id,
                    ),
                    onChanged: (value) {
                      makingContactViewModel.checkMessage(
                        id: data.id,
                      );
                    },
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextTitleMedium(
                          text: data.helpQuestion ?? "",
                          maxLine: 1,
                        ),
                        TextBodySmall(
                          text: changeDateStringFormat(
                              date: data.createdAt ?? "", format: DateFormatHelper.ymdFormat),
                          color: AppColors.textPrimary.withValues(alpha: 0.5),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
