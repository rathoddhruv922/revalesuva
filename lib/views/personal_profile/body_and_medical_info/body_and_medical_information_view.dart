import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:revalesuva/components/custom_bottom_sheet.dart';
import 'package:revalesuva/components/custom_button.dart';
import 'package:revalesuva/components/custom_click.dart';
import 'package:revalesuva/components/custom_text.dart';
import 'package:revalesuva/generated/assets.dart';
import 'package:revalesuva/model/medical_question/create_user_answer_model.dart'
    as create_user_answer_model;
import 'package:revalesuva/utils/app_colors.dart';
import 'package:revalesuva/utils/app_corner.dart';
import 'package:revalesuva/utils/date_format_helper.dart';
import 'package:revalesuva/utils/default_list.dart';
import 'package:revalesuva/utils/helper_method.dart';
import 'package:revalesuva/utils/navigation_helper.dart';
import 'package:revalesuva/utils/strings_constant.dart';
import 'package:revalesuva/view_models/personal_detail/que_and_ans_view_model.dart';
import 'package:revalesuva/view_models/personal_profile/personal_profile_view_model.dart';
import 'package:revalesuva/view_models/user_view_model.dart';
import 'package:revalesuva/views/personal_profile/body_and_medical_info/blood_report_list_view.dart';
import 'package:revalesuva/views/personal_profile/body_and_medical_info/widget/widget/question_ans_item_widget.dart';
import 'package:revalesuva/views/personal_profile/body_and_medical_info/widget/widget/show_before_picture_widget.dart';
import 'package:revalesuva/views/personal_profile/widget/edit_button_widget.dart';
import 'package:revalesuva/views/personal_profile/widget/info_display_edit_dropdown_widget.dart';
import 'package:revalesuva/views/personal_profile/widget/info_display_edit_widget.dart';
import 'package:revalesuva/views/personal_profile/widget/info_display_widget.dart';
import 'package:revalesuva/views/tools/ovulation_calculator/ovulation_calculator_view.dart';
import 'package:revalesuva/views/tools/widget/report_question_answer_widget.dart';

part 'widget/before_pictures_widget.dart';
part 'widget/body_data_edit_widget.dart';
part 'widget/body_data_widget.dart';
part 'widget/medical_questionnaire_edit_widget.dart';
part 'widget/medical_questionnaire_widget.dart';

class BodyAndMedicalInformationView extends StatelessWidget {
  BodyAndMedicalInformationView({super.key});

  final PersonalProfileViewModel personalProfileViewModel = Get.find<PersonalProfileViewModel>();

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        NavigationHelper.onBackScreen(widget: BodyAndMedicalInformationView());
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
              text: StringConstants.bodyDataAndMedicalInformation,
              color: AppColors.textPrimary,
              letterSpacing: 0,
            ),
            const Gap(12),
            BeforePicturesWidget(),
            const Gap(12),
            Obx(
              () => personalProfileViewModel.isBodyInfoEditable.isTrue
                  ? BodyDataEditWidget(title: StringConstants.bodyData)
                  : BodyDataWidget(),
            ),
            const Gap(12),
            Obx(
              () => personalProfileViewModel.isMedicalQuestionEditable.isTrue
                  ? MedicalQuestionnaireEditWidget(title: StringConstants.medicalQuestionnaire)
                  : const MedicalQuestionnaireWidget(),
            ),
            const Gap(80),
          ],
        ),
      ),
    );
  }
}
