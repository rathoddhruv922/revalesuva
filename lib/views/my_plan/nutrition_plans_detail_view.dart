import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:revalesuva/components/custom_text.dart';
import 'package:revalesuva/components/video_media_player.dart';
import 'package:revalesuva/components/vimeo_player.dart';
import 'package:revalesuva/generated/assets.dart';
import 'package:revalesuva/model/my_plan/plans/all_plan_model.dart' as all_plan_model;
import 'package:revalesuva/utils/app_colors.dart';
import 'package:revalesuva/utils/helper_method.dart';
import 'package:revalesuva/utils/navigation_helper.dart';
import 'package:revalesuva/utils/strings_constant.dart';

class NutritionPlansDetailView extends StatelessWidget {
  const NutritionPlansDetailView({
    super.key,
    required this.planData,
  });

  final all_plan_model.Datum planData;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        NavigationHelper.onBackScreen(widget: NutritionPlansDetailView(planData: planData));
      },
      canPop: true,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Gap(10),
              TextHeadlineMedium(text: planData.name ?? ""),
              const Gap(20),
              Expanded(
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  children: [
                    AspectRatio(
                      aspectRatio: 16 / 9,
                      child: (planData.vimeoVideoId ?? "").isNotEmpty
                          ? VimeoPlayer(
                              videoId: planData.vimeoVideoId ?? "",
                            )
                          : VideoMediaPlayer(
                              videoUrl: planData.video ?? "",
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
                                AssetImage(Assets.iconsIcMyPlan),
                              ),
                              const Gap(5),
                              Expanded(
                                child: TextTitleMedium(text: StringConstants.soWhatsOnTheAgenda),
                              ),
                            ],
                          ),
                          const Gap(5),
                          customHtmlWidget(
                            planData.description ?? "",
                          ),
                        ],
                      ),
                    )
                  ],
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
