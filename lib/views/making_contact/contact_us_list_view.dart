import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:revalesuva/components/custom_button.dart';
import 'package:revalesuva/components/custom_click.dart';
import 'package:revalesuva/components/custom_text.dart';
import 'package:revalesuva/components/custom_text_field.dart';
import 'package:revalesuva/components/list_item.dart';
import 'package:revalesuva/generated/assets.dart';
import 'package:revalesuva/utils/app_colors.dart';
import 'package:revalesuva/utils/app_validator.dart';
import 'package:revalesuva/utils/navigation_helper.dart';
import 'package:revalesuva/utils/strings_constant.dart';
import 'package:revalesuva/view_models/making_contact/making_contact_view_model.dart';
import 'package:revalesuva/view_models/user_view_model.dart';
import 'package:revalesuva/views/making_contact/inquiry_service/inquiry_service_list_view.dart';
import 'package:revalesuva/views/making_contact/tecnical_support/technical_support_list_view.dart';
import 'package:revalesuva/views/making_contact/trainer_chat/trainer_chat_view.dart';
import 'package:revalesuva/views/making_contact/trainer_chat/trainer_list_view.dart';

part 'inquiry_service/inquiry_service_view.dart';
part 'tecnical_support/technical_support_view.dart';

class ContactUsListView extends StatelessWidget {
  ContactUsListView({super.key});

  final MakingContactViewModel makingContactViewModel = Get.put(MakingContactViewModel(), permanent: true);

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        NavigationHelper.onBackScreen(widget: ContactUsListView());
      },
      canPop: true,
      child: Scaffold(
        body: ListView(
          padding: const EdgeInsets.all(20),
          physics: const BouncingScrollPhysics(),
          children: [
            const Gap(10),
            TextHeadlineMedium(
              text: StringConstants.contactUs,
              color: AppColors.textPrimary,
              letterSpacing: 0,
            ),
            const Gap(6),
            Obx(
              () => Get.find<UserViewModel>().userPlanDetail.value.id != null ? Padding(
                padding: const EdgeInsets.symmetric(vertical: 6.0),
                child: ListItem(
                  title: StringConstants.coachChat,
                  onTab: () {
                    NavigationHelper.pushScreenWithNavBar(widget: const TrainerListView(), context: context);

                  },
                  icon: Assets.iconsIcPrivacyPolicy,
                ),
              ):const SizedBox(),
            ),
            const Gap(6),
            ListItem(
              title: StringConstants.technicalSupport,
              onTab: () {
                NavigationHelper.pushScreenWithNavBar(widget: const TechnicalSupportListView(), context: context);

              },
              icon: Assets.iconsIcTermsOfUse,
            ),
            const Gap(12),
            ListItem(
              title: StringConstants.inquiryRegardingService,
              onTab: () {
                NavigationHelper.pushScreenWithNavBar(widget: const InquiryServiceListView(), context: context);


              },
              icon: Assets.iconsIcAccessibility,
            ),
            const Gap(30),
            const Gap(80),
          ],
        ),
      ),
    );
  }
}
