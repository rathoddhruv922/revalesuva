import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:revalesuva/components/custom_Image_viewer.dart';
import 'package:revalesuva/components/custom_click.dart';
import 'package:revalesuva/components/custom_text.dart';
import 'package:revalesuva/generated/assets.dart';
import 'package:revalesuva/utils/app_colors.dart';
import 'package:revalesuva/utils/app_corner.dart';

class ShowBeforePictureWidget extends StatelessWidget {
  const ShowBeforePictureWidget({super.key, required this.image, required this.title});

  final String image;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: CustomClick(
        onTap: () {},
        child: Column(
          textDirection: Get.locale?.languageCode == "he" ? TextDirection.rtl : TextDirection.ltr,
          children: [
            Container(
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                color: AppColors.borderBrand,
                borderRadius: BorderRadius.circular(AppCorner.cardBoarder),
              ),
              child: AspectRatio(
                aspectRatio: 1 / 1,
                child: CustomImageViewer(
                  imageUrl: image,
                  errorImage: Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: Image.asset(
                      Assets.imagesPlaceholderImg,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            const Gap(5),
            TextHeadlineSmall(text: title)
          ],
        ),
      ),
    );
  }
}
