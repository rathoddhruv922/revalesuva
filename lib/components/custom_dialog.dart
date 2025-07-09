import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:revalesuva/components/custom_button.dart';
import 'package:revalesuva/components/custom_text.dart';
import 'package:revalesuva/components/video_media_player.dart';
import 'package:revalesuva/components/vimeo_player.dart';
import 'package:revalesuva/generated/assets.dart';
import 'package:revalesuva/utils/app_colors.dart';
import 'package:revalesuva/utils/app_corner.dart';
import 'package:revalesuva/utils/strings_constant.dart';

import '../utils/helper_method.dart';

class CustomDialog {
  CustomDialog._();

  static positiveNegativeButtons({
    required String title,
    required void Function() onNegativePressed,
    required void Function() onPositivePressed,
  }) {
    Get.dialog(BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
      child: Dialog(
        elevation: 0,
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextTitleMedium(
                text: title,
                textAlign: TextAlign.center,
              ),
              const Gap(30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: SimpleButton(
                      width: 20.w,
                      text: StringConstants.no,
                      onPressed: onNegativePressed,
                    ),
                  ),
                  const Gap(20),
                  Flexible(
                    child: SimpleButton(
                      width: 20.w,
                      text: StringConstants.yes,
                      onPressed: onPositivePressed,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ));
  }

  static videoDialog({required String url}) {
    Get.dialog(
      BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
        child: Dialog(
          backgroundColor: Colors.transparent,
          child: StatefulBuilder(
            builder: (context, setState) => Stack(
              alignment: AlignmentDirectional.topEnd,
              children: [
                VideoMediaPlayer(
                  videoUrl: url,
                ),
                InkWell(
                  onTap: () {
                    if (Get.isDialogOpen ?? false) {
                      Get.back();
                    }
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(10),
                    child: ImageIcon(
                      AssetImage(Assets.iconsIcClose),
                      color: AppColors.iconSecondary,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  static vimeoVideoDialog({required String videoId}) {
    Get.dialog(
      BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
        child: Dialog(
          backgroundColor: Colors.transparent,
          child: StatefulBuilder(
            builder: (context, setState) => Stack(
              alignment: AlignmentDirectional.topEnd,
              children: [
                VimeoPlayer(
                  videoId: videoId,
                ),
                InkWell(
                  onTap: () {
                    if (Get.isDialogOpen ?? false) {
                      Get.back();
                    }
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(10),
                    child: ImageIcon(
                      AssetImage(Assets.iconsIcClose),
                      color: AppColors.iconSecondary,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  static imageDialog({required String url}) {
    Get.dialog(
      BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
        child: Dialog(
          backgroundColor: Colors.transparent,
          child: Stack(
            children: [
              Container(
                width: 100.w,
                height: 100.w,
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  color: AppColors.borderLightGray,
                  borderRadius: BorderRadius.circular(AppCorner.listTileImage),
                ),
                child: PhotoView(
                  strictScale: true,
                  gaplessPlayback: true,
                  tightMode: true,
                  filterQuality: FilterQuality.high,
                  backgroundDecoration: const BoxDecoration(
                    color: Colors.transparent,
                  ),
                  imageProvider: CachedNetworkImageProvider(
                    url,
                    errorListener: (p0) {
                      showToast(msg: p0.toString());
                    },
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  if (Get.isDialogOpen ?? false) {
                    Get.back();
                  }
                },
                child: const Padding(
                  padding: EdgeInsets.all(10),
                  child: ImageIcon(
                    AssetImage(Assets.iconsIcClose),
                    color: AppColors.iconSecondary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
