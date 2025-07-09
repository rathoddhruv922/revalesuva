import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:revalesuva/components/custom_click.dart';
import 'package:revalesuva/components/custom_text.dart';
import 'package:revalesuva/utils/app_colors.dart';
import 'package:revalesuva/utils/app_corner.dart';
import 'package:revalesuva/utils/helper_method.dart';
import 'package:revalesuva/utils/strings_constant.dart';
import 'package:revalesuva/view_models/podcast/podcast_view_model.dart';
import 'package:revalesuva/views/podcasts/podcast_list_view.dart';

import '../../../utils/navigation_helper.dart';

class PodcastHostListView extends StatefulWidget {
  const PodcastHostListView({super.key});

  @override
  State<PodcastHostListView> createState() => _PodcastHostListViewState();
}

class _PodcastHostListViewState extends State<PodcastHostListView> {
  final PodcastViewModel podcastViewModel = Get.put(PodcastViewModel());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        podcastViewModel.currentPageHost.value = 1;
        podcastViewModel.listHost.clear();
        podcastViewModel.fetchHost();
        podcastViewModel.setupScrollControllerHost();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        NavigationHelper.onBackScreen(widget: const PodcastHostListView());
      },
      canPop: true,
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Gap(20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: TextHeadlineMedium(
                text: StringConstants.podcasts,
                color: AppColors.textPrimary,
                letterSpacing: 0,
              ),
            ),
            Expanded(
              child: RefreshIndicator(
                  onRefresh: () async {
                    podcastViewModel.currentPageHost.value = 1;
                    podcastViewModel.listHost.clear();
                    await podcastViewModel.fetchHost();
                  },
                  child: Obx(
                    () => ListView(
                      controller: podcastViewModel.scrollControllerHost,
                      physics: const BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics(),
                      ),
                      children: [
                        const Gap(10),
                        podcastViewModel.isLoadingHost.isTrue
                            ? ListView.separated(
                                padding: const EdgeInsets.symmetric(horizontal: 20),
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: 10,
                                itemBuilder: (context, index) {
                                  return const CustomShimmer(
                                    height: 50,
                                    radius: AppCorner.listTile,
                                  );
                                },
                                separatorBuilder: (context, index) => const Gap(10),
                              )
                            : podcastViewModel.listHost.isNotEmpty
                                ? ListView.separated(
                                    padding: const EdgeInsets.symmetric(horizontal: 20),
                                    physics: const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: podcastViewModel.listHost.length,
                                    itemBuilder: (context, index) {
                                      var data = podcastViewModel.listHost[index];
                                      return CustomClick(
                                        onTap: () {
                                          NavigationHelper.pushScreenWithNavBar(
                                            widget: PodcastListView(
                                              hostId: data.id.toString() ?? "",
                                            ),
                                            context: context,
                                          );
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                            color: AppColors.surfaceTertiary,
                                            borderRadius: BorderRadius.circular(
                                              AppCorner.listTile,
                                            ),
                                          ),
                                          child: TextHeadlineMedium(
                                            text: data.name ?? "",
                                          ),
                                        ),
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
                          () => podcastViewModel.isLoadingMore.isTrue
                              ? const CupertinoActivityIndicator(
                                  radius: 15,
                                )
                              : const SizedBox(),
                        ),
                        const Gap(10),
                      ],
                    ),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
