import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:revalesuva/components/custom_appbar.dart';
import 'package:revalesuva/components/custom_click.dart';
import 'package:revalesuva/components/custom_text.dart';
import 'package:revalesuva/components/list_item.dart';
import 'package:revalesuva/generated/assets.dart';
import 'package:revalesuva/model/trainer/home/customer_model.dart' as customer_model;
import 'package:revalesuva/utils/app_colors.dart';
import 'package:revalesuva/utils/router.dart';
import 'package:revalesuva/utils/strings_constant.dart';
import 'package:revalesuva/views/trainer/widget/drawer_widget.dart';

class CustomerInfoView extends StatelessWidget {
  CustomerInfoView({super.key, required this.data});

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final customer_model.Datum data;

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
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomClick(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: TextBodySmall(
                text: "< ${StringConstants.backTo} ${StringConstants.customer}",
                color: AppColors.textPrimary,
                letterSpacing: 0,
              ),
            ),
            const Gap(10),
            TextHeadlineMedium(
              text: StringConstants.customerOptions,
              color: AppColors.textPrimary,
              letterSpacing: 0,
            ),
            const Gap(10),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(vertical: 20),
                physics: const BouncingScrollPhysics(),
                children: [
                  ListItem(
                    title: StringConstants.dailyReport,
                    onTab: () {
                      Get.toNamed(
                        RoutesName.customerDailyReportView,
                        arguments: data,
                      );
                    },
                    icon: Assets.iconsIcReport,
                  ),
                  const Gap(12),
                  ListItem(
                    title: StringConstants.weeklyReport,
                    onTab: () {
                      Get.toNamed(
                        RoutesName.customerWeeklyReportListView,
                        arguments: data,
                      );
                    },
                    icon: Assets.iconsIcReport,
                  ),
                  const Gap(12),
                  ListItem(
                    title: StringConstants.dailyNutritionPlanning,
                    onTab: () {
                      Get.toNamed(
                        RoutesName.customerDailyNutritionView,
                        arguments: data,
                      );
                    },
                    icon: Assets.iconsIcNutritionPlanning,
                  ),
                  const Gap(12),
                  ListItem(
                    title: StringConstants.allTasks,
                    onTab: () {
                      Get.toNamed(
                        RoutesName.customerTaskListView,
                        arguments: data,
                      );
                    },
                    icon: Assets.iconsIcTasks,
                  ),
                  const Gap(12),
                  ListItem(
                    title: StringConstants.fastingHistory,
                    onTab: () {
                      Get.toNamed(
                        RoutesName.customerFastingHistoryList,
                        arguments: data,
                      );
                    },
                    icon: Assets.iconsIcFastingCalculator,
                  ),
                  const Gap(12),
                  ListItem(
                    title: StringConstants.weightAndMeasurementHistory,
                    onTab: () {
                      Get.toNamed(
                        RoutesName.customerGraphAndReport,
                        arguments: data,
                      );
                    },
                    icon: Assets.iconsIcWeightMachine,
                  ),
                  const Gap(12),
                  ListItem(
                    title: StringConstants.bloodReportInformation,
                    onTab: () {
                      Get.toNamed(
                        RoutesName.customerBloodReportListView,
                        arguments: data,
                      );
                    },
                    icon: Assets.iconsIcReport,
                  ),
                  const Gap(12),
                  ListItem(
                    title: StringConstants.chat,
                    onTab: () {
                      Get.toNamed(
                        RoutesName.customerChatView,
                        arguments: data,
                      );
                    },
                    icon: Assets.iconsIcPrivacyPolicy,
                  ),
                  const Gap(12),
                  ListItem(
                    title: StringConstants.vegetableChallenge,
                    onTab: () {
                      Get.toNamed(
                        RoutesName.customerVegetableChallengeView,
                        arguments: data,
                      );
                    },
                    icon: Assets.iconsIcPrivacyPolicy,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
