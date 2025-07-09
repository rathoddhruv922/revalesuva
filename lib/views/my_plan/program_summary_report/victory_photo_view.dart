import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:revalesuva/components/custom_Image_viewer.dart';
import 'package:revalesuva/components/custom_click.dart';
import 'package:revalesuva/components/custom_text.dart';
import 'package:revalesuva/generated/assets.dart';
import 'package:revalesuva/utils/app_colors.dart';
import 'package:revalesuva/utils/app_corner.dart';
import 'package:revalesuva/utils/helper_method.dart';
import 'package:revalesuva/utils/navigation_helper.dart';
import 'package:revalesuva/utils/strings_constant.dart';
import 'package:revalesuva/view_models/user_view_model.dart';

class VictoryPhotoView extends StatelessWidget {
  VictoryPhotoView({super.key});

  final GlobalKey<State<StatefulWidget>> scr = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        NavigationHelper.onBackScreen(
          widget: VictoryPhotoView(),
        );
      },
      canPop: true,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Gap(10),
              CustomClick(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: TextBodySmall(
                  text: "< ${StringConstants.backTo} ${StringConstants.programSummary}",
                  color: AppColors.textPrimary,
                  letterSpacing: 0,
                ),
              ),
              const Gap(10),
              Row(
                children: [
                  Expanded(
                    child: TextHeadlineMedium(text: StringConstants.myPrograms),
                  ),
                  CustomClick(
                    onTap: () {
                      takeScreenShotAndShareByKey(
                        key: scr,
                        message: StringConstants.amazingSeeYourProgress,
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.surfaceBrand,
                        borderRadius: BorderRadius.circular(
                          AppCorner.button,
                        ),
                      ),
                      child: Row(
                        children: [
                          const ImageIcon(
                            AssetImage(Assets.iconsIcShare),
                            size: 15,
                          ),
                          const Gap(5),
                          TextBodyMedium(
                            text: StringConstants.sharePhoto,
                            color: AppColors.iconPrimary,
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
              const Gap(30),
              Expanded(
                child: RepaintBoundary(
                  key: scr,
                  child: Center(
                    child: AspectRatio(
                      aspectRatio: 3 / 5,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          LayoutBuilder(
                            builder: (context, constraints) {
                              final double bgHeight = constraints.maxHeight;
                              final double bgWeight = constraints.maxWidth;

                              return Container(
                                width: bgWeight * 0.50,
                                height: bgWeight * 0.50,
                                margin: EdgeInsets.only(
                                  bottom: constraints.maxHeight * 0.26,
                                  right: constraints.maxWidth * 0.03,
                                ),
                                child: AspectRatio(
                                  aspectRatio: 1 / 1,
                                  child: Obx(
                                    () => CustomImageViewer(
                                      imageUrl: Get.find<UserViewModel>().userData.value.profileImage,
                                      errorImage: Image.asset(
                                        Assets.imagesImProfilePlaceholder,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                          Image.asset(
                            Assets.imagesBgVictory,
                            fit: BoxFit.fitWidth,
                            width: 100.w,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const Gap(80),
            ],
          ),
        ),
      ),
    );
  }
}
