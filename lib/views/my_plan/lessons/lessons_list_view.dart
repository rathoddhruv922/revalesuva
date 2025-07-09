import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:revalesuva/components/custom_click.dart';
import 'package:revalesuva/components/custom_text.dart';
import 'package:revalesuva/generated/assets.dart';
import 'package:revalesuva/model/my_plan/plans/user_plan_model.dart' as user_plan_model;
import 'package:revalesuva/utils/app_colors.dart';
import 'package:revalesuva/utils/app_corner.dart';
import 'package:revalesuva/utils/extension.dart';
import 'package:revalesuva/utils/helper_method.dart';
import 'package:revalesuva/utils/navigation_helper.dart';
import 'package:revalesuva/utils/strings_constant.dart';
import 'package:revalesuva/view_models/my_plan/lessons_view_model.dart';
import 'package:revalesuva/views/my_plan/lessons/lesson_detail/lesson_detail_view.dart';
import 'package:revalesuva/views/my_plan/lessons/widgets/header_message_widget.dart';
import 'package:revalesuva/views/my_plan/lessons/widgets/lesson_item_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class LessonsListView extends StatefulWidget {
  const LessonsListView({super.key, required this.data});

  final user_plan_model.Datum data;

  @override
  State<LessonsListView> createState() => _LessonsListViewState();
}

class _LessonsListViewState extends State<LessonsListView> {
  LessonsViewModel lessonsViewModel = Get.find<LessonsViewModel>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        await lessonsViewModel.getLessonsByPlanId(planId: widget.data.planId.toString());
        await lessonsViewModel.getTaskByLessonId(
          planId: "${widget.data.planId ?? ""}",
        );
        await lessonsViewModel.getUserTaskByLessonId(
          planId: "${widget.data.planId ?? ""}",
        );
        lessonsViewModel.isShowProgramCompletionReport.value =
            lessonsViewModel.listTask.length == lessonsViewModel.lisUserTask.length;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        NavigationHelper.onBackScreen(
          widget: LessonsListView(
            data: widget.data,
          ),
        );
      },
      canPop: true,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Gap(10),
              CustomClick(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: TextBodySmall(
                  text: "< ${StringConstants.backTo} ${StringConstants.myPlan}",
                  color: AppColors.textPrimary,
                  letterSpacing: 0,
                ),
              ),
              const Gap(10),
              Row(
                children: [
                  Expanded(
                    child: TextHeadlineMedium(
                      text: (widget.data.plan?.name ?? "").toCapitalized(),
                      color: AppColors.textPrimary,
                      letterSpacing: 0,
                    ),
                  ),
                  Obx(
                    () => SizedBox(
                      width: 45.w,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Image.asset(
                            Assets.iconsIcErrorRed,
                            width: 18,
                          ),
                          const Gap(5),
                          TextBodySmall(
                            text:
                                "${lessonsViewModel.viewLessons.value}/${lessonsViewModel.totalLessons.value}",
                            maxLine: 1,
                            color: AppColors.textError,
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              Obx(
                () => lessonsViewModel.isShowProgramCompletionReport.value
                    ? const HeaderMessageWidget()
                    : const SizedBox(),
              ),
              Expanded(
                child: Obx(
                  () => lessonsViewModel.isLoading.isTrue
                      ? ListView.separated(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                          itemBuilder: (context, index) {
                            return const CustomShimmer(
                              height: 80,
                              radius: AppCorner.listTile,
                            );
                          },
                          separatorBuilder: (context, index) {
                            return const Gap(10);
                          },
                          itemCount: 10,
                        )
                      : lessonsViewModel.listLessons.isNotEmpty
                          ? RefreshIndicator(
                              onRefresh: () async {
                                await lessonsViewModel.getLessonsByPlanId(
                                    planId: widget.data.planId.toString());
                                await lessonsViewModel.getTaskByLessonId(
                                  planId: "${widget.data.planId ?? ""}",
                                );
                                await lessonsViewModel.getUserTaskByLessonId(
                                  planId: "${widget.data.planId ?? ""}",
                                );
                                lessonsViewModel.isShowProgramCompletionReport.value =
                                    lessonsViewModel.listTask.length ==
                                        lessonsViewModel.lisUserTask.length;
                              },
                              child: ListView.builder(
                                cacheExtent: 100,
                                reverse: true,
                                padding: const EdgeInsets.symmetric(vertical: 20),
                                physics: const AlwaysScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  String status = "";
                                  int previousIndex = index - 1;
                                  if (index > 0) {
                                    if (lessonsViewModel.listLessons[previousIndex].userLessons !=
                                        null) {
                                      status = lessonsViewModel
                                              .listLessons[previousIndex].userLessons?.watchStatus ??
                                          "";
                                    } else {
                                      status = "";
                                    }
                                  } else {
                                    status = "completed";
                                  }
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 5),
                                    child: Column(
                                      children: [
                                        if (lessonsViewModel.listLessons[index].zoomlink?.isNotEmpty ??
                                            false)
                                          CustomClick(
                                            onTap: () async {
                                              showLoader();
                                              final Uri webUri = Uri.parse(
                                                  lessonsViewModel.listLessons[index].zoomlink ?? "");
                                              if (!await launchUrl(webUri,
                                                  mode: LaunchMode.externalApplication)) {
                                                throw Exception('Could not launch $webUri');
                                              }
                                              hideLoader();
                                            },
                                            child: Container(
                                              width: 100.w,
                                              margin: const EdgeInsets.symmetric(
                                                vertical: 5,
                                              ),
                                              padding: const EdgeInsets.symmetric(
                                                horizontal: 10,
                                                vertical: 5,
                                              ),
                                              decoration: BoxDecoration(
                                                color: AppColors.surfaceTertiary,
                                                borderRadius: BorderRadius.circular(AppCorner.listTile),
                                              ),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  TextBodyMedium(
                                                    text: StringConstants.joinTheClassOnTheLink,
                                                    color: AppColors.textPrimary,
                                                  ),
                                                  const Gap(2),
                                                  TextTitleMedium(
                                                    text:
                                                        lessonsViewModel.listLessons[index].zoomlink ?? "",
                                                    color: AppColors.textPrimary,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        CustomClick(
                                          onTap: () {
                                            if (status == "completed" &&
                                                (lessonsViewModel.listLessons[index].days ?? 0) <=
                                                    (lessonsViewModel
                                                                .listLessons[index].daysSincePlanCreated ==
                                                            0
                                                        ? 1
                                                        : lessonsViewModel
                                                                .listLessons[index].daysSincePlanCreated ??
                                                            1)) {
                                              NavigationHelper.pushScreenWithNavBar(
                                                widget: LessonDetailView(
                                                  data: lessonsViewModel.listLessons[index],
                                                  index: index,
                                                ),
                                                context: context,
                                              );
                                            }
                                          },
                                          child: LessonItemWidget(
                                            data: lessonsViewModel.listLessons[index],
                                            previousStatus: status,
                                            index: index,
                                          ),
                                        ),

                                      ],
                                    ),
                                  );
                                },
                                itemCount: lessonsViewModel.listLessons.length,
                              ),
                            )
                          : RefreshIndicator(
                              onRefresh: () async {
                                return await lessonsViewModel.getLessonsByPlanId(
                                    planId: widget.data.planId.toString());
                              },
                              child: noDataFoundWidget(),
                            ),
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
