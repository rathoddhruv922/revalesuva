import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:revalesuva/components/custom_click.dart';
import 'package:revalesuva/components/custom_text.dart';
import 'package:revalesuva/generated/assets.dart';
import 'package:revalesuva/model/general_message/general_message_model.dart' as general_message_model;
import 'package:revalesuva/utils/app_colors.dart';
import 'package:revalesuva/utils/helper_method.dart';
import 'package:revalesuva/utils/navigation_helper.dart';
import 'package:revalesuva/utils/strings_constant.dart';
import 'package:revalesuva/view_models/general_message/general_message_view_model.dart';
import 'package:revalesuva/views/general_message/widget/general_message_item_widget.dart';

class GeneralMessageListView extends StatefulWidget {
  const GeneralMessageListView({super.key});

  @override
  State<GeneralMessageListView> createState() => _GeneralMessageListViewState();
}

class _GeneralMessageListViewState extends State<GeneralMessageListView> {
  final GeneralMessageViewModel generalMessageViewModel = Get.put(GeneralMessageViewModel());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        generalMessageViewModel.checkAll.value = false;
        generalMessageViewModel.isLoading.value = false;
        generalMessageViewModel.isLoadingMore.value = false;
        generalMessageViewModel.listMessage.clear();
        generalMessageViewModel.listAction.clear();
        generalMessageViewModel.currentPage.value = 1;
        generalMessageViewModel.total.value = 1;
        await generalMessageViewModel.fetchGeneralMessage();
        generalMessageViewModel.setupScrollController();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        NavigationHelper.onBackScreen(widget: const GeneralMessageListView());
      },
      canPop: true,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20.0,
            vertical: 10.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            textDirection: Get.locale?.languageCode == "he" ? TextDirection.rtl : TextDirection.ltr,
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextHeadlineMedium(
                      text: StringConstants.technicalSupport,
                      color: AppColors.textPrimary,
                      letterSpacing: 0,
                    ),
                  ),
                ],
              ),
              const Gap(10),
              Obx(
                () => generalMessageViewModel.listMessage.isNotEmpty
                    ? Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Obx(
                                () => Checkbox(
                                  semanticLabel: "Select All",
                                  activeColor: AppColors.surfaceGreen,
                                  value: generalMessageViewModel.checkAll.value,
                                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                  visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
                                  onChanged: (value) {
                                    generalMessageViewModel.checkAll.toggle();
                                    if (generalMessageViewModel.checkAll.isTrue) {
                                      generalMessageViewModel.listAction.clear();
                                      for (var items in generalMessageViewModel.listMessage) {
                                        generalMessageViewModel.listAction.add(items.id ?? 0);
                                      }
                                    } else {
                                      generalMessageViewModel.listAction.clear();
                                    }
                                    generalMessageViewModel.listAction.refresh();
                                  },
                                ),
                              ),
                              const SizedBox(width: 5),
                              TextBodyMedium(
                                text: StringConstants.selectAll,
                                color: AppColors.textError,
                                letterSpacing: 0,
                              ),
                            ],
                          ),
                          if (generalMessageViewModel.checkAll.isTrue ||
                              generalMessageViewModel.listAction.isNotEmpty) ...[
                            CustomClick(
                              onTap: () {
                                generalMessageViewModel.deleteGeneralMessage(id: 0);
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const ImageIcon(
                                    AssetImage(Assets.iconsTrash),
                                    size: 20,
                                    color: AppColors.textError,
                                  ),
                                  const SizedBox(width: 5),
                                  TextBodyMedium(
                                    text: StringConstants.delete,
                                    color: AppColors.textError,
                                    letterSpacing: 0,
                                  ),
                                ],
                              ),
                            ),
                            if (generalMessageViewModel.checkAll.isTrue ||
                                generalMessageViewModel.listAction.isNotEmpty)
                              CustomClick(
                                onTap: () {
                                  generalMessageViewModel.markGeneralMessageRead(id: 0, status: false);
                                },
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const ImageIcon(
                                      AssetImage(Assets.iconsIcUnreadMail),
                                      size: 20,
                                      color: AppColors.textError,
                                    ),
                                    const SizedBox(width: 5),
                                    TextBodyMedium(
                                      text: StringConstants.markAsUnread,
                                      color: AppColors.textError,
                                      letterSpacing: 0,
                                    ),
                                  ],
                                ),
                              ),
                            if (generalMessageViewModel.checkAll.isTrue ||
                                generalMessageViewModel.listAction.isNotEmpty)
                              CustomClick(
                                onTap: () {
                                  generalMessageViewModel.markGeneralMessageRead(id: 0, status: true);
                                },
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const ImageIcon(
                                      AssetImage(Assets.iconsIcReadMail),
                                      size: 20,
                                      color: AppColors.textError,
                                    ),
                                    const SizedBox(width: 5),
                                    TextBodyMedium(
                                      text: StringConstants.markAsRead,
                                      color: AppColors.textError,
                                      letterSpacing: 0,
                                    ),
                                  ],
                                ),
                              ),
                          ]
                        ],
                      )
                    : const SizedBox(),
              ),
              // Obx(
              //   () => generalMessageViewModel.listMessage.isNotEmpty
              //       ? Row(
              //           children: [
              //             Obx(
              //               () => Checkbox(
              //                 semanticLabel: "Select All",
              //                 activeColor: AppColors.surfaceGreen,
              //                 value: generalMessageViewModel.checkAll.value,
              //                 onChanged: (value) {
              //                   generalMessageViewModel.checkAll.toggle();
              //                   if (generalMessageViewModel.checkAll.isTrue) {
              //                     generalMessageViewModel.listAction.clear();
              //                     for (var items in generalMessageViewModel.listMessage) {
              //                       generalMessageViewModel.listAction.add(items.id ?? 0);
              //                     }
              //                   } else {
              //                     generalMessageViewModel.listAction.clear();
              //                   }
              //                   generalMessageViewModel.listAction.refresh();
              //                 },
              //               ),
              //             ),
              //             TextBodyMedium(
              //               text: StringConstants.selectAll,
              //               color: AppColors.textError,
              //               letterSpacing: 0,
              //             ),
              //             const SizedBox(width: 5),
              //             Expanded(
              //               child: generalMessageViewModel.checkAll.isTrue ||
              //                       generalMessageViewModel.listAction.isNotEmpty
              //                   ? SingleChildScrollView(
              //                       scrollDirection: Axis.horizontal,
              //                       child: Row(
              //                         children: [
              //                           CustomClick(
              //                             onTap: () {
              //                               generalMessageViewModel.deleteGeneralMessage(id: 0);
              //                             },
              //                             child: Row(
              //                               children: [
              //                                 const ImageIcon(
              //                                   AssetImage(Assets.iconsTrash),
              //                                   size: 20,
              //                                   color: AppColors.textError,
              //                                 ),
              //                                 const SizedBox(width: 5),
              //                                 TextBodyMedium(
              //                                   text: StringConstants.delete,
              //                                   color: AppColors.textError,
              //                                   letterSpacing: 0,
              //                                 ),
              //                               ],
              //                             ),
              //                           ),
              //                           const SizedBox(width: 10),
              //                           CustomClick(
              //                             onTap: () {
              //                               generalMessageViewModel.markGeneralMessageRead(
              //                                   id: 0, status: false);
              //                             },
              //                             child: Row(
              //                               children: [
              //                                 const ImageIcon(
              //                                   AssetImage(Assets.iconsIcUnreadMail),
              //                                   size: 20,
              //                                   color: AppColors.textError,
              //                                 ),
              //                                 const SizedBox(width: 5),
              //                                 TextBodyMedium(
              //                                   text: StringConstants.markAsUnread,
              //                                   color: AppColors.textError,
              //                                   letterSpacing: 0,
              //                                 ),
              //                               ],
              //                             ),
              //                           ),
              //                           const SizedBox(width: 10),
              //                           CustomClick(
              //                             onTap: () {
              //                               generalMessageViewModel.markGeneralMessageRead(
              //                                   id: 0, status: true);
              //                             },
              //                             child: Row(
              //                               children: [
              //                                 const ImageIcon(
              //                                   AssetImage(Assets.iconsIcReadMail),
              //                                   size: 20,
              //                                   color: AppColors.textError,
              //                                 ),
              //                                 const SizedBox(width: 5),
              //                                 TextBodyMedium(
              //                                   text: StringConstants.markAsRead,
              //                                   color: AppColors.textError,
              //                                   letterSpacing: 0,
              //                                 ),
              //                               ],
              //                             ),
              //                           ),
              //                         ],
              //                       ),
              //                     )
              //                   : const SizedBox(),
              //             ),
              //           ],
              //         )
              //       : const SizedBox(),
              // ),
              const Gap(10),
              Expanded(
                child: Obx(
                  () => generalMessageViewModel.isLoading.value
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
                      : (generalMessageViewModel.listMessage.isNotEmpty)
                          ? RefreshIndicator(
                              onRefresh: () {
                                generalMessageViewModel.currentPage.value = 1;
                                generalMessageViewModel.listAction.clear();
                                return generalMessageViewModel.fetchGeneralMessage();
                              },
                              child: ListView.separated(
                                physics:
                                    const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                                controller: generalMessageViewModel.scrollController,
                                itemBuilder: (context, index) {
                                  general_message_model.Datum data =
                                      generalMessageViewModel.listMessage[index];
                                  return GeneralMessageItemWidget(
                                    data: data,
                                    index: index,
                                    messageType: "technical",
                                  );
                                },
                                separatorBuilder: (context, index) => const Gap(10),
                                itemCount: generalMessageViewModel.listMessage.length,
                              ),
                            )
                          : RefreshIndicator(
                              onRefresh: () {
                                generalMessageViewModel.currentPage.value = 1;
                                generalMessageViewModel.listAction.clear();
                                return generalMessageViewModel.fetchGeneralMessage();
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
                () => generalMessageViewModel.isLoadingMore.value
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
