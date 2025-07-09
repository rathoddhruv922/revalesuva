import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:revalesuva/components/custom_text.dart';
import 'package:revalesuva/utils/app_colors.dart';

class MedicalQuestionProgressbarWidget extends StatelessWidget {
  const MedicalQuestionProgressbarWidget({super.key, required this.value, required this.max});

  final double value;
  final double max;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 5.h,
      child: Stack(
        children: [
          Directionality(
            textDirection: Get.locale?.languageCode != "he" ? TextDirection.rtl : TextDirection.ltr,
            child: SliderTheme(
              data: SliderTheme.of(context).copyWith(
                trackHeight: 12,
                tickMarkShape: const RoundSliderTickMarkShape(),
                thumbShape: const RoundSliderThumbShape(
                  enabledThumbRadius: 7.0,
                  disabledThumbRadius: 8.0,
                  elevation: 0,
                  pressedElevation: 0,
                ),
                trackShape: const RoundedRectSliderTrackShape(),
                disabledThumbColor: Colors.white,
                thumbColor: Colors.white,
              ),
              child: Slider(
                value: value + 1, // Adjusting the value to start from 1
                max: max, // Adjusting the max to end at 10
                min: 1, // Setting the minimum to 1
                allowedInteraction: SliderInteraction.tapOnly,
                activeColor: AppColors.surfaceGreen,
                inactiveColor: AppColors.surfacePrimary,
                onChanged: (double value) {},
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: TextBodySmall(
              text: "${value.toInt() + 1}/${max.toInt()}", // Adjusting the displayed value
              color: AppColors.textPrimary,
              size: -2,
            ),
          )
        ],
      ),
    );
  }
}
