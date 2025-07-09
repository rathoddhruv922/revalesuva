import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:revalesuva/components/custom_button.dart';
import 'package:revalesuva/components/custom_click.dart';
import 'package:revalesuva/components/custom_text.dart';
import 'package:revalesuva/components/custom_text_field.dart';
import 'package:revalesuva/utils/app_colors.dart';
import 'package:revalesuva/utils/helper_method.dart';
import 'package:revalesuva/utils/navigation_helper.dart';
import 'package:revalesuva/utils/strings_constant.dart';
import 'package:revalesuva/view_models/tools/intuitive_writing_view_model.dart';

class IntuitiveWritingDetailView extends StatelessWidget {
  IntuitiveWritingDetailView({super.key, required this.id});

  final int id;
  final IntuitiveWritingViewModel intuitiveWritingViewModel = Get.find<IntuitiveWritingViewModel>();

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        NavigationHelper.onBackScreen(
          widget: IntuitiveWritingDetailView(id: id),
        );
      },
      canPop: true,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Gap(10),
              CustomClick(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: TextBodySmall(
                  text: "< ${StringConstants.backTo} ${StringConstants.toList}",
                  color: AppColors.textPrimary,
                  letterSpacing: 0,
                ),
              ),
              const Gap(10),
              Flexible(
                child: CustomCard2(
                  color: AppColors.surfaceTertiary,
                  child: CustomTextArea(
                    hint: "",
                    controller: intuitiveWritingViewModel.txtWriting,
                    maxLine: 100,
                  ),
                ),
              ),
              const Gap(20),
              Row(
                children: [
                  if (id != 0)
                    SimpleButton(
                      backgroundColor: AppColors.surfaceTertiary,
                      text: StringConstants.delete,
                      onPressed: () async {
                        await intuitiveWritingViewModel.deleteIntuitiveWriting(
                          id: id,
                        );
                        Navigator.of(context).pop();
                      },
                    ),
                  const Spacer(),
                  SimpleButton(
                    text: StringConstants.save,
                    onPressed: () {
                      intuitiveWritingViewModel.createUpdateIntuitiveWriting(
                        id: id,
                        context: context,
                      );
                    },
                  ),
                ],
              ),
              const Gap(80),
            ],
          ),
        ),
      ),
    );
  }
}
