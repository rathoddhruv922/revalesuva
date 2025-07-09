part of '../general_Information_view.dart';

class AuthInfoEditWidget extends StatelessWidget {
  AuthInfoEditWidget({super.key, required this.title});

  final String title;
  final PersonalProfileViewModel personalProfileViewModel = Get.find<PersonalProfileViewModel>();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        personalProfileViewModel.isAuthInfoEditable.value = false;
      },
      child: Form(
        key: formKey,
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
                  TextTitleMedium(
                    text: title,
                  ),
                  const Gap(20),
                  Obx(
                    () => InfoDisplayEditWidget(
                      title: StringConstants.email,
                      controller: personalProfileViewModel.txtEmail.value,
                      enabled: false,
                      validator: (value) => FormValidate.requiredField(
                        value,
                        StringConstants.email,
                      ),
                    ),
                  ),
                  const Gap(10),
                  InfoDisplayEditWidget(
                    title: StringConstants.currentPassword,
                    controller: personalProfileViewModel.txOldPassword.value,
                    validator: (value) => FormValidate.requiredField(
                      value,
                      StringConstants.currentPassword,
                    ),
                  ),
                  const Gap(10),
                  InfoDisplayEditWidget(
                    title: StringConstants.newPassword,
                    controller: personalProfileViewModel.txNewPassword.value,
                    validator: (value) => FormValidate.requiredField(
                      value,
                      StringConstants.newPassword,
                    ),
                  ),
                ],
              ),
            ),
            const Gap(20),
            SimpleButton(
              text: StringConstants.saveChanges,
              onPressed: () {
                if (formKey.currentState?.validate() ?? false) {
                  personalProfileViewModel.changePassword();
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
