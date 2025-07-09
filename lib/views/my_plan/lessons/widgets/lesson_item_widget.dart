import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:revalesuva/components/custom_Image_viewer.dart';
import 'package:revalesuva/components/custom_text.dart';
import 'package:revalesuva/generated/assets.dart';
import 'package:revalesuva/model/my_plan/lessons/lessons_model.dart' as lessons_model;
import 'package:revalesuva/model/my_plan/lessons/local_video_player_model.dart';
import 'package:revalesuva/utils/app_colors.dart';
import 'package:revalesuva/utils/app_corner.dart';
import 'package:revalesuva/utils/helper_method.dart';
import 'package:revalesuva/utils/strings_constant.dart';
import 'package:revalesuva/view_models/my_plan/lessons_view_model.dart';

class LessonItemWidget extends StatefulWidget {
  const LessonItemWidget(
      {super.key, required this.data, required this.index, required this.previousStatus});

  final lessons_model.Datum data;
  final String previousStatus;
  final int index;

  @override
  State<LessonItemWidget> createState() => _LessonItemWidgetState();
}

class _LessonItemWidgetState extends State<LessonItemWidget> {
  LocalVideoPlayerModel? data;
  String remains = "";

  @override
  void initState() {
    super.initState();
    LocalVideoPlayerModel? data =
        Get.find<LessonsViewModel>().getVideoInfoFromLocalStorage().firstWhereOrNull(
              (element) => element.id == "${widget.data.id ?? ""}",
            );
    if (data != null &&
        (data.playedLength?.isNotEmpty ?? false) &&
        (data.totalLength?.isNotEmpty ?? false)) {
      String playedTime = formatSeconds(int.tryParse(data.playedLength ?? "")) ?? "00:00";
      String duration = formatSeconds(int.tryParse(data.totalLength ?? "")) ?? "00:00";

      remains = calculateTimeDifference(totalLength: duration, playedLength: playedTime);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.w,
      clipBehavior: Clip.hardEdge,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColors.surfaceTertiary,
        borderRadius: BorderRadius.circular(AppCorner.listTile),
      ),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 80,
              width: 80,
              child: Container(
                margin: const EdgeInsets.all(5),
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  color: AppColors.surfaceBrand,
                  borderRadius: BorderRadius.circular(AppCorner.listTileImage),
                ),
                //child: CustomVideoThumbnail(videoUrl: widget.data.video ?? ""),
                child: CustomImageViewer(
                  imageUrl: widget.data.thumbnailImage ?? "",
                  errorImage: Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: Image.asset(
                      Assets.imagesPlaceholderImg,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            const Gap(5),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      textAlign: TextAlign.start,
                      maxLines: 3,
                      text: TextSpan(
                        style: Theme.of(context).textTheme.bodyMedium?.apply(
                              color: AppColors.textPrimary,
                              heightDelta: -2,
                            ),
                        children: [
                          TextSpan(text: "${StringConstants.lesson} "),
                          TextSpan(text: "${widget.index + 1}:"),
                          TextSpan(
                            text: widget.data.title ?? "",
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ],
                      ),
                    ),
                    const Gap(5),
                    descriptionWidget()
                  ],
                ),
              ),
            ),
            const Gap(5),
            if (widget.data.userLessons != null || widget.previousStatus == "completed")
              Container(
                width: 20.w,
                color: AppColors.surfaceBrand,
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: TextBodySmall(
                    text: StringConstants.lessonSummary,
                    color: AppColors.textPrimary,
                    textAlign: TextAlign.center,
                    maxLine: 3,
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }

  Widget descriptionWidget() {
    if (((widget.data.userLessons != null) && widget.data.userLessons?.watchStatus != null) ||
        (widget.previousStatus == "completed") &&
            (widget.data.days ?? 0) <=
                (widget.data.daysSincePlanCreated == 0 ? 1 : widget.data.daysSincePlanCreated ?? 1)) {
      if (remains.isNotEmpty && widget.data.userLessons?.watchStatus != "completed") {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              Assets.iconsIcErrorRed,
              width: 18,
            ),
            const Gap(5),
            Flexible(
              child: TextBodySmall(
                text: StringConstants.remainingToWatchMin.replaceAll("{}", remains),
                maxLine: 3,
                color: AppColors.textError,
              ),
            ),
          ],
        );
      } else {
        return const SizedBox();
      }
    } else {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            Assets.iconsIcLock,
            width: 15,
          ),
          const Gap(10),
          Flexible(
            child: TextBodySmall(
              text: StringConstants.toWatchTheVideoYouMustCompleteViewingThePreviousVideo,
              maxLine: 3,
              color: AppColors.textError,
            ),
          ),
        ],
      );
    }
  }
}
