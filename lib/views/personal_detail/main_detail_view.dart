part of 'personal_details_screen.dart';

class MainDetailView extends StatelessWidget {
  MainDetailView({super.key});

  final PersonalDetailsViewModel personalDetailsViewModel = Get.find<PersonalDetailsViewModel>();
  final formKeyPersonalDetail1 = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKeyPersonalDetail1,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          textDirection: Get.locale?.languageCode == "he" ? TextDirection.rtl : TextDirection.ltr,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            TextHeadlineLarge(text: "${StringConstants.hi} ${Get.find<UserViewModel>().userData.value.name}!"),
            TextLabelSmall(text: StringConstants.personalDetailMessage),
            const Gap(10),
            CustomTextField(
              hint: StringConstants.name,
              controller: personalDetailsViewModel.txtName,
              validator: (value) => FormValidate.requiredField(value, StringConstants.name),
            ),
            const Gap(10),
            CustomTextField(
              hint: StringConstants.phoneNumber,
              controller: personalDetailsViewModel.txtPhoneNo,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              textInputType: TextInputType.number,
              validator: (value) => FormValidate.requiredField(value, StringConstants.phoneNumber),
            ),
            // const Gap(10),
            // CustomTextField(
            //   fillColor: personalDetailsViewModel.txtUserName.text.isNotEmpty ? AppColors.lightGray : null,
            //   enabled: personalDetailsViewModel.txtUserName.text.isNotEmpty ? false : true,
            //   hint: StringConstants.username,
            //   controller: personalDetailsViewModel.txtUserName,
            //   validator: (value) => FormValidate.requiredField(value, StringConstants.username),
            // ),
            const Gap(100),
            Align(
              alignment: AlignmentDirectional.centerEnd,
              child: CustomIconButton(
                onPressed: () {
                  // if (formKeyPersonalDetail1.currentState?.validate() ?? false) {
                  //   personalDetailsViewModel.checkUserName();
                  // }
                  personalDetailsViewModel.onNextStepClick();
                },
                icon: Icons.arrow_forward_ios,
                text: StringConstants.nextStep,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
