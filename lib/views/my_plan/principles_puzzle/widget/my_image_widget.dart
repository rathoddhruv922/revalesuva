import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:revalesuva/components/custom_Image_viewer.dart';
import 'package:revalesuva/generated/assets.dart';
import 'package:revalesuva/view_models/user_view_model.dart';

class MyImageWidget extends StatelessWidget {
   MyImageWidget({super.key});
  final GlobalKey _globalKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: AspectRatio(
        aspectRatio: 3 / 5,
        child: Stack(
          alignment: Alignment.center,
          children: [
            LayoutBuilder(
              builder: (context, constraints) {
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
              width: MediaQuery.of(context).size.width,
            ),
          ],
        ),
      ),
    );
  }
}
