import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:revalesuva/components/custom_appbar.dart';
import 'package:revalesuva/components/custom_button.dart';
import 'package:revalesuva/components/custom_text.dart';
import 'package:revalesuva/components/custom_text_field.dart';
import 'package:revalesuva/utils/app_colors.dart';
import 'package:revalesuva/utils/router.dart';
import 'package:revalesuva/utils/strings_constant.dart';
import 'package:revalesuva/view_models/forgot_password/forgot_password_view_model.dart';

class VerifyOtpView extends StatelessWidget {
  VerifyOtpView({super.key});

  final formKey = GlobalKey<FormState>();
  final ForgotPasswordViewModel forgotPasswordViewModel = Get.find<ForgotPasswordViewModel>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 35.0,
        ),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Form(
            key: formKey,
            child: Column(
              textDirection: Get.locale?.languageCode == "he" ? TextDirection.rtl : TextDirection.ltr,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Gap(30),
                TextBodySmall(
                  text: StringConstants.otpIsBeingSentToYourEmailPleaseCheckYourEmailAndFillItIn,
                  color: AppColors.textPrimary,
                ),
                const Gap(10),
                Align(
                  alignment: Alignment.centerLeft,
                  child: OtpTextField(
                    length: 6,
                    controller: forgotPasswordViewModel.txOtpCode,
                  ),
                ),
                const Gap(20),
                SimpleButton(
                  onPressed: () {
                    if(formKey.currentState?.validate() ?? false){
                      forgotPasswordViewModel.verifyOtp();
                    }
                  },
                  text: StringConstants.send,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
