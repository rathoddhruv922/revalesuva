import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:revalesuva/components/custom_click.dart';
import 'package:revalesuva/components/custom_dialog.dart';
import 'package:revalesuva/components/custom_text.dart';
import 'package:revalesuva/generated/assets.dart';
import 'package:revalesuva/model/my_plan/libraries/content_libraries_model.dart'
    as content_libraries_model;
import 'package:revalesuva/utils/app_colors.dart';
import 'package:revalesuva/utils/app_corner.dart';
import 'package:revalesuva/utils/strings_constant.dart';

class ContentItemWidget extends StatelessWidget {
  const ContentItemWidget({
    super.key,
    required this.data,
  });

  final content_libraries_model.Datum data;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColors.surfaceTertiary,
        borderRadius: BorderRadius.circular(AppCorner.listTile),
      ),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                child: TextTitleMedium(
                  text: data.title ?? "",
                  maxLine: 1,
                ),
              ),
            ),
            CustomClick(
              onTap: () {
                if ((data.vimeoVideoId ?? "").isNotEmpty) {
                  CustomDialog.vimeoVideoDialog(
                    videoId: data.vimeoVideoId ?? "",
                  );
                } else {
                  CustomDialog.videoDialog(
                    url: data.video ?? "",
                  );
                }
              },
              child: Container(
                color: AppColors.surfaceBrand,
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(
                    children: [
                      TextBodySmall(
                        text: StringConstants.toWatch,
                        color: AppColors.textPrimary,
                        maxLine: 1,
                      ),
                      const Gap(5),
                      const ImageIcon(
                        AssetImage(Assets.iconsIcPlayBt),
                        size: 20,
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
