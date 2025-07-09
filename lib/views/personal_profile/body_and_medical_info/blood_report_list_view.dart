import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:revalesuva/components/custom_click.dart';
import 'package:revalesuva/components/custom_text.dart';
import 'package:revalesuva/generated/assets.dart';
import 'package:revalesuva/utils/app_colors.dart';
import 'package:revalesuva/utils/app_corner.dart';
import 'package:revalesuva/utils/date_format_helper.dart';
import 'package:revalesuva/utils/helper_method.dart';
import 'package:revalesuva/utils/navigation_helper.dart';
import 'package:revalesuva/utils/strings_constant.dart';
import 'package:revalesuva/view_models/personal_profile/personal_profile_view_model.dart';
import 'package:url_launcher/url_launcher.dart';

class BloodReportListView extends StatefulWidget {
  const BloodReportListView({super.key});

  @override
  State<BloodReportListView> createState() => _BloodReportListViewState();
}

class _BloodReportListViewState extends State<BloodReportListView> {
  final PersonalProfileViewModel personalProfileViewModel = Get.find<PersonalProfileViewModel>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        personalProfileViewModel.isLoading.value = true;
        await personalProfileViewModel.getCustomerDetailById();
        personalProfileViewModel.isLoading.value = false;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        NavigationHelper.onBackScreen(widget: const BloodReportListView());
      },
      canPop: true,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Gap(10),
              CustomClick(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: TextBodySmall(
                  text: "< ${StringConstants.backTo} ${StringConstants.bodyDataAndMedicalInformation}",
                  color: AppColors.textPrimary,
                  letterSpacing: 0,
                ),
              ),
              const Gap(10),
              TextHeadlineMedium(
                text: StringConstants.bloodReportInformation,
                color: AppColors.textPrimary,
                letterSpacing: 0,
              ),
              const Gap(12),
              Expanded(
                child: Obx(
                  () => personalProfileViewModel.isLoading.isTrue
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
                      : personalProfileViewModel.listBloodTest.isNotEmpty ?? false
                          ? RefreshIndicator(
                              onRefresh: () {
                                return personalProfileViewModel.onCreate();
                              },
                              child: ListView.separated(
                                shrinkWrap: true,
                                physics:
                                    const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                                itemBuilder: (context, index) {
                                  return CustomClick(
                                    onTap: () async {
                                      final Uri fileUrl = Uri.parse(personalProfileViewModel
                                              .listBloodTest[index].bloodTestReport ??
                                          "");
                                      if (!await launchUrl(
                                        fileUrl,
                                        mode: LaunchMode
                                            .externalApplication, // Opens in an embedded WebView
                                      )) {
                                        throw 'Could not launch';
                                      }
                                    },
                                    child: Container(
                                      width: 100.w,
                                      clipBehavior: Clip.hardEdge,
                                      decoration: BoxDecoration(
                                        color: AppColors.surfaceTertiary,
                                        borderRadius: BorderRadius.circular(
                                          AppCorner.listTile,
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 10,
                                          horizontal: 10,
                                        ),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: TextTitleMedium(
                                                text:
                                                    "${StringConstants.bloodReportInformation} ${(personalProfileViewModel.listBloodTest.length) - index}",
                                                maxLine: 1,
                                              ),
                                            ),
                                            TextBodySmall(
                                              text: changeDateStringFormat(
                                                date: personalProfileViewModel
                                                        .listBloodTest[index].createdAt ??
                                                    "",
                                                format: DateFormatHelper.mdyFormat,
                                              ),
                                              color: AppColors.textSecondary,
                                            ),
                                            const Gap(10),
                                            const ImageIcon(
                                              AssetImage(Assets.iconsIcArrowLeft),
                                              size: 15,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                separatorBuilder: (context, index) => const Gap(10),
                                itemCount: personalProfileViewModel.listBloodTest.length,
                              ),
                            )
                          : RefreshIndicator(
                              onRefresh: () {
                                return personalProfileViewModel.onCreate();
                              },
                              child: SingleChildScrollView(
                                physics: const AlwaysScrollableScrollPhysics(),
                                child: Container(
                                  alignment: Alignment.center,
                                  height: 50.h,
                                  child: TextHeadlineMedium(text: StringConstants.noDataFound),
                                ),
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
