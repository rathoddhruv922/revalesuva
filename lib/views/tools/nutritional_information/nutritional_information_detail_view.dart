import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:revalesuva/components/custom_click.dart';
import 'package:revalesuva/components/custom_text.dart';
import 'package:revalesuva/model/tools/nutritional_information/nutritional_information_model.dart'
    as nutritional_information_model;
import 'package:revalesuva/utils/app_colors.dart';
import 'package:revalesuva/utils/app_corner.dart';
import 'package:revalesuva/utils/helper_method.dart';
import 'package:revalesuva/utils/navigation_helper.dart';
import 'package:revalesuva/utils/strings_constant.dart';
import 'package:revalesuva/view_models/tools/nutritional_information_view_model.dart';
import 'package:revalesuva/views/tools/nutritional_information/widget/nutritional_information_item.dart';

class NutritionalInformationDetailView extends StatelessWidget {
  NutritionalInformationDetailView({super.key, required this.data});

  final nutritional_information_model.Datum data;
  final NutritionalInformationViewModel nutritionalInformationViewModel =
      Get.find<NutritionalInformationViewModel>();

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        NavigationHelper.onBackScreen(
          widget: NutritionalInformationDetailView(
            data: data,
          ),
        );
      },
      canPop: true,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Gap(10),
              CustomClick(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: TextBodySmall(
                  text: "< ${StringConstants.backTo} ${StringConstants.nutritionalInformation}",
                  color: AppColors.textPrimary,
                  letterSpacing: 0,
                ),
              ),
              Expanded(
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  children: [
                    const Gap(10),
                    TextHeadlineLarge(
                      text: data.title ?? "",
                      color: AppColors.textPrimary,
                      letterSpacing: 0,
                    ),
                    const Gap(10),
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: const BoxDecoration(
                        color: AppColors.surfaceTertiary,
                        borderRadius: BorderRadiusDirectional.only(
                          bottomStart: Radius.circular(AppCorner.cardBoarder),
                          topEnd: Radius.circular(AppCorner.cardBoarder),
                        ),
                      ),
                      child: customHtmlWidget(data.description ?? ""),
                    ),
                    const Gap(20),
                    Obx(
                      () => nutritionalInformationViewModel.listNutritional.length >= 2
                          ? TextHeadlineMedium(
                              text: StringConstants.youMayAlsoBeInterested,
                              color: AppColors.textPrimary,
                              letterSpacing: 0,
                            )
                          : const SizedBox(),
                    ),
                    const Gap(10),
                    Obx(
                      () => nutritionalInformationViewModel.listNutritional.length >= 2
                          ? ListView.separated(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (BuildContext context, int index) {
                                return NutritionalInformationItem(
                                  index: index,
                                  data: nutritionalInformationViewModel.getInnerList(
                                      nutritionId: data.id ?? 0)[index],
                                  onTap: () {
                                    NavigationHelper.onBackScreen(
                                      widget: NutritionalInformationDetailView(
                                        data: data,
                                      ),
                                    );
                                    NavigationHelper.pushReplaceScreenWithNavBar(
                                      widget: NutritionalInformationDetailView(
                                        data: nutritionalInformationViewModel.getInnerList(
                                            nutritionId: data.id ?? 0)[index],
                                        key: GlobalKey(),
                                      ),
                                      context: context,
                                    );
                                  },
                                );
                              },
                              separatorBuilder: (context, index) => const Gap(10),
                              itemCount: nutritionalInformationViewModel
                                          .getInnerList(nutritionId: data.id ?? 0)
                                          .length >
                                      2
                                  ? 2
                                  : nutritionalInformationViewModel
                                      .getInnerList(nutritionId: data.id ?? 0)
                                      .length,
                            )
                          : const SizedBox(),
                    ),
                  ],
                ),
              ),
              const Gap(50),
            ],
          ),
        ),
      ),
    );
  }
}
