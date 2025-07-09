import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:revalesuva/components/custom_bottom_sheet.dart';
import 'package:revalesuva/components/custom_button.dart';
import 'package:revalesuva/components/custom_click.dart';
import 'package:revalesuva/components/custom_dropdown.dart';
import 'package:revalesuva/components/custom_text.dart';
import 'package:revalesuva/utils/app_colors.dart';
import 'package:revalesuva/utils/app_corner.dart';
import 'package:revalesuva/utils/app_validator.dart';
import 'package:revalesuva/utils/date_format_helper.dart';
import 'package:revalesuva/utils/default_list.dart';
import 'package:revalesuva/utils/helper_method.dart';
import 'package:revalesuva/utils/navigation_helper.dart';
import 'package:revalesuva/utils/strings_constant.dart';
import 'package:revalesuva/view_models/personal_profile/personal_profile_view_model.dart';
import 'package:revalesuva/views/personal_profile/widget/edit_button_widget.dart';
import 'package:revalesuva/views/personal_profile/widget/info_display_edit_dropdown_widget.dart';
import 'package:revalesuva/views/personal_profile/widget/info_display_edit_widget.dart';
import 'package:revalesuva/views/personal_profile/widget/info_display_widget.dart';

part 'widget/auth_info_widget.dart';
part 'widget/auth_info_edit_widget.dart';
part 'widget/general_info_widget.dart';
part 'widget/general_info_edit_widget.dart';

class GeneralInformationView extends StatelessWidget {
  GeneralInformationView({super.key});

  final PersonalProfileViewModel personalProfileViewModel = Get.find<PersonalProfileViewModel>();

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        NavigationHelper.onBackScreen(widget: GeneralInformationView());
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
                text: "< ${StringConstants.backTo} ${StringConstants.personalProfile}",
                color: AppColors.textPrimary,
                letterSpacing: 0,
              ),
            ),
            const Gap(10),
            TextHeadlineMedium(
              text: StringConstants.generalInformationAndContactDetails,
              color: AppColors.textPrimary,
              letterSpacing: 0,
            ),
            const Gap(12),
            Obx(
              () => personalProfileViewModel.isGeneralInfoEditable.isTrue ? GeneralInfoEditWidget() : GeneralInfoWidget(),
            ),
            const Gap(20),
            Obx(
              () => personalProfileViewModel.isAuthInfoEditable.isTrue
                  ? AuthInfoEditWidget(
                      title: StringConstants.loginDetails,
                    )
                  : AuthInfoWidget(),
            ),
            const Gap(80),
          ],
        ),
      ),
    );
  }
}
