import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:revalesuva/components/custom_click.dart';
import 'package:revalesuva/components/custom_text.dart';
import 'package:revalesuva/generated/assets.dart';
import 'package:revalesuva/utils/app_colors.dart';
import 'package:revalesuva/utils/helper_method.dart';
import 'package:revalesuva/utils/navigation_helper.dart';
import 'package:revalesuva/utils/strings_constant.dart';
import 'package:revalesuva/view_models/tools/my_achievements_view_model.dart';
import 'package:revalesuva/views/tools/my_achievements/widget/achievements_item.dart';

class MyAchievementsView extends StatefulWidget {
  const MyAchievementsView({super.key});

  @override
  State<MyAchievementsView> createState() => _MyAchievementsViewState();
}

class _MyAchievementsViewState extends State<MyAchievementsView> {
  final MyAchievementsViewModel myAchievementsViewModel = Get.put(MyAchievementsViewModel());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        myAchievementsViewModel.isLoading.value = true;
        await myAchievementsViewModel.getAllAchievements();
        myAchievementsViewModel.isLoading.value = false;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        NavigationHelper.onBackScreen(widget: const MyAchievementsView());
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
                  text: "< ${StringConstants.backTo} ${StringConstants.tools}",
                  color: AppColors.textPrimary,
                  letterSpacing: 0,
                ),
              ),
              const Gap(10),
              TextHeadlineMedium(
                text: StringConstants.mySuccesses,
                color: AppColors.textPrimary,
                letterSpacing: 0,
              ),
              const Gap(12),
              Expanded(
                child: Obx(
                  () => myAchievementsViewModel.isLoading.isTrue
                      ? CustomShimmer(
                          height: 30.h,
                          width: 100.w,
                          radius: 15,
                        )
                      : RefreshIndicator(
                          onRefresh: () async {
                            return await myAchievementsViewModel.getAllAchievements();
                          },
                          child: ListView(
                            shrinkWrap: true,
                            physics:
                                const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                            children: [
                              CustomCard2(
                                color: AppColors.surfaceTertiary,
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        const ImageIcon(
                                          AssetImage(Assets.iconsIcWeighWhite),
                                        ),
                                        const Gap(10),
                                        Expanded(
                                          child: TextTitleLarge(
                                            text: StringConstants.weight,
                                          ),
                                        )
                                      ],
                                    ),
                                    const Gap(20),
                                    Obx(
                                      () => ListView.separated(
                                        shrinkWrap: true,
                                        physics: const NeverScrollableScrollPhysics(),
                                        itemBuilder: (context, index) {
                                          return AchievementsItem(
                                            data: myAchievementsViewModel.listWeightAchievement[index],
                                          );
                                        },
                                        separatorBuilder: (context, index) {
                                          return const Gap(5);
                                        },
                                        itemCount: myAchievementsViewModel.listWeightAchievement.length,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const Gap(10),
                              CustomCard2(
                                color: AppColors.surfaceTertiary,
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        const ImageIcon(
                                          AssetImage(Assets.iconsIcFastingCalculator),
                                        ),
                                        const Gap(10),
                                        Expanded(
                                          child: TextTitleLarge(
                                            text: StringConstants.fastingCalculator,
                                          ),
                                        )
                                      ],
                                    ),
                                    const Gap(20),
                                    Obx(
                                      () => ListView.separated(
                                        shrinkWrap: true,
                                        physics: const NeverScrollableScrollPhysics(),
                                        itemBuilder: (context, index) {
                                          return AchievementsItem(
                                            data: myAchievementsViewModel.listFastingAchievement[index],
                                          );
                                        },
                                        separatorBuilder: (context, index) {
                                          return const Gap(5);
                                        },
                                        itemCount: myAchievementsViewModel.listFastingAchievement.length,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const Gap(10),
                              CustomCard2(
                                color: AppColors.surfaceTertiary,
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        const ImageIcon(
                                          AssetImage(Assets.iconsIcBody),
                                        ),
                                        const Gap(10),
                                        Expanded(
                                          child: TextTitleLarge(
                                            text: StringConstants.circumference,
                                          ),
                                        )
                                      ],
                                    ),
                                    const Gap(20),
                                    Obx(
                                      () => ListView.separated(
                                        shrinkWrap: true,
                                        physics: const NeverScrollableScrollPhysics(),
                                        itemBuilder: (context, index) {
                                          return AchievementsItem(
                                            data: myAchievementsViewModel
                                                .listMeasurementsAchievement[index],
                                          );
                                        },
                                        separatorBuilder: (context, index) {
                                          return const Gap(5);
                                        },
                                        itemCount:
                                            myAchievementsViewModel.listMeasurementsAchievement.length,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const Gap(10),
                              CustomCard2(
                                color: AppColors.surfaceTertiary,
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        const ImageIcon(
                                          AssetImage(Assets.iconsIcDailyNutritionPlanning),
                                        ),
                                        const Gap(10),
                                        Expanded(
                                          child: TextTitleLarge(
                                            text: StringConstants.dailyNutritionPlanning,
                                          ),
                                        )
                                      ],
                                    ),
                                    const Gap(20),
                                    Obx(
                                      () => ListView.separated(
                                        shrinkWrap: true,
                                        physics: const NeverScrollableScrollPhysics(),
                                        itemBuilder: (context, index) {
                                          return AchievementsItem(
                                            data: myAchievementsViewModel.listDailyNutrition[index],
                                          );
                                        },
                                        separatorBuilder: (context, index) {
                                          return const Gap(5);
                                        },
                                        itemCount: myAchievementsViewModel.listDailyNutrition.length,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const Gap(10),
                              CustomCard2(
                                color: AppColors.surfaceTertiary,
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        const ImageIcon(
                                          AssetImage(Assets.iconsIcTasks),
                                        ),
                                        const Gap(10),
                                        Expanded(
                                          child: TextTitleLarge(
                                            text: StringConstants.tasks,
                                          ),
                                        )
                                      ],
                                    ),
                                    const Gap(20),
                                    Obx(
                                      () => ListView.separated(
                                        shrinkWrap: true,
                                        physics: const NeverScrollableScrollPhysics(),
                                        itemBuilder: (context, index) {
                                          return AchievementsItem(
                                            data: myAchievementsViewModel.listTasks[index],
                                          );
                                        },
                                        separatorBuilder: (context, index) {
                                          return const Gap(5);
                                        },
                                        itemCount: myAchievementsViewModel.listTasks.length,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
