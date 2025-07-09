part of '../body_and_medical_information_view.dart';

class BodyDataEditWidget extends StatelessWidget {
  BodyDataEditWidget({super.key, required this.title});

  final String title;
  final PersonalProfileViewModel personalProfileViewModel = Get.find<PersonalProfileViewModel>();

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        personalProfileViewModel.isBodyInfoEditable.value = false;
      },
      child: Column(
        textDirection: Get.locale?.languageCode == "he" ? TextDirection.rtl : TextDirection.ltr,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
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
                      AssetImage(Assets.iconsIcBody),
                      size: 20,
                    ),
                    const Gap(10),
                    Expanded(
                      child: TextTitleMedium(
                        text: StringConstants.beforePhotos,
                      ),
                    ),
                  ],
                ),
                const Gap(20),
                InfoDisplayEditWidget(
                  title: StringConstants.weight,
                  controller: personalProfileViewModel.txtWeight.value,
                  inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d+(\.\d{0,2})?$'))],
                ),
                const Gap(10),
                InfoDisplayEditWidget(
                  title: StringConstants.height,
                  controller: personalProfileViewModel.txtHeight.value,
                  inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d+(\.\d{0,2})?$'))],
                ),
                const Gap(10),
                InfoDisplayEditWidget(
                  title: StringConstants.chestCircumference,
                  controller: personalProfileViewModel.txtChest.value,
                  inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d+(\.\d{0,2})?$'))],
                ),
                const Gap(10),
                InfoDisplayEditWidget(
                  title: StringConstants.abdominalCircumference,
                  controller: personalProfileViewModel.txtWaist.value,
                  inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d+(\.\d{0,2})?$'))],
                ),
                const Gap(10),
                InfoDisplayEditWidget(
                  title: StringConstants.hipCircumference,
                  controller: personalProfileViewModel.txtHip.value,
                  inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d+(\.\d{0,2})?$'))],
                ),
                const Gap(10),
                Row(
                  children: [
                    Expanded(
                      child: CustomTextButtonWithIcon(
                        onPressed: () {
                          NavigationHelper.pushScreenWithNavBar(widget: const BloodReportListView(), context: context);
                        },
                        text: StringConstants.viewingBloodTestForm,
                        underline: true,
                        icon: Assets.iconsIcEye,
                        size: -1,
                      ),
                    ),
                    Expanded(
                      child: Obx(
                        () => Get.find<UserViewModel>().gender.toLowerCase() == "female"
                            ? CustomTextButtonWithIcon(
                                onPressed: () {
                                  NavigationHelper.pushScreenWithNavBar(
                                      widget: const OvulationCalculatorView(), context: context);
                                },
                                text: StringConstants.enterOvulationCalculator,
                                underline: true,
                                icon: Assets.iconsIcOvulationCalculator,
                                size: -1,
                              )
                            : const SizedBox(),
                      ),
                    ),
                  ],
                ),
                const Gap(20),
                Row(
                  children: [
                    CustomIconButton(
                      text: "",
                      width: 45,
                      onPressed: () {
                        personalProfileViewModel.selectBloodReport();
                      },
                      icon: Icons.add,
                      iconSize: 20,
                    ),
                    const Gap(10),
                    Flexible(
                      child: Column(
                        children: [
                          TextBodySmall(
                            text: StringConstants.uploadBloodTests,
                            color: AppColors.textPrimary,
                          ),
                          Obx(
                            () => TextBodySmall(
                              text: personalProfileViewModel.uploadBloodTests.value,
                              color: AppColors.textSecondary,
                              size: -3,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          const Gap(20),
          SimpleButton(
            text: StringConstants.saveChanges,
            onPressed: () {
              personalProfileViewModel.updateBodyDetailInfo();
            },
          )
        ],
      ),
    );
  }
}
