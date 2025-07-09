import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:revalesuva/components/custom_click.dart';
import 'package:revalesuva/components/custom_text.dart';
import 'package:revalesuva/generated/assets.dart';
import 'package:revalesuva/model/making_contact/get_support_service_model.dart'
    as get_support_service_model;
import 'package:revalesuva/utils/app_colors.dart';
import 'package:revalesuva/utils/helper_method.dart';
import 'package:revalesuva/utils/navigation_helper.dart';
import 'package:revalesuva/utils/strings_constant.dart';
import 'package:revalesuva/view_models/making_contact/making_contact_view_model.dart';
import 'package:revalesuva/views/making_contact/contact_us_list_view.dart';
import 'package:revalesuva/views/making_contact/widget/message_item_widget.dart';

class InquiryServiceListView extends StatefulWidget {
  const InquiryServiceListView({super.key});

  @override
  State<InquiryServiceListView> createState() => _InquiryServiceListViewState();
}

class _InquiryServiceListViewState extends State<InquiryServiceListView> {
  final MakingContactViewModel makingContactViewModel = Get.find<MakingContactViewModel>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        makingContactViewModel.checkAll.value = false;
        makingContactViewModel.isLoading.value = false;
        makingContactViewModel.isLoadingMore.value = false;
        makingContactViewModel.listMessage.clear();
        makingContactViewModel.listDelete.clear();
        makingContactViewModel.currentPage.value = 1;
        makingContactViewModel.total.value = 1;
        await makingContactViewModel.fetchInquiryService();
        makingContactViewModel.scrollController = ScrollController();
        makingContactViewModel.setupScrollController();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        NavigationHelper.onBackScreen(widget: const InquiryServiceListView());
      },
      canPop: true,
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: AppColors.surfaceGreen,
          mini: true,
          child: const Icon(
            Icons.add,
            size: 20,
            color: AppColors.textPrimary,
          ),
          onPressed: () {
            NavigationHelper.pushScreenWithNavBar(widget: const InquiryServiceView(), context: context);
          },
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20.0,
            vertical: 10.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            textDirection: Get.locale?.languageCode == "he" ? TextDirection.rtl : TextDirection.ltr,
            children: [
              CustomClick(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: TextBodySmall(
                  text: "< ${StringConstants.backTo} ${StringConstants.contactUs}",
                  color: AppColors.textPrimary,
                  letterSpacing: 0,
                ),
              ),
              const Gap(10),
              TextHeadlineMedium(
                text: StringConstants.technicalSupport,
                color: AppColors.textPrimary,
                letterSpacing: 0,
              ),
              const Gap(10),
              Obx(
                () => makingContactViewModel.listMessage.isNotEmpty ? Row(
                  children: [
                    Checkbox(
                      activeColor: AppColors.surfaceGreen,
                      semanticLabel: "Select All",
                      value: makingContactViewModel.checkAll.value,
                      onChanged: (value) {
                        makingContactViewModel.checkAll.toggle();
                        if (makingContactViewModel.checkAll.isTrue) {
                          makingContactViewModel.listDelete.clear();
                          for (var items in makingContactViewModel.listMessage) {
                            makingContactViewModel.listDelete.add(items.id ?? 0);
                          }
                        } else {
                          makingContactViewModel.listDelete.clear();
                        }
                        makingContactViewModel.listDelete.refresh();
                      },
                    ),
                    Flexible(
                      child: TextBodyMedium(
                        text: StringConstants.delete,
                        color: AppColors.textError,
                        letterSpacing: 0,
                      ),
                    ),
                    const Gap(10),
                    makingContactViewModel.listDelete.isNotEmpty
                        ? Flexible(
                            child: CustomClick(
                              onTap: () {
                                makingContactViewModel.deleteMessageSupport(
                                    id: 0, messageType: "inquiry");
                              },
                              child: Row(
                                children: [
                                  const ImageIcon(
                                    AssetImage(Assets.iconsTrash),
                                    size: 20,
                                    color: AppColors.textError,
                                  ),
                                  const Gap(10),
                                  TextBodyMedium(
                                    text: StringConstants.delete,
                                    color: AppColors.textError,
                                    letterSpacing: 0,
                                  ),
                                ],
                              ),
                            ),
                          )
                        : const SizedBox()
                  ],
                ):const SizedBox(),
              ),
              const Gap(10),
              Expanded(
                child: Obx(
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
                      : (makingContactViewModel.listMessage.isNotEmpty)
                          ? RefreshIndicator(
                              onRefresh: () {
                                makingContactViewModel.currentPage.value = 1;
                                return makingContactViewModel.fetchInquiryService();
                              },
                              child: ListView.separated(
                                physics:
                                    const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                                controller: makingContactViewModel.scrollController,
                                itemBuilder: (context, index) {
                                  get_support_service_model.Datum data =
                                      makingContactViewModel.listMessage[index];
                                  return MessageItemWidget(
                                    data: data,
                                    index: index,
                                    messageType: "inquiry",
                                  );
                                },
                                separatorBuilder: (context, index) => const Gap(20),
                                itemCount: makingContactViewModel.listMessage.length,
                              ),
                            )
                          : RefreshIndicator(
                              onRefresh: () {
                                makingContactViewModel.currentPage.value = 1;
                                return makingContactViewModel.fetchInquiryService();
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
              Obx(
                () => makingContactViewModel.isLoadingMore.value
                    ? const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: CupertinoActivityIndicator(
                          radius: 15,
                        ),
                      )
                    : const SizedBox.shrink(),
              ),
              const Gap(10),
            ],
          ),
        ),
      ),
    );
  }
}
