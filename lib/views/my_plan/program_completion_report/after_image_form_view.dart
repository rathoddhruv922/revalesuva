import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:revalesuva/components/custom_button.dart';
import 'package:revalesuva/components/custom_dialog.dart';
import 'package:revalesuva/components/custom_image_picker.dart';
import 'package:revalesuva/components/custom_text.dart';
import 'package:revalesuva/generated/assets.dart';
import 'package:revalesuva/utils/app_colors.dart';
import 'package:revalesuva/utils/helper_method.dart';
import 'package:revalesuva/utils/navigation_helper.dart';
import 'package:revalesuva/utils/strings_constant.dart';
import 'package:revalesuva/view_models/my_plan/program_completion_report_view_model.dart';
import 'package:revalesuva/view_models/personal_detail/common_media_view_model.dart';
import 'package:revalesuva/views/my_plan/program_completion_report/see_your_progress_view.dart';
import 'package:revalesuva/views/my_plan/program_completion_report/widget/completion_report_question_widget.dart';
import 'package:revalesuva/views/personal_detail/personal_details_screen.dart';

class AfterImageFormView extends StatelessWidget {
  AfterImageFormView({super.key});

  final ProgramCompletionReportViewModel programCompletionReportViewModel =
      Get.find<ProgramCompletionReportViewModel>();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Gap(10),
        Flexible(
          child: programCompletionReportViewModel.listAfterImageQuestion.isEmpty
              ? const SizedBox()
              : ListView(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  children: [
                    CustomCard2(
                      color: AppColors.surfaceTertiary,
                      child: ListView(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        children: [
                          Row(
                            textDirection:
                                Get.locale?.languageCode == "he" ? TextDirection.rtl : TextDirection.ltr,
                            children: [
                              Expanded(
                                child: TextTitleMedium(text: StringConstants.beforeAndAfterPhotos),
                              ),
                              const Gap(10),
                              Expanded(
                                child: Align(
                                  alignment: AlignmentDirectional.centerEnd,
                                  child: CustomTextButton(
                                    onPressed: () {
                                      if(Get.find<CommonMediaViewModel>().howToTakeVideoId.value.isNotEmpty){
                                        CustomDialog.vimeoVideoDialog(
                                          videoId: Get.find<CommonMediaViewModel>().howToTakeVideoId.value,
                                        );
                                      }else{
                                        CustomDialog.videoDialog(
                                          url: Get.find<CommonMediaViewModel>().howToTakeUrl.value,
                                        );
                                      }

                                    },
                                    text: StringConstants.howToTakePhotos,
                                    underline: true,
                                  ),
                                ),
                              )
                            ],
                          ),
                          const Gap(20),
                          Row(
                            textDirection:
                                Get.locale?.languageCode == "he" ? TextDirection.rtl : TextDirection.ltr,
                            children: [
                              Obx(
                                () => PictureWidget(
                                  title: StringConstants.front,
                                  image: programCompletionReportViewModel.imgFrontPath.value,
                                  defaultImage: Assets.imagesImFront,
                                  onTap: () async {
                                    programCompletionReportViewModel.imgFrontPath.value =
                                        await CustomImagePicker.pickFromBoth();
                                  },
                                ),
                              ),
                              const Gap(10),
                              Obx(
                                () => PictureWidget(
                                  title: StringConstants.side,
                                  image: programCompletionReportViewModel.imgSidePath.value,
                                  defaultImage: Assets.imagesImSide,
                                  onTap: () async {
                                    programCompletionReportViewModel.imgSidePath.value =
                                        await CustomImagePicker.pickFromBoth();
                                  },
                                ),
                              ),
                              const Gap(10),
                              Obx(
                                () => PictureWidget(
                                  title: StringConstants.back,
                                  image: programCompletionReportViewModel.imgBackPath.value,
                                  defaultImage: Assets.imagesImBack,
                                  onTap: () async {
                                    programCompletionReportViewModel.imgBackPath.value =
                                        await CustomImagePicker.pickFromBoth();
                                  },
                                ),
                              ),
                            ],
                          ),
                          const Gap(10),
                          Obx(
                            () => ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                              itemBuilder: (context, index) {
                                return CompletionReportQuestionWidget(
                                  index: index,
                                  onChange: (value, subAns, index) {
                                    var question =
                                        programCompletionReportViewModel.listAfterImageQuestion[index];
                                    programCompletionReportViewModel
                                        .listAfterImageQuestion[index].tempAns = value;
                                    if (question.answerType == "no_with_input" ||
                                        question.answerType == "yes_with_input") {
                                    } else {
                                      programCompletionReportViewModel
                                          .listAfterImageQuestion[index].tempAnsSub = value;
                                    }
                                    programCompletionReportViewModel.listAfterImageQuestion.refresh();
                                  },
                                  onTextChange: (value) {
                                    var question =
                                        programCompletionReportViewModel.listAfterImageQuestion[index];
                                    if (question.answerType == "input_box" ||
                                        question.answerType == "text_area") {
                                      programCompletionReportViewModel
                                          .listAfterImageQuestion[index].tempAns = value;
                                    }
                                    programCompletionReportViewModel
                                        .listAfterImageQuestion[index].tempAnsSub = value;
                                    programCompletionReportViewModel.listAfterImageQuestion.refresh();
                                  },
                                  question:
                                      programCompletionReportViewModel.listAfterImageQuestion[index],
                                  subAns: programCompletionReportViewModel
                                          .listAfterImageQuestion[index].tempAnsSub ??
                                      "",
                                );
                              },
                              itemCount: programCompletionReportViewModel.listAfterImageQuestion.length,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
        ),
        const Gap(10),
        Row(
          textDirection: Get.locale?.languageCode == "he" ? TextDirection.rtl : TextDirection.ltr,
          children: [
            CustomTextButton(
              onPressed: () {
                programCompletionReportViewModel.onPreviousStepClick();
              },
              text: StringConstants.previousStep,
              icon: Icons.arrow_back_ios,
              textColor: AppColors.textSecondary,
              underline: false,
            ),
            const Spacer(),
            CustomIconButton(
              onPressed: () async {
                showLoader();
                bool isSuccess =
                    await programCompletionReportViewModel.submitAllProgramCompletionReportAns();
                hideLoader();
                if (isSuccess && context.mounted) {
                  Navigator.pop(context);
                  NavigationHelper.pushReplaceScreenWithNavBar(
                    widget: const SeeYourProgressView(),
                    context: context,
                  );
                }
              },
              text: StringConstants.finish,
              icon: Icons.arrow_forward_ios,
            )
          ],
        ),
      ],
    );
  }
}
