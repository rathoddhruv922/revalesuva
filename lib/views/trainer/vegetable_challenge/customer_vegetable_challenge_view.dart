import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:revalesuva/components/custom_appbar.dart';
import 'package:revalesuva/components/custom_click.dart';
import 'package:revalesuva/components/custom_text.dart';
import 'package:revalesuva/model/trainer/home/customer_model.dart' as customer_model;
import 'package:revalesuva/utils/app_colors.dart';
import 'package:revalesuva/utils/app_corner.dart';
import 'package:revalesuva/utils/helper_method.dart';
import 'package:revalesuva/utils/strings_constant.dart';
import 'package:revalesuva/view_models/trainer/trainer_vegetable_challenge_view_model.dart';
import 'package:revalesuva/views/trainer/widget/drawer_widget.dart';

class CustomerVegetableChallengeView extends StatefulWidget {
  const CustomerVegetableChallengeView({super.key, required this.userData});

  final customer_model.Datum userData;

  @override
  State<CustomerVegetableChallengeView> createState() => _CustomerVegetableChallengeViewState();
}

class _CustomerVegetableChallengeViewState extends State<CustomerVegetableChallengeView> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  final TrainerVegetableChallengeViewModel trainerVegetableChallengeViewModel =
      Get.put(TrainerVegetableChallengeViewModel());

  @override
  initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        trainerVegetableChallengeViewModel.isLoading.value = true;
        await trainerVegetableChallengeViewModel.fetchUserNutrition(
          customerId: "${widget.userData.id ?? ""}",
        );
        trainerVegetableChallengeViewModel.isLoading.value = false;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: customAppBarTrainer(
        key: scaffoldKey,
      ),
      drawer: DrawerWidget(
        drawerKey: scaffoldKey,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomClick(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: TextBodySmall(
                text: "< ${StringConstants.backTo} ${StringConstants.customerOptions}",
                color: AppColors.textPrimary,
                letterSpacing: 0,
              ),
            ),
            const Gap(10),
            TextHeadlineMedium(
              text: StringConstants.tasks,
              color: AppColors.textPrimary,
              letterSpacing: 0,
            ),
            const Gap(10),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  await trainerVegetableChallengeViewModel.fetchUserNutrition(
                    customerId: "${widget.userData.id ?? ""}",
                  );
                },
                child: Obx(
                  () => trainerVegetableChallengeViewModel.isLoading.isTrue
                      ? ListView(
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          children: [
                            CustomShimmer(
                              height: 25.h,
                              radius: AppCorner.listTile,
                            ),
                            const Gap(20),
                            CustomShimmer(
                              height: 25.h,
                              radius: AppCorner.listTile,
                            ),
                          ],
                        )
                      : ListView(
                          physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          children: [
                            CustomCard2(
                              color: AppColors.surfaceTertiary,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Obx(
                                    () => TextHeadlineSmall(
                                      text: StringConstants.vegetableSummaryUntilDay.replaceAll(
                                        "{}",
                                        "${trainerVegetableChallengeViewModel.lastUpdateDayOfWeek}",
                                      ),
                                    ),
                                  ),
                                  const Gap(10),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: TextBodySmall(
                                          text: "${StringConstants.redOrangePurpleVegetables}:",
                                          color: AppColors.textPrimary,
                                        ),
                                      ),
                                      Obx(
                                        () => Padding(
                                          padding: const EdgeInsets.only(top: 2.0),
                                          child: SizedBox(
                                            width: 40,
                                            child: TextTitleSmall(
                                              text:
                                                  "${trainerVegetableChallengeViewModel.userShowROPNutrition.length}",
                                              color: AppColors.textPrimary,
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Gap(10),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: TextBodySmall(
                                          text: "${StringConstants.yellowWhiteVegetables}:",
                                          color: AppColors.textPrimary,
                                        ),
                                      ),
                                      Obx(
                                        () => Padding(
                                          padding: const EdgeInsets.only(top: 2.0),
                                          child: SizedBox(
                                            width: 40,
                                            child: TextTitleSmall(
                                              text:
                                                  "${trainerVegetableChallengeViewModel.userShowYWNutrition.length}",
                                              color: AppColors.textPrimary,
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Gap(10),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: TextBodySmall(
                                          text: "${StringConstants.greenVegetables}:",
                                          color: AppColors.textPrimary,
                                        ),
                                      ),
                                      Obx(
                                        () => Padding(
                                          padding: const EdgeInsets.only(top: 2.0),
                                          child: SizedBox(
                                            width: 40,
                                            child: TextTitleSmall(
                                              text:
                                                  "${trainerVegetableChallengeViewModel.userShowGNutrition.length}",
                                              color: AppColors.textPrimary,
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Divider(
                                    color: AppColors.lightGray,
                                    height: 20,
                                  ),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: TextTitleSmall(
                                          text: "${StringConstants.totalVegetables}:",
                                          color: AppColors.textPrimary,
                                        ),
                                      ),
                                      Obx(
                                        () => Padding(
                                          padding: const EdgeInsets.only(top: 2.0),
                                          child: SizedBox(
                                            width: 40,
                                            child: TextTitleSmall(
                                              text:
                                                  "${trainerVegetableChallengeViewModel.userShowROPNutrition.length + trainerVegetableChallengeViewModel.userShowYWNutrition.length + trainerVegetableChallengeViewModel.userShowGNutrition.length}",
                                              color: AppColors.textPrimary,
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const Gap(20),
                          ],
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
