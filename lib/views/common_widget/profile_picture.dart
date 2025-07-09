import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:revalesuva/components/custom_Image_viewer.dart';
import 'package:revalesuva/components/custom_click.dart';
import 'package:revalesuva/generated/assets.dart';
import 'package:revalesuva/view_models/user_view_model.dart';

class ProfilePicture extends StatelessWidget {
  const ProfilePicture({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 10.0),
          child: Container(
            width: 23.w,
            clipBehavior: Clip.hardEdge,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: AspectRatio(
              aspectRatio: 1 / 1,
              child: Obx(
                () => CustomImageViewer(
                  imageUrl: Get.find<UserViewModel>().userData.value.profileImage,
                  errorImage: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Image.asset(
                      Assets.imagesImProfilePlaceholder,
                      width: 5.w,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        CustomClick(
          onTap: () {
            Get.find<UserViewModel>().updateUserProfile();
          },
          child: Image.asset(
            Assets.iconsIcEdit,
            width: 8.w,
          ),
        ),
      ],
    );
  }
}
