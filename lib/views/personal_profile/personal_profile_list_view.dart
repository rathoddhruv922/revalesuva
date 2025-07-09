import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:revalesuva/components/custom_click.dart';
import 'package:revalesuva/components/custom_text.dart';
import 'package:revalesuva/components/list_item.dart';
import 'package:revalesuva/generated/assets.dart';
import 'package:revalesuva/utils/app_colors.dart';
import 'package:revalesuva/utils/navigation_helper.dart';
import 'package:revalesuva/utils/strings_constant.dart';
import 'package:revalesuva/view_models/personal_profile/personal_profile_view_model.dart';
import 'package:revalesuva/view_models/user_view_model.dart';
import 'package:revalesuva/views/personal_profile/body_and_medical_info/body_and_medical_information_view.dart';
import 'package:revalesuva/views/personal_profile/general_info/general_Information_view.dart';

class PersonalProfileListView extends StatefulWidget {
  PersonalProfileListView({super.key});

  @override
  State<PersonalProfileListView> createState() => _PersonalProfileListViewState();
}

class _PersonalProfileListViewState extends State<PersonalProfileListView> {
  final PersonalProfileViewModel personalProfileViewModel =
      Get.put(PersonalProfileViewModel(), permanent: true);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        personalProfileViewModel.onCreate();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        NavigationHelper.onBackScreen(widget: PersonalProfileListView());
      },
      canPop: true,
      child: Scaffold(
        body: ListView(
          padding: const EdgeInsets.all(20),
          physics: const BouncingScrollPhysics(),
          children: [
            const Gap(10),
            CustomClick(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: TextBodySmall(
                text: "< ${StringConstants.backTo} ${StringConstants.personalArea}",
                color: AppColors.textPrimary,
                letterSpacing: 0,
              ),
            ),
            const Gap(10),
            TextHeadlineMedium(
              text: StringConstants.personalProfile,
              color: AppColors.textPrimary,
              letterSpacing: 0,
            ),
            const Gap(12),
            ListItem(
              title: StringConstants.generalInformationAndContactDetails,
              onTab: () {
                NavigationHelper.pushScreenWithNavBar(
                    widget: GeneralInformationView(), context: context);
              },
              icon: Assets.iconsIcPersonDetail,
            ),
            const Gap(12),
            Obx(
              () => Get.find<UserViewModel>().userPlanDetail.value.id != null
                  ? ListItem(
                      title: StringConstants.bodyDataAndMedicalInformation,
                      onTab: () {
                        NavigationHelper.pushScreenWithNavBar(
                            widget: BodyAndMedicalInformationView(), context: context);
                      },
                      icon: Assets.iconsIcBody,
                    )
                  : const SizedBox(),
            ),
            const Gap(80),
          ],
        ),
      ),
    );
  }
}
