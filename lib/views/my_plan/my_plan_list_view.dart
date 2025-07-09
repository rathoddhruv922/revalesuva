import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:revalesuva/components/custom_click.dart';
import 'package:revalesuva/components/custom_text.dart';
import 'package:revalesuva/components/list_item.dart';
import 'package:revalesuva/generated/assets.dart';
import 'package:revalesuva/utils/app_colors.dart';
import 'package:revalesuva/utils/helper_method.dart';
import 'package:revalesuva/utils/navigation_helper.dart';
import 'package:revalesuva/utils/strings_constant.dart';
import 'package:revalesuva/view_models/my_plan/my_plan_view_model.dart';
import 'package:revalesuva/views/my_plan/my_plan_option_list_view.dart';
import 'package:revalesuva/views/my_plan/program/program_detail_view.dart';
import 'package:revalesuva/views/my_plan/program_summary_report/program_summary_view.dart';
import 'package:revalesuva/views/my_plan/widget/plan_item.dart';

class MyPlanListView extends StatefulWidget {
  const MyPlanListView({super.key, this.isShowBack = true});

  final bool isShowBack;

  @override
  State<MyPlanListView> createState() => _MyPlanListViewState();
}

class _MyPlanListViewState extends State<MyPlanListView> {
  MyPlanViewModel myPlanViewModel = Get.put(
    MyPlanViewModel(),
    permanent: true,
  );

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        myPlanViewModel.isLoading.value = true;
        await myPlanViewModel.getActivePlan();
        await myPlanViewModel.getCompletedPlan();
        await myPlanViewModel.getUserActiveProgram();
        myPlanViewModel.isLoading.value = false;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        NavigationHelper.onBackScreen(widget: const MyPlanListView());
      },
      canPop: true,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Gap(10),
              if (widget.isShowBack)
                CustomClick(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: TextBodySmall(
                    text: "< ${StringConstants.backTo} ${StringConstants.personalArea}",
                    color: AppColors.textPrimary,
                    letterSpacing: 0,
                  ),
                ),
              Expanded(
                child: Obx(
                  () => myPlanViewModel.isLoading.value
                      ? ListView(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          physics: const BouncingScrollPhysics(),
                          children: [
                            CustomShimmer(
                              height: 5.h,
                              width: 100.w,
                              radius: 15,
                            ),
                            const Gap(10),
                            CustomShimmer(
                              height: 5.h,
                              width: 100.w,
                              radius: 15,
                            ),
                            const Gap(30),
                            CustomShimmer(
                              height: 5.h,
                              width: 100.w,
                              radius: 15,
                            ),
                            const Gap(10),
                            CustomShimmer(
                              height: 5.h,
                              width: 100.w,
                              radius: 15,
                            ),
                            const Gap(30),
                            CustomShimmer(
                              height: 5.h,
                              width: 100.w,
                              radius: 15,
                            ),
                            const Gap(10),
                            CustomShimmer(
                              height: 5.h,
                              width: 100.w,
                              radius: 15,
                            ),
                          ],
                        )
                      : RefreshIndicator(
                          onRefresh: () async {
                            myPlanViewModel.isLoading.value = true;
                            await myPlanViewModel.getActivePlan();
                            await myPlanViewModel.getCompletedPlan();
                            myPlanViewModel.isLoading.value = false;
                          },
                          child: ListView(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            physics: const BouncingScrollPhysics(
                              parent: AlwaysScrollableScrollPhysics(),
                            ),
                            children: [
                              TextHeadlineMedium(text: StringConstants.myPrograms),
                              const Gap(10),
                              Obx(
                                () => (myPlanViewModel.userPlanDetail.value.plan?.name?.isNotEmpty ??
                                        false)
                                    ? ListItem(
                                        title: myPlanViewModel.userPlanDetail.value.plan?.name ?? "",
                                        onTab: () {
                                          NavigationHelper.pushScreenWithNavBar(
                                            widget: MyPlanOptionListView(
                                              data: myPlanViewModel.userPlanDetail.value,
                                            ),
                                            context: context,
                                          );
                                        },
                                        icon: Assets.iconsIcStrongHealthy,
                                        backgroundColor: AppColors.surfaceGreen,
                                        textColor: AppColors.surfaceTertiary,
                                      )
                                    : const SizedBox(),
                              ),
                              const Gap(10),
                              Obx(
                                () => myPlanViewModel.listActiveProgram.isEmpty
                                    ? const SizedBox()
                                    : ListItem(
                                        title:
                                            myPlanViewModel.listActiveProgram.first.program?.name ?? "",
                                        backgroundColor: AppColors.surfaceBlueLight,
                                        onTab: () {
                                          NavigationHelper.pushScreenWithNavBar(
                                            widget: ProgramDetailView(
                                              programId: myPlanViewModel
                                                  .listActiveProgram.first.programId
                                                  .toString(),
                                            ),
                                            context: context,
                                          );
                                        },
                                        icon: Assets.iconsIcIceTherapy,
                                      ),
                              ),
                              const Gap(30),
                              Obx(
                                () => (myPlanViewModel.userContinuationProgramsDetail.value.plan?.name
                                            ?.isNotEmpty ??
                                        false)
                                    ? Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          TextHeadlineMedium(text: StringConstants.continuationPrograms),
                                          const Gap(10),
                                          ListItem(
                                            title: myPlanViewModel
                                                    .userContinuationProgramsDetail.value.plan?.name ??
                                                "",
                                            onTab: () {},
                                            icon: Assets.iconsIcStrongHealthy,
                                          )
                                        ],
                                      )
                                    : const SizedBox(),
                              ),
                              const Gap(30),
                              Obx(
                                () => (myPlanViewModel.listUserCompletedPlan.isNotEmpty)
                                    ? Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          TextHeadlineMedium(text: StringConstants.completedPrograms),
                                          const Gap(10),
                                          ListView.separated(
                                            physics: const NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            itemBuilder: (context, index) {
                                              return PlanItem(
                                                planData: myPlanViewModel.listUserCompletedPlan[index],
                                                icon: Assets.iconsIcStrongHealthy,
                                                reminder: StringConstants.programSummary,
                                                onTab: () {
                                                  NavigationHelper.pushScreenWithNavBar(
                                                    widget: const ProgramSummaryView(),
                                                    context: context,
                                                  );
                                                },
                                              );
                                            },
                                            separatorBuilder: (context, index) => const Gap(10),
                                            itemCount: myPlanViewModel.listUserCompletedPlan.length,
                                          )
                                        ],
                                      )
                                    : const SizedBox(),
                              ),
                            ],
                          ),
                        ),
                ),
              ),
              const Gap(80),
            ],
          ),
        ),
      ),
    );
  }
}
