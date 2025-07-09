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
import 'package:revalesuva/utils/router.dart';
import 'package:revalesuva/utils/strings_constant.dart';
import 'package:revalesuva/view_models/login/login_view_model.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final LoginViewModel loginViewModel = Get.put(LoginViewModel());
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
                CustomTextField(
                  hint: StringConstants.email,
                  controller: loginViewModel.txEmail,
                  validator: (value) => FormValidate.requiredFieldForEmail(value),
                ),
                const Gap(10),
                Obx(
                  () => CustomTextField(
                    hint: StringConstants.password,
                    controller: loginViewModel.txPassword,
                    obscureText: !loginViewModel.isShowPassword.value,
                    validator: (value) => FormValidate.requiredField(value, StringConstants.password),
                    suffixIcon: IconButton(
                      onPressed: () {
                        loginViewModel.onEyeClick();
                      },
                      icon: Icon(
                        loginViewModel.isShowPassword.isFalse ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                        color: AppColors.iconSecondary,
                      ),
                    ),
                  ),
                ),
                const Gap(10),
                Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: CustomTextButton(
                    onPressed: () {
                      Get.toNamed(RoutesName.forgotPasswordView);
                    },
                    text: StringConstants.forgotPassword,
                    underline: true,
                  ),
                ),
                SimpleButton(
                  onPressed: () {
                    if (formKey.currentState?.validate() ?? false) {
                      loginViewModel.onLoginClick();
                    }
                  },
                  text: StringConstants.login,
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
