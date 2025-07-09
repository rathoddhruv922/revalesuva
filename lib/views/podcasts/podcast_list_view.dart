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
import 'package:revalesuva/views/podcasts/widget/podcast_item_widget.dart';

import '../../../utils/navigation_helper.dart';

class PodcastListView extends StatefulWidget {
  const PodcastListView({super.key, required this.hostId});

  final String hostId;

  @override
  State<PodcastListView> createState() => _PodcastListViewState();
}

class _PodcastListViewState extends State<PodcastListView> {
  final PodcastViewModel podcastViewModel = Get.find<PodcastViewModel>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        podcastViewModel.currentPage.value = 1;
        podcastViewModel.listPodcast.clear();
        podcastViewModel.getPodcastByHost(hostId: widget.hostId);
        podcastViewModel.setupScrollController(hostId: widget.hostId);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        NavigationHelper.onBackScreen(
          widget: PodcastListView(
            hostId: widget.hostId,
          ),
        );
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
                      text: "< ${StringConstants.backTo} ${StringConstants.hadasStrengthening}",
                      color: AppColors.textPrimary,
                      letterSpacing: 0,
                    ),
                  ),
                  const Gap(10),
                  TextHeadlineMedium(
                    text: StringConstants.weeklyTorahPortion,
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
                    podcastViewModel.currentPage.value = 1;
                    podcastViewModel.listPodcast.clear();
                    await podcastViewModel.getPodcastByHost(hostId: widget.hostId);
                  },
                  child: Obx(
                    () => ListView(
                      controller: podcastViewModel.scrollController,
                      physics: const BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics(),
                      ),
                      children: [
                        const Gap(10),
                        podcastViewModel.isLoading.isTrue
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
                            : podcastViewModel.listPodcast.isNotEmpty
                                ? ListView.separated(
                                    padding: const EdgeInsets.symmetric(horizontal: 20),
                                    physics: const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: podcastViewModel.listPodcast.length,
                                    itemBuilder: (context, index) {
                                      return PodcastItemWidget(
                                        index: index,
                                        data: podcastViewModel.listPodcast[index],
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
