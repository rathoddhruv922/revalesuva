import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:revalesuva/components/custom_click.dart';
import 'package:revalesuva/components/custom_text.dart';
import 'package:revalesuva/model/my_plan/lessons/lessons_model.dart' as lessons_model;
import 'package:revalesuva/model/my_plan/lessons/local_video_player_model.dart';
import 'package:revalesuva/utils/app_colors.dart';
import 'package:revalesuva/utils/app_corner.dart';
import 'package:revalesuva/utils/extension.dart';
import 'package:revalesuva/utils/helper_method.dart';
import 'package:revalesuva/utils/navigation_helper.dart';
import 'package:revalesuva/utils/strings_constant.dart';
import 'package:revalesuva/view_models/my_plan/lessons_view_model.dart';
import 'package:revalesuva/views/my_plan/lessons/lesson_detail/widget/lesson_description_widget.dart';
import 'package:revalesuva/views/my_plan/lessons/lesson_detail/widget/lesson_task_widget.dart';
import 'package:revalesuva/views/my_plan/lessons/lesson_detail/widget/video_view_widget.dart';

class LessonDetailView extends StatefulWidget {
  const LessonDetailView({super.key, required this.data, required this.index});

  final lessons_model.Datum data;
  final int index;

  @override
  State<LessonDetailView> createState() => _LessonDetailViewState();
}

class _LessonDetailViewState extends State<LessonDetailView> {
  LessonsViewModel lessonsViewModel = Get.find<LessonsViewModel>();
  int localId = -1;
  LocalVideoPlayerModel? data;
  bool isLoading = false;
  String watchStatus = "";

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        lessonsViewModel.isLoading.value = true;
        await lessonsViewModel.createUserLessonByLessonId(
          lessonId: "${widget.data.id ?? ""}",
        );
        await onCreate();
        lessonsViewModel.isLoading.value = false;
      },
    );
  }

  onCreate() async {
    await lessonsViewModel.getLessonsByPlanId(planId: widget.data.planId.toString());
    localId = _getLocalVideoIndex();
    if (localId == -1) {
      await lessonsViewModel.addVideoInfoInLocalStorage(
        totalLength: "",
        playedLength: "",
        data: widget.data,
      );
      localId = _getLocalVideoIndex();
    }
    data = lessonsViewModel.getVideoById(index: localId);

    watchStatus = widget.data.userLessons?.watchStatus ?? "";
    setState(() {});
  }

  int _getLocalVideoIndex() {
    return lessonsViewModel.getVideoInfoFromLocalStorage().indexWhere(
          (element) => element.id == "${widget.data.id}",
        );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (didPop, result) async {
        NavigationHelper.onBackScreen(
          widget: LessonDetailView(
            data: widget.data,
            index: widget.index,
          ),
        );

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
              RichText(
                textAlign: TextAlign.start,
                maxLines: 2,
                text: TextSpan(
                  style: Theme.of(context).textTheme.bodyMedium?.apply(
                        color: AppColors.textPrimary,
                      ),
                  children: [
                    TextSpan(text: "${StringConstants.lesson} "),
                    TextSpan(text: "${widget.index + 1}:"),
                    TextSpan(
                      text: "${widget.data.title}".toCapitalized(),
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ],
                ),
              ),
              Obx(
                () => lessonsViewModel.isLoading.isFalse
                    ? Expanded(
                        child: ListView(
                          children: [
                            const Gap(10),
                            (widget.data.vimeoVideoId ?? "").isNotEmpty
                                ? VimeoViewWidget(
                                    vimeoVideoId: widget.data.vimeoVideoId ?? "",
                                    playedLength: data?.playedLength ?? "",
                                    onProgressChanged: (position, duration) async {
                                      if (duration.inSeconds != 0) {
                                        final isCompleted = position.inSeconds >= duration.inSeconds;
                                        final currentStatus =
                                            isCompleted ? "completed" : data?.status ?? "";

                                        lessonsViewModel.updateVideoInfoInLocalStorage(
                                          index: localId,
                                          totalLength: duration.inSeconds.toString(),
                                          playedLength: position.inSeconds.toString(),
                                          status: currentStatus,
                                        );
                                        if (isCompleted && watchStatus != "completed") {
                                          final isSuccess =
                                              await lessonsViewModel.lessonUpdateWatchStatus(
                                            lessonId: "${widget.data.id ?? ""}",
                                            status: currentStatus,
                                          );

                                          if (isSuccess) {
                                            watchStatus = "completed";
                                            setState(() {});
                                          }
                                        }
                                      }
                                    },
                                  )
                                : VideoViewWidget(
                                    videoUrl: widget.data.video ?? "",
                                    playedLength: data?.playedLength ?? "",
                                    onProgressChanged: (position, duration) async {
                                      if (duration.inSeconds != 0) {
                                        final isCompleted = position.inSeconds >= duration.inSeconds;
                                        final currentStatus =
                                            isCompleted ? "completed" : data?.status ?? "";

                                        lessonsViewModel.updateVideoInfoInLocalStorage(
                                          index: localId,
                                          totalLength: duration.inSeconds.toString(),
                                          playedLength: position.inSeconds.toString(),
                                          status: currentStatus,
                                        );
                                        if (isCompleted && watchStatus != "completed") {
                                          final isSuccess =
                                              await lessonsViewModel.lessonUpdateWatchStatus(
                                            lessonId: "${widget.data.id ?? ""}",
                                            status: currentStatus,
                                          );

                                          if (isSuccess) {
                                            watchStatus = "completed";
                                            setState(() {});
                                          }
                                        }
                                      }
                                    },
                                  ),
                            const Gap(10),
                            watchStatus == "completed"
                                ? Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 10),
                                    child: Column(
                                      children: [
                                        LessonDescriptionWidget(
                                          index: widget.index,
                                          title: widget.data.title ?? "",
                                          description: widget.data.description ?? "",
                                          pdfFileUrl: widget.data.document ?? "",
                                        ),
                                        const Gap(20),
                                        FutureBuilder(
                                          future: taskApiCalling(),
                                          builder: (context, snapshot) {
                                            if (snapshot.connectionState == ConnectionState.waiting) {
                                              return const CustomShimmer(
                                                height: 50,
                                                radius: AppCorner.listTile,
                                              );
                                            } else {
                                              return LessonTaskWidget(
                                                listData: lessonsViewModel.listTask,
                                                listUserData: lessonsViewModel.lisUserTask,
                                                planId: "${widget.data.planId ?? ""}",
                                              );
                                            }
                                          },
                                        )
                                      ],
                                    ),
                                  )
                                : TextTitleMedium(
                                    text: StringConstants
                                        .atTheEndOfTheLessonYouWillBeAbleToViewTheLessonSummaryAndTasks,
                                    color: AppColors.textPrimary,
                                  ),
                          ],
                        ),
                      )
                    : const Column(
                        children: [
                          Gap(10),
                          AspectRatio(
                            aspectRatio: 16 / 9,
                            child: CustomShimmer(
                              radius: AppCorner.listTile,
                            ),
                          ),
                          Gap(20),
                          CustomShimmer(
                            height: 50,
                            radius: AppCorner.listTile,
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

  taskApiCalling() async {
    await lessonsViewModel.getTaskByLessonId(
      lessonId: "${widget.data.id ?? ""}",
    );
    await lessonsViewModel.getUserTaskByLessonId(
      lessonId: "${widget.data.id ?? ""}",
    );
    lessonsViewModel.isShowProgramCompletionReport.value =
        lessonsViewModel.listTask.length == lessonsViewModel.lisUserTask.length;
  }
}
