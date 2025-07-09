part of '../body_and_medical_information_view.dart';

class BodyDataWidget extends StatelessWidget {
  BodyDataWidget({super.key});

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
        textDirection: Get.locale?.languageCode == "he" ? TextDirection.rtl : TextDirection.ltr,
        children: [
          EditButtonWidget(
            title: StringConstants.bodyData,
            onTab: () {
              personalProfileViewModel.isBodyInfoEditable.value = true;
            },
            icon: Assets.iconsIcBody,
          ),
          const Gap(10),
          Obx(
            () => InfoDisplayWidget(
              title: StringConstants.initialWeight,
              value: personalProfileViewModel.txtWeight.value.text,
            ),
          ),
          const Gap(10),
          Obx(
            () => InfoDisplayWidget(
              title: StringConstants.height,
              value: personalProfileViewModel.txtHeight.value.text,
            ),
          ),
          const Gap(10),
          Obx(
            () => InfoDisplayWidget(
              title: StringConstants.chestCircumference,
              value: personalProfileViewModel.txtChest.value.text,
            ),
          ),
          const Gap(10),
          Obx(
            () => InfoDisplayWidget(
              title: StringConstants.abdominalCircumference,
              value: personalProfileViewModel.txtWaist.value.text,
            ),
          ),
          const Gap(10),
          Obx(
            () => InfoDisplayWidget(
              title: StringConstants.hipCircumference,
              value: personalProfileViewModel.txtHip.value.text,
            ),
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
          )
        ],
      ),
    );
  }
}
