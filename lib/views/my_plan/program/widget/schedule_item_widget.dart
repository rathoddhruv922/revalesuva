import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:revalesuva/components/custom_button.dart';
import 'package:revalesuva/components/custom_text.dart';
import 'package:revalesuva/generated/assets.dart';
import 'package:revalesuva/model/my_plan/program/program_schedule_model.dart' as program_schedule_model;
import 'package:revalesuva/utils/app_colors.dart';
import 'package:revalesuva/utils/app_corner.dart';
import 'package:revalesuva/utils/extension.dart';
import 'package:revalesuva/utils/helper_method.dart';
import 'package:revalesuva/utils/strings_constant.dart';
import 'package:revalesuva/view_models/my_plan/program_view_model.dart';

class ScheduleItemWidget extends StatelessWidget {
  ScheduleItemWidget({super.key, required this.data, required this.programId});

  final program_schedule_model.Datum data;
  final String programId;
  final ProgramViewModel programViewModel = Get.find<ProgramViewModel>();

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsetsDirectional.only(top: 40, start: 20),
          child: TextBodySmall(
            text: convertToTimeString(data.time ?? ""),
            color: AppColors.textPrimary,
          ),
        ),
        const Gap(30),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: (programViewModel.getScheduleStatus(data: data)["status"] == "registered" ||
                      programViewModel.getScheduleStatus(data: data)["status"] == "waiting")
                  ? AppColors.surfaceBlueLight
                  : AppColors.surfaceTertiary,
              borderRadius: BorderRadius.circular(
                AppCorner.cardBoarder,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextTitleSmall(
                  text: data.name?.toCapitalized() ?? "",
                ),
                const Gap(10),
                Row(
                  children: [
                    const ImageIcon(
                      AssetImage(Assets.iconsIcTrainner),
                      size: 20,
                    ),
                    const Gap(5),
                    Expanded(
                      child: TextBodySmall(
                        text: StringConstants.instructor
                            .replaceAll("{}", data.instructor?.toCapitalized() ?? ""),
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ],
                ),
                const Gap(5),
                Row(
                  children: [
                    const ImageIcon(
                      AssetImage(Assets.iconsIcPeople),
                      size: 20,
                    ),
                    const Gap(5),
                    Expanded(
                      child: TextBodySmall(
                        text: programViewModel.getScheduleStatus(data: data)["participants_message"],
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ],
                ),
                const Gap(10),
                Align(
                  alignment: AlignmentDirectional.bottomEnd,
                  child: CustomButton(
                    backgroundColor:
                        (programViewModel.getScheduleStatus(data: data)["status"] == "registered" ||
                                programViewModel.getScheduleStatus(data: data)["status"] == "waiting")
                            ? AppColors.surfaceBlueDark
                            : AppColors.surfaceBlue,
                    text: programViewModel.getScheduleStatus(data: data)["show_message"],
                    onPressed: () async {
                      if (programViewModel.getScheduleStatus(data: data)["status"] == "registered" ||
                          programViewModel.getScheduleStatus(data: data)["status"] == "waiting") {
                        await programViewModel.exitSchedule(
                          programId: programId,
                          scheduleId: data.id.toString(),
                          status: programViewModel.getScheduleStatus(data: data)["status"],
                        );
                      } else {
                        await programViewModel.addSchedule(
                          programId: programId,
                          scheduleId: data.id.toString(),
                          status:
                              programViewModel.getScheduleStatus(data: data)["status"] ?? "registered",
                        );
                      }
                    },
                    textColor: AppColors.textTertiary,
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
