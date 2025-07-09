import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:revalesuva/components/custom_appbar.dart';
import 'package:revalesuva/components/custom_button.dart';
import 'package:revalesuva/components/custom_text_field.dart';
import 'package:revalesuva/generated/assets.dart';
import 'package:revalesuva/utils/app_colors.dart';
import 'package:revalesuva/utils/app_validator.dart';
import 'package:revalesuva/utils/strings_constant.dart';
import 'package:revalesuva/view_models/forgot_password/forgot_password_view_model.dart';

class ResetPasswordView extends StatelessWidget {
  ResetPasswordView({super.key});

  final ForgotPasswordViewModel forgotPasswordViewModel = Get.find<ForgotPasswordViewModel>();
  final formKey = GlobalKey<FormState>();

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
                Obx(
                  () => CustomTextField(
                    hint: StringConstants.newPassword,
                    controller: forgotPasswordViewModel.txNewPassword,
                    obscureText: !forgotPasswordViewModel.isShowPassword.value,
                    validator: (value) => FormValidate.requiredField(value, StringConstants.password),
                    suffixIcon: IconButton(
                      onPressed: () {
                        forgotPasswordViewModel.onEyeClick();
                      },
                      icon: Icon(
                        forgotPasswordViewModel.isShowPassword.isFalse
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                        color: AppColors.iconSecondary,
                      ),
                    ),
                  ),
                ),
                const Gap(10),
                Obx(
                  () => CustomTextField(
                    hint: StringConstants.confirmPassword,
                    controller: forgotPasswordViewModel.txConfirmPassword,
                    obscureText: !forgotPasswordViewModel.isConfirmPassword.value,
                    validator: (value) => FormValidate.matchPassword(
                      forgotPasswordViewModel.txNewPassword.text,
                      forgotPasswordViewModel.txConfirmPassword.text,
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {
                        forgotPasswordViewModel.isConfirmPassword.toggle();
                        //forgotPasswordViewModel.onEyeClick();
                      },
                      icon: Icon(
                        forgotPasswordViewModel.isConfirmPassword.isFalse
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                        color: AppColors.iconSecondary,
                      ),
                    ),
                  ),
                ),
                const Gap(10),
                SimpleButton(
                  onPressed: () {
                    if (formKey.currentState?.validate() ?? false) {
                      forgotPasswordViewModel.resetPasswordApi();
                    }
                  },
                  text: StringConstants.submit,
                ),
                Image.asset(
                  width: 100.w,
                  Assets.imagesBgLogin,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
