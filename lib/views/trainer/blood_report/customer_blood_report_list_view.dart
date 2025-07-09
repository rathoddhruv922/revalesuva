import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:revalesuva/components/custom_appbar.dart';
import 'package:revalesuva/components/custom_click.dart';
import 'package:revalesuva/components/custom_text.dart';
import 'package:revalesuva/generated/assets.dart';
import 'package:revalesuva/model/trainer/home/customer_model.dart' as customer_model;
import 'package:revalesuva/utils/app_colors.dart';
import 'package:revalesuva/utils/app_corner.dart';
import 'package:revalesuva/utils/date_format_helper.dart';
import 'package:revalesuva/utils/helper_method.dart';
import 'package:revalesuva/utils/strings_constant.dart';
import 'package:revalesuva/view_models/trainer/trainner_blood_report_view_model.dart';
import 'package:revalesuva/views/trainer/widget/drawer_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomerBloodReportListView extends StatefulWidget {
  const CustomerBloodReportListView({super.key, required this.data});

  final customer_model.Datum data;

  @override
  State<CustomerBloodReportListView> createState() => _CustomerBloodReportListViewState();
}

class _CustomerBloodReportListViewState extends State<CustomerBloodReportListView> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  final BloodReportViewModel bloodReportViewModel = Get.put(BloodReportViewModel());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        bloodReportViewModel.isLoading.value = true;
        await bloodReportViewModel.getCustomerDetailById(customerId: "${widget.data.id ?? ""}");
        bloodReportViewModel.isLoading.value = false;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: customAppBarTrainer(
        key: scaffoldKey,
      ),
      drawer: DrawerWidget(
        drawerKey: scaffoldKey,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomClick(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: TextBodySmall(
                text: "< ${StringConstants.backTo} ${StringConstants.customerOptions}",
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
            const Gap(10),
            Expanded(
              child: Obx(
                () => bloodReportViewModel.isLoading.isTrue
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
                    : bloodReportViewModel.listBloodTest.isNotEmpty ?? false
                        ? RefreshIndicator(
                            onRefresh: () {
                              return bloodReportViewModel.getCustomerDetailById(
                                  customerId: "${widget.data.id ?? ""}");
                            },
                            child: ListView.separated(
                              itemBuilder: (context, index) {
                                return CustomClick(
                                  onTap: () async {
                                    final Uri fileUrl = Uri.parse(
                                        bloodReportViewModel.listBloodTest[index].bloodTestReport ?? "");
                                    if (!await launchUrl(
                                      fileUrl,
                                      mode:
                                          LaunchMode.externalApplication, // Opens in an embedded WebView
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
                                                  "${StringConstants.bloodReportInformation} ${(bloodReportViewModel.listBloodTest.length) - index}",
                                              maxLine: 1,
                                            ),
                                          ),
                                          TextBodySmall(
                                            text: changeDateStringFormat(
                                              date:
                                                  bloodReportViewModel.listBloodTest[index].createdAt ??
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
                              itemCount: bloodReportViewModel.listBloodTest.length,
                            ),
                          )
                        : RefreshIndicator(
                            onRefresh: () {
                              return bloodReportViewModel.getCustomerDetailById(
                                  customerId: "${widget.data.id ?? ""}");
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
          ],
        ),
      ),
    );
  }
}
