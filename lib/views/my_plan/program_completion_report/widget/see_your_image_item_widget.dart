import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:revalesuva/components/custom_Image_viewer.dart';
import 'package:revalesuva/utils/app_colors.dart';
import 'package:revalesuva/utils/app_corner.dart';

class SeeYourImageItemWidget extends StatelessWidget {
  const SeeYourImageItemWidget({super.key, required this.imageUrl, required this.errorImage});

  final String imageUrl;
  final String errorImage;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
            color: AppColors.surfaceTertiary,
            borderRadius: BorderRadius.circular(AppCorner.listTileImage)),
        child: AspectRatio(
          aspectRatio: 10 / 13,
          child: CustomImageViewer(
            imageUrl: imageUrl,
            errorImage: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Image.asset(
                errorImage,
                width: 5.w,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
