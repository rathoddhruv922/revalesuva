part of '../body_and_medical_information_view.dart';

class BeforePicturesWidget extends StatelessWidget {
  BeforePicturesWidget({super.key});

  final PersonalProfileViewModel personalProfileViewModel = Get.find<PersonalProfileViewModel>();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: AppColors.surfaceTertiary,
        borderRadius: BorderRadiusDirectional.only(
          bottomStart: Radius.circular(
            AppCorner.editCard,
          ),
          topEnd: Radius.circular(
            AppCorner.editCard,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        textDirection: Get.locale?.languageCode == "he" ? TextDirection.rtl : TextDirection.ltr,
        children: [
          Row(
            children: [
              const ImageIcon(
                AssetImage(Assets.iconsIcBeforePictures),
                size: 20,
              ),
              const Gap(10),
              TextTitleMedium(
                text: StringConstants.beforePhotos,
              ),
            ],
          ),
          const Gap(10),
          Row(
            children: [
              Obx(
                () => ShowBeforePictureWidget(
                  title: StringConstants.front,
                  image: personalProfileViewModel.imgFrontPath.value,
                ),
              ),
              const Gap(20),
              Obx(
                () => ShowBeforePictureWidget(
                  title: StringConstants.side,
                  image: personalProfileViewModel.imgSidePath.value,
                ),
              ),
              const Gap(20),
              Obx(
                () => ShowBeforePictureWidget(
                  title: StringConstants.front,
                  image: personalProfileViewModel.imgBackPath.value,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
