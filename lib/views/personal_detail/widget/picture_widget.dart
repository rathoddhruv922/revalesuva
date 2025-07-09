part of '../personal_details_screen.dart';

class PictureWidget extends StatelessWidget {
  const PictureWidget({
    super.key,
    required this.image,
    required this.title,
    required this.defaultImage,
    this.onTap,
  });

  final String image;
  final String title;
  final String defaultImage;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: CustomClick(
        onTap: onTap,
        child: Column(
          textDirection: Get.locale?.languageCode == "he" ? TextDirection.rtl : TextDirection.ltr,
          children: [
            AspectRatio(
              aspectRatio: 1 / 1,
              child: Container(
                clipBehavior: Clip.hardEdge,
                margin: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                    color: AppColors.surfaceTertiary,
                    borderRadius: BorderRadius.circular(AppCorner.cardBoarder),
                    border: Border.all(color: AppColors.borderLightGray)),
                child: CustomImageViewer(
                  imagePath: image,
                  errorImage: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Image.asset(
                      defaultImage,
                      width: 5.w,
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
