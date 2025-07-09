import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:revalesuva/components/custom_button.dart';
import 'package:revalesuva/utils/app_colors.dart';
import 'package:revalesuva/utils/helper_method.dart';
import 'package:revalesuva/utils/strings_constant.dart';

class LessonDescriptionWidget extends StatelessWidget {
  const LessonDescriptionWidget({
    super.key,
    required this.index,
    required this.title,
    required this.description,
    required this.pdfFileUrl,
  });

  final int index;
  final String title;
  final String description;
  final String pdfFileUrl;

  @override
  Widget build(BuildContext context) {
    return CustomCard2(
      color: AppColors.surfaceTertiary,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: RichText(
                  textAlign: TextAlign.start,
                  maxLines: 2,
                  text: TextSpan(
                    style: Theme.of(context).textTheme.bodyMedium?.apply(
                          color: AppColors.textPrimary,
                        ),
                    children: [
                      TextSpan(text: "${StringConstants.lesson} "),
                      TextSpan(text: "${index + 1}:"),
                      TextSpan(
                        text: title,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  ),
                ),
              ),
              CustomTextButton(
                text: StringConstants.downloadFile,
                onPressed: () async {
                  showLoader();
                  await downloadFile(
                    url: pdfFileUrl,
                    context: context,
                  );
                  hideLoader();
                },
                icon: Icons.file_download_outlined,
              )
            ],
          ),
          const Gap(10),
          customHtmlWidget(description ?? "")
        ],
      ),
    );
  }
}
