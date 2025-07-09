import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:revalesuva/components/custom_button.dart';
import 'package:revalesuva/components/custom_click.dart';
import 'package:revalesuva/components/custom_text.dart';
import 'package:revalesuva/generated/assets.dart';
import 'package:revalesuva/utils/app_colors.dart';
import 'package:revalesuva/utils/helper_method.dart';
import 'package:revalesuva/utils/navigation_helper.dart';
import 'package:revalesuva/utils/strings_constant.dart';
import 'package:revalesuva/view_models/user_view_model.dart';
import 'package:revalesuva/views/my_plan/program_completion_report/thank_you_for_participating_view.dart';
import 'package:revalesuva/views/my_plan/program_completion_report/widget/see_your_image_item_widget.dart';

class SeeYourProgressView extends StatefulWidget {
  const SeeYourProgressView({super.key});

  @override
  State<SeeYourProgressView> createState() => _SeeYourProgressViewState();
}

class _SeeYourProgressViewState extends State<SeeYourProgressView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        await Get.find<UserViewModel>().getUserPictures();
      },
    );
  }
   GlobalKey<State<StatefulWidget>> scr = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        NavigationHelper.onBackScreen(
          widget: const SeeYourProgressView(),
        );
      },
      canPop: true,
      child: Scaffold(
        body: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
          children: [
            CustomCard2(
              color: AppColors.surfaceTertiary,
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: TextHeadlineMedium(
                          text: StringConstants.amazingSeeYourProgress,
                        ),
                      ),
                      CustomClick(
                        onTap: () {
                          takeScreenShotAndShareByKey(
                            key: scr,
                            message: StringConstants.amazingSeeYourProgress,
                          );
                        },
                        child: Row(
                          children: [
                            const ImageIcon(
                              AssetImage(Assets.iconsIcShare),
                              size: 15,
                            ),
                            const Gap(5),
                            TextBodyMedium(
                              text: StringConstants.share,
                              color: AppColors.iconPrimary,
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  const Gap(20),
                  RepaintBoundary(
                    key: scr,
                    child: Container(
                      margin: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        image: const DecorationImage(
                          image: AssetImage(Assets.imagesBgAfterBefore),
                        ),
                        borderRadius: BorderRadius.circular(5)
                      ),
                      child: Obx(
                        () => AspectRatio(
                          aspectRatio: 1 / 1,
                          child: Column(
                            children: [
                              const Gap(60),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10.0,
                                ),
                                child: Row(
                                  children: [
                                    SeeYourImageItemWidget(
                                      imageUrl: Get.find<UserViewModel>().userBeforeFrontPicURL.value,
                                      errorImage: Assets.imagesImFront,
                                    ),
                                    const Gap(10),
                                    SeeYourImageItemWidget(
                                      imageUrl: Get.find<UserViewModel>().userBeforeSidePicURL.value,
                                      errorImage: Assets.imagesImSide,
                                    ),
                                    const Gap(10),
                                    SeeYourImageItemWidget(
                                      imageUrl: Get.find<UserViewModel>().userBeforeBackPicURL.value,
                                      errorImage: Assets.imagesImBack,
                                    ),
                                  ],
                                ),
                              ),
                              const Gap(5),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                child: Row(
                                  children: [
                                    SeeYourImageItemWidget(
                                      imageUrl: Get.find<UserViewModel>().userAfterFrontPicURL.value,
                                      errorImage: Assets.imagesImFront,
                                    ),
                                    const Gap(10),
                                    SeeYourImageItemWidget(
                                      imageUrl: Get.find<UserViewModel>().userAfterSidePicURL.value,
                                      errorImage: Assets.imagesImSide,
                                    ),
                                    const Gap(10),
                                    SeeYourImageItemWidget(
                                      imageUrl: Get.find<UserViewModel>().userAfterBackPicURL.value,
                                      errorImage: Assets.imagesImBack,
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
                ],
              ),
            ),
            const Gap(20),
            CustomIconButton(
              onPressed: () {
                NavigationHelper.pushReplaceScreenWithNavBar(
                    widget: const ThankYouForParticipatingView(), context: context);
              },
              text: StringConstants.howDoWeProceedNow,
              icon: Icons.arrow_forward_ios,
            ),
            const Gap(50),
          ],
        ),
      ),
    );
  }
}
