import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:revalesuva/components/custom_click.dart';
import 'package:revalesuva/components/custom_gauge.dart';
import 'package:revalesuva/components/custom_text.dart';
import 'package:revalesuva/components/custom_text_field.dart';
import 'package:revalesuva/utils/app_colors.dart';
import 'package:revalesuva/utils/app_corner.dart';
import 'package:revalesuva/utils/strings_constant.dart';
import 'package:revalesuva/view_models/weighing_and_measuring/weighing_and_measuring_view_model.dart';

class GaugeWidget extends StatelessWidget {
  const GaugeWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Obx(
          () => Stack(
            alignment: Alignment.bottomCenter,
            children: [
              AspectRatio(
                aspectRatio: 18 / 10,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: CustomPaint(
                    painter: GaugePainter(
                      position: double.tryParse(
                            Get.find<WeighingAndMeasuringViewModel>().previousWeight.value,
                          ) ??
                          0,
                    ), // Set the value to point to
                  ),
                ),
              ),
              SizedBox(
                width: 30.w,
                height: 18.w,
                child: Obx(
                  () => Get.find<WeighingAndMeasuringViewModel>().canUpdateWeight.value
                      ? Align(
                          alignment: Alignment.center,
                          child: CustomTextField2(
                            onChange: (value) {
                              Get.find<WeighingAndMeasuringViewModel>().txtWeight.value = value;
                            },
                            hint: StringConstants.weightEntry,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(RegExp(r'^\d+(\.\d{0,2})?$'))
                            ],

                            textInputType: TextInputType.number,
                            suffixIcon: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10.0),
                              child: TextTitleMedium(text: StringConstants.kg),
                            ),

                          ),
                        )
                      : Align(
                          alignment: Alignment.center,
                          child: TextHeadlineLarge(
                            textAlign: TextAlign.center,
                            text: Get.find<WeighingAndMeasuringViewModel>().bmiMessage.value,
                            maxLine: 3,
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
        const Gap(20),
        CustomClick(
          onTap: () {
            if (Get.find<WeighingAndMeasuringViewModel>().canUpdateWeight.value) {
              Get.find<WeighingAndMeasuringViewModel>().updateWeightData();
            } else {
              Get.find<WeighingAndMeasuringViewModel>().canUpdateWeight.value = true;
            }
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppCorner.button),
                border: Border.all(width: 1, color: AppColors.borderPrimary)),
            child: Obx(
              () => TextBodyMedium(
                text: Get.find<WeighingAndMeasuringViewModel>().canUpdateWeight.value
                    ? StringConstants.confirmation
                    : StringConstants.editWeight,
                color: AppColors.textPrimary,
              ),
            ),
          ),
        )
      ],
    );
  }
}
