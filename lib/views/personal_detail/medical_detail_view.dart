part of 'personal_details_screen.dart';

class MedicalDetailView extends StatelessWidget {
  MedicalDetailView({super.key});

  final PersonalDetailsViewModel personalDetailsViewModel = Get.find<PersonalDetailsViewModel>();
  final formKeyPersonalDetail2 = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKeyPersonalDetail2,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          textDirection: Get.locale?.languageCode == "he" ? TextDirection.rtl : TextDirection.ltr,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            TextTitleMedium(text: StringConstants.personalDetail2Title),
            TextLabelSmall(text: StringConstants.personalDetail2Message),
            const Gap(20),
            CustomTextField(
              hint: StringConstants.initialWeight,
              controller: personalDetailsViewModel.txtInitialWeight,
              inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d+(\.\d{0,2})?$'))],
              textInputType: TextInputType.number,
              suffixIcon: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: TextTitleSmall(text: "kg"),
              ),
              validator: (value) => FormValidate.requiredField(value, StringConstants.initialWeight),
            ),
            const Gap(10),
            CustomTextField(
              hint: StringConstants.height,
              controller: personalDetailsViewModel.txtHeight,
              inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d+(\.\d{0,2})?$'))],
              textInputType: TextInputType.number,
              suffixIcon: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: TextTitleSmall(text: "cm"),
              ),
              validator: (value) => FormValidate.requiredField(value, StringConstants.height),
            ),
            const Gap(10),
            CustomClick(
              onTap: () {
                personalDetailsViewModel.selectBloodReport();
              },
              child: CustomTextFieldWithButton(
                enabled: false,
                hint: StringConstants.uploadBloodTests,
                controller: personalDetailsViewModel.txtUploadBloodTests,
                suffixIcon: Container(
                  decoration: const BoxDecoration(
                    color: AppColors.brand,
                    borderRadius: BorderRadiusDirectional.only(
                      topEnd: Radius.circular(AppCorner.textField),
                      bottomEnd: Radius.circular(AppCorner.textField),
                    ),
                  ),
                  child: const Icon(
                    Icons.add,
                    color: AppColors.iconPrimary,
                    size: 30,
                  ),
                ),
              ),
            ),
            const Gap(30),
            Row(
              textDirection: Get.locale?.languageCode == "he" ? TextDirection.rtl : TextDirection.ltr,
              children: [
                Expanded(
                  child: TextHeadlineMedium(text: StringConstants.measurements),
                ),
                const Gap(10),
                Expanded(
                  child: Align(
                    alignment: AlignmentDirectional.centerEnd,
                    child: CustomTextButton(
                      onPressed: () {
                        if(Get.find<CommonMediaViewModel>().howToMeasureVideoId.value.isNotEmpty){
                          CustomDialog.vimeoVideoDialog(
                            videoId: Get.find<CommonMediaViewModel>().howToMeasureVideoId.value,
                          );
                        }else{
                          CustomDialog.videoDialog(
                            url: Get.find<CommonMediaViewModel>().howToMeasure.value,
                          );
                        }

                      },
                      text: StringConstants.howToMeasure,
                      underline: true,
                    ),
                  ),
                )
              ],
            ),
            const Gap(10),
            CustomTextField(
              hint: StringConstants.chestCircumference,
              controller: personalDetailsViewModel.txtChestCircumference,
              inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d+(\.\d{0,2})?$'))],
              suffixIcon: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: TextTitleSmall(text: "cm"),
              ),
              validator: (value) =>
                  FormValidate.requiredField(value, StringConstants.chestCircumference),
            ),
            const Gap(10),
            CustomTextField(
              hint: StringConstants.abdominalCircumference,
              controller: personalDetailsViewModel.txtWaistCircumference,
              inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d+(\.\d{0,2})?$'))],
              suffixIcon: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: TextTitleSmall(text: "cm"),
              ),
              validator: (value) =>
                  FormValidate.requiredField(value, StringConstants.abdominalCircumference),
            ),
            const Gap(10),
            CustomTextField(
              hint: StringConstants.hipCircumference,
              controller: personalDetailsViewModel.txtHipCircumference,
              inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d+(\.\d{0,2})?$'))],
              suffixIcon: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: TextTitleSmall(text: "cm"),
              ),
              validator: (value) => FormValidate.requiredField(value, StringConstants.hipCircumference),
            ),
            const Gap(20),
            Row(
              textDirection: Get.locale?.languageCode == "he" ? TextDirection.rtl : TextDirection.ltr,
              children: [
                Expanded(
                  child: TextHeadlineMedium(text: StringConstants.beforePhotos),
                ),
                const Gap(10),
                Expanded(
                  child: Align(
                    alignment: AlignmentDirectional.centerEnd,
                    child: CustomTextButton(
                      onPressed: () {
                        if(Get.find<CommonMediaViewModel>().howToTakeVideoId.value.isNotEmpty){
                          CustomDialog.vimeoVideoDialog(
                            videoId: Get.find<CommonMediaViewModel>().howToTakeVideoId.value,
                          );
                        }else{
                          CustomDialog.videoDialog(
                            url: Get.find<CommonMediaViewModel>().howToTakeUrl.value,
                          );
                        }

                      },
                      text: StringConstants.howToTakePhotos,
                      underline: true,
                    ),
                  ),
                )
              ],
            ),
            const Gap(20),
            Row(
              textDirection: Get.locale?.languageCode == "he" ? TextDirection.rtl : TextDirection.ltr,
              children: [
                Obx(
                  () => PictureWidget(
                    title: StringConstants.front,
                    image: personalDetailsViewModel.imgFrontPath.value,
                    defaultImage: Assets.imagesImFront,
                    onTap: () async {
                      personalDetailsViewModel.imgFrontPath.value =
                          await CustomImagePicker.pickFromBoth();
                    },
                  ),
                ),
                const Gap(10),
                Obx(
                  () => PictureWidget(
                    title: StringConstants.side,
                    image: personalDetailsViewModel.imgSidePath.value,
                    defaultImage: Assets.imagesImSide,
                    onTap: () async {
                      personalDetailsViewModel.imgSidePath.value =
                          await CustomImagePicker.pickFromBoth();
                    },
                  ),
                ),
                const Gap(10),
                Obx(
                  () => PictureWidget(
                    title: StringConstants.back,
                    image: personalDetailsViewModel.imgBackPath.value,
                    defaultImage: Assets.imagesImBack,
                    onTap: () async {
                      personalDetailsViewModel.imgBackPath.value =
                          await CustomImagePicker.pickFromBoth();
                    },
                  ),
                ),
              ],
            ),
            const Gap(30),
            Row(
              textDirection: Get.locale?.languageCode == "he" ? TextDirection.rtl : TextDirection.ltr,
              children: [
                CustomTextButton(
                  onPressed: () {
                    personalDetailsViewModel.onPreviousStepClick();
                  },
                  text: StringConstants.previousStep,
                  icon: Icons.arrow_back_ios,
                  underline: false,
                ),
                const Spacer(),
                CustomIconButton(
                  onPressed: () {
                    if (formKeyPersonalDetail2.currentState?.validate() ?? false) {
                      if (personalDetailsViewModel.imgBackPath.value.isEmpty ||
                          personalDetailsViewModel.imgSidePath.value.isEmpty ||
                          personalDetailsViewModel.imgFrontPath.value.isEmpty) {
                        showToast(
                            msg:
                                "${StringConstants.back},  ${StringConstants.side},  ${StringConstants.front} ${StringConstants.required}");
                      } else {
                        personalDetailsViewModel.updateUserData();
                      }
                    }
                  },
                  text: StringConstants.nextStep,
                  icon: Icons.arrow_forward_ios,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
