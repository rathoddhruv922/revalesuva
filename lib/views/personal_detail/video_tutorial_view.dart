import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:revalesuva/components/custom_appbar.dart';
import 'package:revalesuva/components/custom_button.dart';
import 'package:revalesuva/components/custom_text.dart';
import 'package:revalesuva/components/video_media_player.dart';
import 'package:revalesuva/components/vimeo_player.dart';
import 'package:revalesuva/utils/router.dart';
import 'package:revalesuva/utils/strings_constant.dart';
import 'package:revalesuva/view_models/personal_detail/common_media_view_model.dart';

class VideoTutorialView extends StatelessWidget {
  const VideoTutorialView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(),
      body: Container(
        width: 100.w,
        padding: const EdgeInsets.symmetric(
          horizontal: 35.0,
        ),
        child: Column(
          textDirection: Get.locale?.languageCode == "he" ? TextDirection.rtl : TextDirection.ltr,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Gap(30),
            TextHeadlineLarge(
              text: StringConstants.videoTutorialScreenTitle,
              textAlign: TextAlign.center,
            ),
            const Gap(20),
            Obx(
              () => Get.find<CommonMediaViewModel>().letsGetStartedVideoId.value.isNotEmpty
                  ? VimeoPlayer(
                      videoId: Get.find<CommonMediaViewModel>().letsGetStartedVideoId.value,
                    )
                  : VideoMediaPlayer(
                      videoUrl: Get.find<CommonMediaViewModel>().letsGetStarted.value,
                    ),
            ),
            const Gap(30),
            SimpleButton(
              onPressed: () {
                Get.offAllNamed(RoutesName.home);
              },
              text: StringConstants.letsGetStarted,
            ),
          ],
        ),
      ),
    );
  }
}
