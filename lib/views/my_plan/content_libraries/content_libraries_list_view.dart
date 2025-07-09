import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:revalesuva/components/custom_click.dart';
import 'package:revalesuva/components/custom_text.dart';
import 'package:revalesuva/components/custom_text_field.dart';
import 'package:revalesuva/generated/assets.dart';
import 'package:revalesuva/model/my_plan/plans/user_plan_model.dart' as user_plan_model;
import 'package:revalesuva/utils/app_colors.dart';
import 'package:revalesuva/utils/app_corner.dart';
import 'package:revalesuva/utils/extension.dart';
import 'package:revalesuva/utils/helper_method.dart';
import 'package:revalesuva/utils/navigation_helper.dart';
import 'package:revalesuva/utils/strings_constant.dart';
import 'package:revalesuva/view_models/my_plan/content_libraries_view_model.dart';
import 'package:revalesuva/views/my_plan/content_libraries/widget/content_item_widget.dart';

class ContentLibrariesListView extends StatefulWidget {
  const ContentLibrariesListView({
    super.key,
    required this.data,
  });

  final user_plan_model.Datum data;

  @override
  State<ContentLibrariesListView> createState() => _ContentLibrariesListViewState();
}

class _ContentLibrariesListViewState extends State<ContentLibrariesListView> {
  final ContentLibrariesViewModel contentLibrariesViewModel = Get.put(ContentLibrariesViewModel());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        contentLibrariesViewModel.planId.value = "${widget.data.planId ?? ""}";
        contentLibrariesViewModel.currentPage.value = 1;
        contentLibrariesViewModel.txtSearch.text = "";
        contentLibrariesViewModel.listContent.clear();
        contentLibrariesViewModel.fetchContentLibraries();
        contentLibrariesViewModel.setupScrollController();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        NavigationHelper.onBackScreen(
            widget: ContentLibrariesListView(
          data: widget.data,
        ));
      },
      canPop: true,
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Gap(20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomClick(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: TextBodySmall(
                      text: "< ${StringConstants.backTo} ${widget.data.plan?.name?.toCapitalized()}",
                      color: AppColors.textPrimary,
                      letterSpacing: 0,
                    ),
                  ),
                  const Gap(10),
                  TextHeadlineMedium(
                    text: StringConstants.recipes,
                    color: AppColors.textPrimary,
                    letterSpacing: 0,
                  ),
                  const Gap(10),
                ],
              ),
            ),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  contentLibrariesViewModel.currentPage.value = 1;
                  contentLibrariesViewModel.txtSearch.text = "";
                  contentLibrariesViewModel.listContent.clear();
                  await contentLibrariesViewModel.fetchContentLibraries();
                },
                child: Obx(
                  () => ListView(
                    controller: contentLibrariesViewModel.scrollController,
                    physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics(),
                    ),
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20.0,
                        ),
                        child: CustomTextField(
                          controller: contentLibrariesViewModel.txtSearch,
                          hint: StringConstants.searchByFreeText,
                          suffixIcon: const Padding(
                            padding: EdgeInsetsDirectional.only(end: 15.0),
                            child: ImageIcon(
                              AssetImage(Assets.iconsIcSearch),
                              color: AppColors.iconPrimary,
                            ),
                          ),
                        ),
                      ),
                      const Gap(15),
                      contentLibrariesViewModel.isLoading.isTrue
                          ? ListView.separated(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: 10,
                              itemBuilder: (context, index) {
                                return const CustomShimmer(
                                  height: 80,
                                  radius: AppCorner.listTile,
                                );
                              },
                              separatorBuilder: (context, index) => const Gap(10),
                            )
                          : contentLibrariesViewModel.listContent.isNotEmpty
                              ? ListView.separated(
                                  padding: const EdgeInsets.symmetric(horizontal: 20),
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: contentLibrariesViewModel.listContent.length,
                                  itemBuilder: (context, index) {
                                    return ContentItemWidget(
                                      data: contentLibrariesViewModel.listContent[index],
                                    );
                                  },
                                  separatorBuilder: (context, index) => const Gap(10),
                                )
                              : Container(
                                  alignment: Alignment.center,
                                  height: 30.h,
                                  child: TextHeadlineMedium(
                                    text: StringConstants.noDataFound,
                                  ),
                                ),
                      const Gap(15),
                      Obx(
                        () => contentLibrariesViewModel.isLoadingMore.isTrue
                            ? const CupertinoActivityIndicator(
                                radius: 15,
                              )
                            : const SizedBox(),
                      ),
                      const Gap(10),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
