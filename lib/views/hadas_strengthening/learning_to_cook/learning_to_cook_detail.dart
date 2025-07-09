import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:gap/gap.dart';
import 'package:revalesuva/components/custom_click.dart';
import 'package:revalesuva/components/custom_text.dart';
import 'package:revalesuva/model/hadas_strengthening/learning_to_cook_model.dart'
    as learning_to_cook_model;
import 'package:revalesuva/utils/app_colors.dart';
import 'package:revalesuva/utils/app_corner.dart';
import 'package:revalesuva/utils/helper_method.dart';
import 'package:revalesuva/utils/navigation_helper.dart';
import 'package:revalesuva/utils/strings_constant.dart';

class LearningToCookDetail extends StatelessWidget {
  const LearningToCookDetail({super.key, required this.data});

  final learning_to_cook_model.Datum data;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        NavigationHelper.onBackScreen(
          widget: LearningToCookDetail(
            data: data,
          ),
        );
      },
      canPop: true,
      child: Scaffold(
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Gap(20),
                  CustomClick(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: TextBodySmall(
                      text: "< ${StringConstants.backTo} ${StringConstants.productsAndRecipes}",
                      color: AppColors.textPrimary,
                      letterSpacing: 0,
                    ),
                  ),
                  const Gap(10),
                  TextHeadlineMedium(
                    text: data.title ?? "",
                    color: AppColors.textPrimary,
                    letterSpacing: 0,
                  ),
                  const Gap(10),
                  Expanded(
                    child: ListView(
                      physics: const BouncingScrollPhysics(),
                      children: [
                        CustomCard2(
                          color: AppColors.textTertiary,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextTitleMedium(
                                text: StringConstants.ingredients,
                                color: AppColors.textPrimary,
                                letterSpacing: 0,
                              ),
                              const Gap(10),
                              // Wrap(
                              //   runSpacing: 5,
                              //   spacing: 5,
                              //   children: data.ingredients?.map(
                              //         (e) {
                              //           return Container(
                              //             padding: const EdgeInsets.symmetric(
                              //               vertical: 5,
                              //               horizontal: 5,
                              //             ),
                              //             decoration: BoxDecoration(
                              //               border: Border.all(
                              //                 color: AppColors.borderSecondary,
                              //               ),
                              //               borderRadius: BorderRadius.circular(
                              //                 AppCorner.videoCard,
                              //               ),
                              //             ),
                              //             child: TextBodySmall(
                              //               text: e.ingredientName ?? "",
                              //               color: AppColors.textPrimary,
                              //             ),
                              //           );
                              //         },
                              //       ).toList() ??
                              //       [],
                              // ),
                            ],
                          ),
                        ),
                        const Gap(10),
                        // CustomCard2(
                        //   color: AppColors.textTertiary,
                        //   child: customHtmlWidget(
                        //     data.description ?? "",
                        //   ),
                        // )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
