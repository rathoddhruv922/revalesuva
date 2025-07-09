part of '../general_Information_view.dart';

class AuthInfoWidget extends StatelessWidget {
  AuthInfoWidget({super.key});

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
            title: StringConstants.loginDetails,
            onTab: () {
              personalProfileViewModel.isAuthInfoEditable.value = true;
            },
          ),
          const Gap(10),
          Obx(
            () => InfoDisplayWidget(
              title: StringConstants.email,
              value: personalProfileViewModel.txtEmail.value.text,
            ),
          ),
          const Gap(10),
          InfoDisplayWidget(
            title: StringConstants.password,
            value: "********",
          ),
          const Gap(10),
          personalProfileViewModel.isShowPasswordChangesMeg.isTrue
              ? TextBodySmall(
                  text: StringConstants.passwordChangeMessage,
                  color: AppColors.iconRed,
                )
              : const SizedBox()
        ],
      ),
    );
  }
}
