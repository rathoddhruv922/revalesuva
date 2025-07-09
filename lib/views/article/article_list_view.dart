import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:revalesuva/components/custom_text.dart';
import 'package:revalesuva/utils/app_colors.dart';
import 'package:revalesuva/utils/helper_method.dart';
import 'package:revalesuva/utils/navigation_helper.dart';
import 'package:revalesuva/utils/strings_constant.dart';
import 'package:revalesuva/view_models/article/article_view_model.dart';
import 'package:revalesuva/views/article/article_detail_view.dart';
import 'package:revalesuva/views/article/widget/article_item_widget.dart';

class ArticleListView extends StatefulWidget {
  const ArticleListView({super.key});

  @override
  State<ArticleListView> createState() => _ArticleListViewState();
}

class _ArticleListViewState extends State<ArticleListView> {
  final ArticleViewModel articleViewModel = Get.put(ArticleViewModel());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        articleViewModel.fetchArticle();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        NavigationHelper.onBackScreen(widget: const ArticleListView());
      },
      canPop: true,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Gap(10),
              // InkWell(
              //   onTap: () {
              //     Navigator.of(context).pop();
              //   },
              //   child: TextBodySmall(
              //     text: "< ${StringConstants.backTo} ${StringConstants.articles}",
              //     color: AppColors.textPrimary,
              //     letterSpacing: 0,
              //   ),
              // ),
              // const Gap(10),
              TextHeadlineMedium(
                text: StringConstants.articles,
                color: AppColors.textPrimary,
                letterSpacing: 0,
              ),
              const Gap(20),
              Expanded(
                child: Obx(
                  () => articleViewModel.isLoading.value
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomShimmer(
                              height: 40,
                              width: 100.w,
                              radius: 15,
                            ),
                          ],
                        )
                      : (articleViewModel.listArticle.isNotEmpty)
                          ? RefreshIndicator(
                              onRefresh: () {
                                return articleViewModel.fetchArticle();
                              },
                              child: ListView.separated(
                                physics:
                                    const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                                itemBuilder: (BuildContext context, int index) {
                                  return ArticleItemWidget(
                                    index: index,
                                    data: articleViewModel.listArticle[index],
                                    onTap: () {
                                      NavigationHelper.pushScreenWithNavBar(
                                        widget: ArticleDetailView(
                                          data: articleViewModel.listArticle[index],
                                        ),
                                        context: context,
                                      );
                                    },
                                  );
                                },
                                separatorBuilder: (context, index) => const Gap(10),
                                itemCount: articleViewModel.listArticle.length,
                              ),
                            )
                          : RefreshIndicator(
                              onRefresh: () {
                                return articleViewModel.fetchArticle();
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
