import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:revalesuva/components/custom_button.dart';
import 'package:revalesuva/components/custom_text.dart';
import 'package:revalesuva/utils/app_colors.dart';
import 'package:revalesuva/utils/helper_method.dart';
import 'package:revalesuva/utils/navigation_helper.dart';
import 'package:revalesuva/utils/strings_constant.dart';
import 'package:revalesuva/view_models/personal_detail/common_media_view_model.dart';
import 'package:revalesuva/view_models/user_view_model.dart';

class ThankYouView extends StatelessWidget {
  const ThankYouView({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        NavigationHelper.onBackScreen(widget: const ThankYouView());
      },
      canPop: true,
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(20.0),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Gap(10),
                  Obx(
                    () => CustomCard2(
                      color: AppColors.surfaceTertiary,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          TextHeadlineLarge(
                            text: StringConstants.orderOnItsWay,
                            textAlign: TextAlign.center,
                          ),
                          const Gap(20),
                          TextBodyMedium(
                            text: StringConstants.thankYouForPurchase,
                            color: AppColors.textPrimary,
                            textAlign: TextAlign.center,
                          ),
                          const Gap(5),
                          TextBodyMedium(
                            text: StringConstants.invoiceWaitingForYou,
                            color: AppColors.textPrimary,
                            textAlign: TextAlign.center,
                          ),
                          TextBodyMedium(
                            text: StringConstants.inTheEmail
                                .replaceAll("{}", Get.find<UserViewModel>().userData.value.email ?? ""),
                            color: AppColors.textPrimary,
                            textAlign: TextAlign.center,
                          ),
                          const Gap(20),
                          TextBodyMedium(
                            text: StringConstants.deliveryIn5Days,
                            color: AppColors.textPrimary,
                            textAlign: TextAlign.center,
                          ),
                          const Gap(20),
                          TextBodyMedium(
                            text: StringConstants.contactForDetails.replaceAll(
                              "{}",
                              removeHtmlTags(Get.find<CommonMediaViewModel>()
                                      .getCmsData(slug: "call-us")
                                      ?.description ??
                                  ""),
                            ),
                            color: AppColors.textPrimary,
                            textAlign: TextAlign.center,
                          ),
                          const Gap(20),
                          SimpleButton(
                            text: StringConstants.backToHomePage,
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Gap(5),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
