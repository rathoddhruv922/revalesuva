import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:revalesuva/components/custom_text.dart';
import 'package:revalesuva/utils/app_colors.dart';
import 'package:revalesuva/utils/strings_constant.dart';

class CustomImagePicker {
  CustomImagePicker._();

  static Future<String> pickFromBoth() async {
    Completer<String> completer = Completer<String>();
    var imagePath = "";
    await Get.dialog(
      barrierDismissible: true,
      Dialog(
        backgroundColor: AppColors.surfacePrimary,
        child: IntrinsicHeight(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () async {
                    if (Get.isDialogOpen ?? false) {
                      Get.back();
                    }
                    var status = await Permission.camera.status;
                    if (status.isDenied) {
                      await Permission.camera.request();
                    }
                    if (await Permission.camera.isPermanentlyDenied) {
                      openAppSettings();
                    }

                    if (await Permission.camera.isGranted) {
                      var picker = ImagePicker();
                      var image = await picker.pickImage(source: ImageSource.camera);
                      if (image != null) {
                        imagePath = image.path;
                        completer.complete(imagePath);
                      }
                    }
                  },
                  child: Container(
                    color: Colors.transparent,
                    width: double.infinity,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Gap(20),
                        const Icon(
                          Icons.camera_alt_outlined,
                          color: AppColors.iconPrimary,
                          size: 35,
                        ),
                        const Gap(10),
                        TextTitleMedium(
                          text: StringConstants.camera,
                          color: AppColors.textPrimary,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: VerticalDivider(
                  color: AppColors.iconPrimary,
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () async {
                    if (Get.isDialogOpen ?? false) {
                      Get.back();
                    }
                    var picker = ImagePicker();
                    var image = await picker.pickImage(source: ImageSource.gallery);
                    if (image != null) {
                      imagePath = image.path;
                      completer.complete(imagePath);
                    }
                  },
                  child: Container(
                    color: Colors.transparent,
                    width: double.infinity,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        const Icon(
                          Icons.image,
                          color: AppColors.iconPrimary,
                          size: 35,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextTitleMedium(
                          text: StringConstants.gallery,
                          color: AppColors.textPrimary,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
    return completer.future;
  }
}
