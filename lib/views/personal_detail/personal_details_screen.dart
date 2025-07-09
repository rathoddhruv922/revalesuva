import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:revalesuva/components/custom_Image_viewer.dart';
import 'package:revalesuva/components/custom_appbar.dart';
import 'package:revalesuva/components/custom_bottom_sheet.dart';
import 'package:revalesuva/components/custom_button.dart';
import 'package:revalesuva/components/custom_click.dart';
import 'package:revalesuva/components/custom_dialog.dart';
import 'package:revalesuva/components/custom_dropdown.dart';
import 'package:revalesuva/components/custom_image_picker.dart';
import 'package:revalesuva/components/custom_text.dart';
import 'package:revalesuva/components/custom_text_field.dart';
import 'package:revalesuva/generated/assets.dart';
import 'package:revalesuva/utils/app_colors.dart';
import 'package:revalesuva/utils/app_corner.dart';
import 'package:revalesuva/utils/app_validator.dart';
import 'package:revalesuva/utils/date_format_helper.dart';
import 'package:revalesuva/utils/default_list.dart';
import 'package:revalesuva/utils/helper_method.dart';
import 'package:revalesuva/utils/strings_constant.dart';
import 'package:revalesuva/view_models/personal_detail/common_media_view_model.dart';
import 'package:revalesuva/view_models/personal_detail/personal_details_view_model.dart';
import 'package:revalesuva/view_models/personal_detail/que_and_ans_view_model.dart';
import 'package:revalesuva/view_models/user_view_model.dart';
import 'package:revalesuva/views/personal_detail/widget/medical_question_progressbar_widget.dart';
import 'package:revalesuva/model/medical_question/user_ans_model.dart' as user_ans_model;
import 'package:revalesuva/model/medical_question/create_user_answer_model.dart' as create_user_answer_model;

part 'general_detail_view.dart';
part 'main_detail_view.dart';
part 'medical_detail_view.dart';
part 'medical_question_view.dart';
part 'widget/picture_widget.dart';

class PersonalDetailsScreen extends StatelessWidget {
  PersonalDetailsScreen({super.key});

  final PersonalDetailsViewModel personalDetailsViewModel = Get.put(PersonalDetailsViewModel(), permanent: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(hideProfile: true),
      extendBodyBehindAppBar: true,
      body: PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) {
          if (personalDetailsViewModel.currentQuestion.value == 0) {
            if (personalDetailsViewModel.activePersonalDetailScreenId.value != 1) {
              personalDetailsViewModel.onPreviousStepClick();
            }
          } else {
            personalDetailsViewModel.onPreviousQuestion();
          }
        },
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Container(
            margin: const EdgeInsets.only(left: 20, right: 20, bottom: 50),
            padding: const EdgeInsets.only(bottom: 30, top: 300),
            decoration: BoxDecoration(
              color: AppColors.surfacePrimary.withValues(alpha: 0.66),
              borderRadius: BorderRadius.circular(AppCorner.cardBoarder),
              boxShadow: [
                BoxShadow(
                  color: AppColors.shadowColor,
                  spreadRadius: 0,
                  offset: const Offset(0, 4),
                  blurRadius: 4,
                ),
              ],
            ),
            child: Obx(
              () => formContent(formId: personalDetailsViewModel.activePersonalDetailScreenId.value),
            ),
          ),
        ),
      ),
    );
  }

  Widget formContent({required int formId}) {
    if (formId == 1) {
      return MainDetailView();
    } else if (formId == 2) {
      return GeneralDetailView();
    } else if (formId == 3) {
      return MedicalDetailView();
    } else if (formId == 4) {
      return const MedicalQuestion();
    } else {
      return const SizedBox.shrink();
    }
  }
}
