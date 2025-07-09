import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:revalesuva/components/custom_Image_viewer.dart';
import 'package:revalesuva/generated/assets.dart';
import 'package:revalesuva/utils/app_colors.dart';
import 'package:revalesuva/utils/helper_method.dart';
import 'package:revalesuva/view_models/home/home_view_model.dart';
import 'package:revalesuva/view_models/personal_detail/common_media_view_model.dart';
import 'package:revalesuva/view_models/user_view_model.dart';
import 'package:revalesuva/views/common_widget/profile_picture.dart';
import 'package:url_launcher/url_launcher.dart';

customAppBar({bool hideProfile = false}) {
  return AppBar(
    centerTitle: true,
    scrolledUnderElevation: 0.0,
    title: Padding(
      padding: const EdgeInsets.only(bottom: 0.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Gap(20),
          Image.asset(
            Assets.imagesLogo,
            width: 40.w,
          ),
          const Gap(20),
          Opacity(
            opacity: hideProfile ? 1 : 0,
            child: const ProfilePicture(),
          ),
        ],
      ),
    ),
    leading: const SizedBox(),
    flexibleSpace: AspectRatio(
      aspectRatio: 8 / 5,
      child: Image.asset(
        width: 100.w,
        Assets.imagesHeader,
        fit: BoxFit.cover,
      ),
    ),
    toolbarHeight: 230,
  );
}

customAppBar2(
    {bool hideProfile = false,
    required GlobalKey<ScaffoldState> key,
    required Function() onMessageTap}) {
  return AppBar(
    scrolledUnderElevation: 0.0,
    leading: const SizedBox.shrink(),
    leadingWidth: 200,
    titleSpacing: 0,
    flexibleSpace: Stack(
      fit: StackFit.expand,
      children: [
        Obx(
          () {
            return AspectRatio(
              aspectRatio: 8 / 5,
              child: Image.asset(
                Get.find<HomeViewModel>().isIceDeepScreen.isTrue
                    ? Assets.imagesMainHeaderBlue
                    : Assets.imagesMainHeader,
                fit: BoxFit.fill,
              ),
            );
          },
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          margin: const EdgeInsets.only(top: 10),
          child: SafeArea(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 15.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () {
                          key.currentState!.openDrawer();
                        },
                        child: const ImageIcon(
                          AssetImage(Assets.iconsIcSideNav),
                          color: AppColors.iconTertiary,
                          size: 24,
                        ),
                      ),
                      const Gap(15),
                      Image.asset(
                        Assets.imagesLogoSimple,
                        height: 33,
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                Row(
                  children: [
                    InkWell(
                      onTap: () async {
                        var data = Get.find<CommonMediaViewModel>().getCmsData(slug: "call-us");
                        String plainText = removeHtmlTags(data?.description ?? "");
                        final Uri phoneUri = Uri(
                          scheme: 'tel',
                          path: plainText,
                        );
                        if (!await launchUrl(phoneUri)) {
                          throw Exception('Could not launch $phoneUri');
                        }
                      },
                      child: const ImageIcon(
                        AssetImage(Assets.iconsIcPhone),
                        color: AppColors.iconTertiary,
                        size: 22,
                      ),
                    ),
                    const Gap(10),
                    InkWell(
                      onTap: onMessageTap,
                      child: const ImageIcon(
                        AssetImage(Assets.iconsIcMessage),
                        color: AppColors.iconTertiary,
                        size: 22,
                      ),
                    ),
                    const Gap(10),
                    Container(
                      width: 45,
                      height: 45,
                      clipBehavior: Clip.hardEdge,
                      decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.white),
                      child: AspectRatio(
                        aspectRatio: 1 / 1,
                        child: Obx(
                          () => CustomImageViewer(
                            imageUrl: Get.find<UserViewModel>().userData.value.profileImage,
                            errorImage: Image.asset(Assets.imagesImProfilePlaceholder),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    ),
    toolbarHeight: 110,
  );
}

customAppBarTrainer(
    {bool hideProfile = false,
    required GlobalKey<ScaffoldState> key}) {
  return AppBar(
    scrolledUnderElevation: 0.0,
    leading: const SizedBox.shrink(),
    leadingWidth: 200,
    titleSpacing: 0,
    flexibleSpace: Stack(
      fit: StackFit.expand,
      children: [
        AspectRatio(
          aspectRatio: 8 / 5,
          child: Image.asset(
            Assets.imagesMainHeader,
            fit: BoxFit.fill,
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          margin: const EdgeInsets.only(top: 10),
          child: SafeArea(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 15.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () {
                          key.currentState!.openDrawer();
                        },
                        child: const ImageIcon(
                          AssetImage(Assets.iconsIcSideNav),
                          color: AppColors.iconTertiary,
                          size: 24,
                        ),
                      ),
                      const Gap(15),
                      Image.asset(
                        Assets.imagesLogoSimple,
                        height: 33,
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                Row(
                  children: [
                    InkWell(
                      onTap: () async {
                        var data = Get.find<CommonMediaViewModel>().getCmsData(slug: "call-us");
                        String plainText = removeHtmlTags(data?.description ?? "");
                        final Uri phoneUri = Uri(
                          scheme: 'tel',
                          path: plainText,
                        );
                        if (!await launchUrl(phoneUri)) {
                          throw Exception('Could not launch $phoneUri');
                        }
                      },
                      child: const ImageIcon(
                        AssetImage(Assets.iconsIcPhone),
                        color: AppColors.iconTertiary,
                        size: 22,
                      ),
                    ),
                    const Gap(10),
                    Container(
                      width: 45,
                      height: 45,
                      clipBehavior: Clip.hardEdge,
                      decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.white),
                      child: AspectRatio(
                        aspectRatio: 1 / 1,
                        child: Obx(
                          () => CustomImageViewer(
                            imageUrl: Get.find<UserViewModel>().userData.value.profileImage,
                            errorImage: Image.asset(Assets.imagesImProfilePlaceholder),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    ),
    toolbarHeight: 110,
  );
}
