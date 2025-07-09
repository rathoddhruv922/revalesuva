import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:revalesuva/components/custom_click.dart';
import 'package:revalesuva/components/custom_text.dart';
import 'package:revalesuva/generated/assets.dart';
import 'package:revalesuva/model/tools/intuitive_writing/intuitive_writing_model.dart'
    as intuitive_writing_model;
import 'package:revalesuva/utils/app_colors.dart';
import 'package:revalesuva/utils/app_corner.dart';
import 'package:revalesuva/utils/date_format_helper.dart';
import 'package:revalesuva/utils/helper_method.dart';
import 'package:revalesuva/utils/navigation_helper.dart';
import 'package:revalesuva/utils/strings_constant.dart';
import 'package:revalesuva/view_models/tools/intuitive_writing_view_model.dart';
import 'package:revalesuva/views/tools/intuitive_writing/intuitive_writing_detail_view.dart';

class IntuitiveWritingItem extends StatelessWidget {
  IntuitiveWritingItem({
    super.key,
    required this.data,
    required this.index,
  });

  final intuitive_writing_model.Datum data;
  final int index;
  final IntuitiveWritingViewModel intuitiveWritingViewModel = Get.find<IntuitiveWritingViewModel>();

  @override
  Widget build(BuildContext context) {
    return CustomClick(
      onTap: () async {
        intuitiveWritingViewModel.txtWriting.text = data.description ?? "";
        NavigationHelper.pushScreenWithNavBar(
          widget: IntuitiveWritingDetailView(
            id: data.id ?? 0,
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
            intuitiveWritingViewModel.deleteIntuitiveWriting(
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
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: TextTitleMedium(
                              text: getFirstWords(text: data.description ?? "", length: 5),
                              maxLine: 1,
                            ),
                          ),
                          TextBodySmall(
                            text: changeDateStringFormat(
                                date: data.createdAt ?? "", format: DateFormatHelper.ymdFormat),
                            color: AppColors.textPrimary.withValues(alpha: 0.5),
                            size: -1,
                          ),
                        ],
                      ),
                      TextBodySmall(
                        text: data.description ?? "",
                        color: AppColors.textPrimary.withValues(alpha: 0.5),
                        maxLine: 2,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
