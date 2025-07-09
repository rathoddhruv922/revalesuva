import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:revalesuva/components/custom_click.dart';
import 'package:revalesuva/components/custom_text.dart';
import 'package:revalesuva/utils/app_colors.dart';
import 'package:revalesuva/utils/app_corner.dart';
import 'package:revalesuva/utils/helper_method.dart';
import 'package:revalesuva/utils/navigation_helper.dart';
import 'package:revalesuva/utils/strings_constant.dart';
import 'package:revalesuva/view_models/making_contact/making_contact_view_model.dart';
import 'package:revalesuva/views/making_contact/trainer_chat/trainer_chat_view.dart';

class TrainerListView extends StatefulWidget {
  const TrainerListView({super.key});

  @override
  State<TrainerListView> createState() => _TrainerListViewState();
}

class _TrainerListViewState extends State<TrainerListView> {
  final MakingContactViewModel makingContactViewModel = Get.find<MakingContactViewModel>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        makingContactViewModel.fetchAllTrainer();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        NavigationHelper.onBackScreen(widget: const TrainerListView());
      },
      canPop: true,
      child: Scaffold(
        body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          children: [
            const Gap(10),
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
            const Gap(10),
            TextHeadlineMedium(
              text: StringConstants.tools,
              color: AppColors.textPrimary,
              letterSpacing: 0,
            ),
            const Gap(10),
            Obx(
              () => makingContactViewModel.isLoading.value
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomShimmer(
                          height: 10.h,
                          width: 100.w,
                          radius: 15,
                        ),
                      ],
                    )
                  : makingContactViewModel.listTrainer.isNotEmpty
                      ? ListView.separated(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return CustomClick(
                              onTap: () {
                                NavigationHelper.pushScreenWithNavBar(
                                  widget: TrainerChatView(
                                    trainerId:
                                        makingContactViewModel.listTrainer[index].trainerId.toString(),
                                    trainerName: makingContactViewModel.listTrainer[index].name ?? "",
                                  ),
                                  context: context,
                                );
                              },
                              child: Container(
                                width: 100.w,
                                padding: const EdgeInsets.all(10),
                                clipBehavior: Clip.hardEdge,
                                decoration: BoxDecoration(
                                  color: AppColors.surfaceTertiary,
                                  borderRadius: BorderRadius.circular(
                                    AppCorner.cardBoarder,
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                                  child: TextTitleMedium(
                                    text: makingContactViewModel.listTrainer[index].name ?? "",
                                    maxLine: 1,
                                  ),
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (context, index) => const Gap(10),
                          itemCount: makingContactViewModel.listTrainer.length,
                        )
                      : noDataFoundWidget(
                          message: StringConstants.noCoachFound,
                        ),
            ),
            const Gap(20),
          ],
        ),
      ),
    );
  }
}
