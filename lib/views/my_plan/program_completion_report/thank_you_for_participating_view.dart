import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:revalesuva/components/custom_button.dart';
import 'package:revalesuva/components/custom_dropdown.dart';
import 'package:revalesuva/components/custom_text.dart';
import 'package:revalesuva/components/custom_text_field.dart';
import 'package:revalesuva/components/list_item.dart';
import 'package:revalesuva/generated/assets.dart';
import 'package:revalesuva/utils/app_colors.dart';
import 'package:revalesuva/utils/app_corner.dart';
import 'package:revalesuva/utils/helper_method.dart';
import 'package:revalesuva/utils/navigation_helper.dart';
import 'package:revalesuva/utils/strings_constant.dart';
import 'package:revalesuva/view_models/my_plan/thank_you_participating_view_model.dart';
import 'package:revalesuva/views/my_stars/my_stars_view.dart';

class ThankYouForParticipatingView extends StatefulWidget {
  const ThankYouForParticipatingView({super.key});

  @override
  State<ThankYouForParticipatingView> createState() => _ThankYouForParticipatingViewState();
}

class _ThankYouForParticipatingViewState extends State<ThankYouForParticipatingView> {
  final ThankYouParticipatingViewModel thankYouParticipatingViewModel =
      Get.put(ThankYouParticipatingViewModel());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        thankYouParticipatingViewModel.isLoading.value = true;
        await thankYouParticipatingViewModel.getAllPlanList();
        thankYouParticipatingViewModel.isLoading.value = false;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        NavigationHelper.onBackScreen(
          widget: const ThankYouForParticipatingView(),
        );
      },
      canPop: true,
      child: Scaffold(
        body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
          children: [
            CustomCard2(
              color: AppColors.surfaceTertiary,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    TextHeadlineMedium(
                      text: StringConstants.thankYouForParticipatingInTheProgram,
                    ),
                    const Gap(10),
                    TextBodyMedium(
                      text: StringConstants.weLookForwardToSeeingYouInTheUpcomingPrograms,
                      color: AppColors.textPrimary,
                    ),
                    const Gap(30),
                    ListItem(
                      title: StringConstants.theStarsProgram,
                      onTab: () {
                        NavigationHelper.pushScreenWithNavBar(
                            widget: const MyStarsView(), context: context);
                      },
                      icon: Assets.iconsIcStartProgram,
                      isShowBoarder: true,
                    ),
                  ],
                ),
              ),
            ),
            const Gap(20),
            Obx(
              () => thankYouParticipatingViewModel.isLoading.isTrue
                  ? CustomShimmer(
                      radius: AppCorner.listTile,
                      height: 40.h,
                    )
                  : CustomCard2(
                      color: AppColors.surfaceTertiary,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextHeadlineMedium(
                              text: StringConstants.undecidedFillOutThisFormForAdvice,
                            ),
                            const Gap(10),
                            TextBodyMedium(
                              text: StringConstants.weLookForwardToSeeingYouInTheUpcomingPrograms,
                              color: AppColors.textPrimary,
                            ),
                            const Gap(30),
                            Obx(
                              () => SimpleDropdownButton(
                                hint: StringConstants.iNeedAdviceRegardingTheProgram,
                                value: thankYouParticipatingViewModel.selectedPlan.value.isNotEmpty
                                    ? thankYouParticipatingViewModel.selectedPlan.value
                                    : null,
                                dropdownItems: thankYouParticipatingViewModel.listPlan
                                    .map(
                                      (element) => element.name ?? "",
                                    )
                                    .toSet()
                                    .toList(),
                                onChanged: (String? value) {
                                  if (value != null) {
                                    thankYouParticipatingViewModel.selectedPlan.value = value;
                                  }
                                },
                              ),
                            ),
                            const Gap(20),
                            CustomTextField(
                              hint: "Detail",
                              controller: thankYouParticipatingViewModel.txtDetail,
                              minLine: 5,
                              maxLine: 6,
                            ),
                            const Gap(20),
                            Align(
                              alignment: Alignment.center,
                              child: CustomButton(
                                width: 100.w,
                                text: StringConstants.send,
                                onPressed: () async {
                                  var isSuccess =
                                      await thankYouParticipatingViewModel.submitUserAdvice();
                                  if (isSuccess && context.mounted) {
                                    Navigator.of(context).pop();
                                    Navigator.of(context).pop();
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
            ),
            const Gap(50),
          ],
        ),
      ),
    );
  }
}
