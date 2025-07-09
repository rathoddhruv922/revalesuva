import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:revalesuva/components/custom_click.dart';
import 'package:revalesuva/components/custom_text.dart';
import 'package:revalesuva/model/article/article_model.dart' as article_model;
import 'package:revalesuva/utils/app_colors.dart';
import 'package:revalesuva/utils/helper_method.dart';
import 'package:revalesuva/utils/navigation_helper.dart';
import 'package:revalesuva/utils/strings_constant.dart';
import 'package:revalesuva/view_models/article/article_view_model.dart';

import 'widget/article_item_widget.dart';

class ArticleDetailView extends StatelessWidget {
  ArticleDetailView({super.key, required this.data});

  final article_model.Datum data;
  final ArticleViewModel articleViewModel = Get.find<ArticleViewModel>();

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        NavigationHelper.onBackScreen(
            widget: ArticleDetailView(
          data: data,
        ));
      },
      canPop: true,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Gap(10),
              CustomClick(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: TextBodySmall(
                  text: "< ${StringConstants.backTo} ${StringConstants.articles}",
                  color: AppColors.textPrimary,
                  letterSpacing: 0,
                ),
              ),
              Expanded(
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  children: [
                    const Gap(10),
                    TextHeadlineLarge(
                      text: data.title ?? "",
                      color: AppColors.textPrimary,
                      letterSpacing: 0,
                    ),
                    const Gap(10),
                    CustomCard2(
                      color: AppColors.surfaceTertiary,
                      child: customHtmlWidget(
                        data.description ?? "",
                      ),
                    ),
                    const Gap(20),
                    TextHeadlineMedium(
                      text: StringConstants.youMayAlsoBeInterested,
                      color: AppColors.textPrimary,
                      letterSpacing: 0,
                    ),
                    const Gap(10),
                    ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        return ArticleItemWidget(
                          index: index,
                          data: articleViewModel.getInnerList(articleId: data.id ?? 0)[index],
                          onTap: () {
                            NavigationHelper.onBackScreen(
                                widget: ArticleDetailView(
                                  data: data,
                                ));
                            NavigationHelper.pushReplaceScreenWithNavBar(
                              widget: ArticleDetailView(
                                data: articleViewModel.getInnerList(
                                    articleId: data.id ?? 0)[index],
                                key: GlobalKey(),
                              ),
                              context: context,
                            );
                            //showToast(msg: articleViewModel.getInnerList(articleId: data.id ?? 0)[index].toString());
                          },
                        );
                      },
                      separatorBuilder: (context, index) => const Gap(10),
                      itemCount: articleViewModel.getInnerList(articleId: data.id ?? 0).length > 2
                          ? 2
                          : articleViewModel.getInnerList(articleId: data.id ?? 0).length,
                    ),
                    const Gap(20),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
