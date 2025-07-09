import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:revalesuva/components/custom_appbar.dart';
import 'package:revalesuva/components/custom_button.dart';
import 'package:revalesuva/components/custom_text.dart';
import 'package:revalesuva/components/custom_text_field.dart';
import 'package:revalesuva/utils/app_validator.dart';
import 'package:revalesuva/utils/strings_constant.dart';
import 'package:revalesuva/view_models/forgot_password/forgot_password_view_model.dart';

class ForgotPasswordView extends StatelessWidget {
  ForgotPasswordView({super.key});

  final ForgotPasswordViewModel forgotPasswordViewModel = Get.put(ForgotPasswordViewModel(), permanent: true);
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
                TextTitleMedium(text: StringConstants.enterEmail),
                const Gap(10),
                CustomTextField(
                  hint: StringConstants.email,
                  controller: forgotPasswordViewModel.txEmail,
                  validator: (value) => FormValidate.requiredFieldForEmail(value),
                ),
                const Gap(10),
                SimpleButton(
                  onPressed: () {
                    if (formKey.currentState?.validate() ?? false) {
                      forgotPasswordViewModel.requestForgotPasswordApi();
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
