import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:revalesuva/components/custom_button.dart';
import 'package:revalesuva/components/custom_click.dart';
import 'package:revalesuva/components/custom_text.dart';
import 'package:revalesuva/model/tools/intuitive_writing/intuitive_writing_model.dart'
    as intuitive_writing_model;
import 'package:revalesuva/utils/app_colors.dart';
import 'package:revalesuva/utils/helper_method.dart';
import 'package:revalesuva/utils/navigation_helper.dart';
import 'package:revalesuva/utils/strings_constant.dart';
import 'package:revalesuva/view_models/tools/intuitive_writing_view_model.dart';
import 'package:revalesuva/views/tools/intuitive_writing/intuitive_writing_detail_view.dart';
import 'package:revalesuva/views/tools/intuitive_writing/widget/intuitive_writing_item.dart';

class IntuitiveWritingListView extends StatefulWidget {
  const IntuitiveWritingListView({super.key});

  @override
  State<IntuitiveWritingListView> createState() => _IntuitiveWritingListViewState();
}

class _IntuitiveWritingListViewState extends State<IntuitiveWritingListView> {
  final IntuitiveWritingViewModel intuitiveWritingViewModel = Get.put(
    IntuitiveWritingViewModel(),
    permanent: true,
  );

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        intuitiveWritingViewModel.currentPage.value = 1;
        intuitiveWritingViewModel.fetchIntuitiveWriting();
        intuitiveWritingViewModel.setupScrollController();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        NavigationHelper.onBackScreen(widget: const IntuitiveWritingListView());
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
              CustomClick(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: TextBodySmall(
                  text: "< ${StringConstants.backTo} ${StringConstants.tools}",
                  color: AppColors.textPrimary,
                  letterSpacing: 0,
                ),
              ),
              SizedBox(
                height: 40,
                child: Row(
                  children: [
                    Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: TextHeadlineMedium(
                        text: StringConstants.intuitiveWriting,
                        color: AppColors.textPrimary,
                        letterSpacing: 0,
                      ),
                    ),
                    const Spacer(),
                    SimpleButton(
                      text: StringConstants.editData,
                      onPressed: () {
                        intuitiveWritingViewModel.txtWriting.text = "";
                        NavigationHelper.pushScreenWithNavBar(
                          widget: IntuitiveWritingDetailView(
                            id: 0,
                          ),
                          context: context,
                        );
                      },
                    )
                  ],
                ),
              ),
              const Gap(10),
              Expanded(
                child: Obx(
                  () => intuitiveWritingViewModel.isLoading.value
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
                      : (intuitiveWritingViewModel.listWrite.isNotEmpty)
                          ? RefreshIndicator(
                              onRefresh: () {
                                intuitiveWritingViewModel.currentPage.value = 1;
                                return intuitiveWritingViewModel.fetchIntuitiveWriting();
                              },
                              child: ListView.separated(
                                physics:
                                    const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                                controller: intuitiveWritingViewModel.scrollController,
                                itemBuilder: (context, index) {
                                  intuitive_writing_model.Datum data =
                                      intuitiveWritingViewModel.listWrite[index];
                                  return IntuitiveWritingItem(
                                    data: data,
                                    index: index,
                                  );
                                },
                                separatorBuilder: (context, index) => const Gap(20),
                                itemCount: intuitiveWritingViewModel.listWrite.length,
                              ),
                            )
                          : RefreshIndicator(
                              onRefresh: () {
                                intuitiveWritingViewModel.currentPage.value = 1;
                                return intuitiveWritingViewModel.fetchIntuitiveWriting();
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
                () => intuitiveWritingViewModel.isLoadingMore.value
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
