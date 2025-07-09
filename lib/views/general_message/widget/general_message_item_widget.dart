import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
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
import 'package:revalesuva/views/general_message/general_message_detail_view.dart';

class GeneralMessageItemWidget extends StatelessWidget {
  GeneralMessageItemWidget(
      {super.key, required this.data, required this.index, required this.messageType});

  final general_message_model.Datum data;
  final int index;
  final String messageType;
  final GeneralMessageViewModel generalMessageViewModel = Get.find<GeneralMessageViewModel>();

  @override
  Widget build(BuildContext context) {
    return CustomClick(
      onTap: () async {
        await generalMessageViewModel.markGeneralMessageRead(id: data.id ?? 0, status: true);
        if (context.mounted) {
          NavigationHelper.pushScreenWithNavBar(
            widget: GeneralMessageDetailView(
              data: data,
            ),
            context: context,
          );
        }
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
            generalMessageViewModel.deleteGeneralMessage(
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
                    value: generalMessageViewModel.listAction.any(
                      (element) => element == data.id,
                    ),
                    onChanged: (value) {
                      generalMessageViewModel.checkMessage(
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
                          text: data.title ?? "",
                          maxLine: 1,
                          weight: data.user?.pivot?.isRead != 1 ? 3 : 0,
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
