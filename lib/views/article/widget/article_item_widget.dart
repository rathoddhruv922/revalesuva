import 'package:flutter/material.dart';
import 'package:revalesuva/components/custom_click.dart';
import 'package:revalesuva/components/custom_text.dart';
import 'package:revalesuva/model/article/article_model.dart' as article_model;
import 'package:revalesuva/utils/app_colors.dart';
import 'package:revalesuva/utils/app_corner.dart';
import 'package:revalesuva/utils/navigation_helper.dart';
import 'package:revalesuva/utils/strings_constant.dart';
import 'package:revalesuva/views/article/article_detail_view.dart';

class ArticleItemWidget extends StatelessWidget {
  const ArticleItemWidget({super.key, required this.data, required this.index, required this.onTap});

  final article_model.Datum data;
  final Function() onTap;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      clipBehavior: Clip.hardEdge,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColors.surfaceTertiary,
        borderRadius: BorderRadius.circular(AppCorner.listTile),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: TextTitleMedium(
                text: data.title ?? "",
                maxLine: 1,
              ),
            ),
          ),
          CustomClick(
            onTap: onTap,
            child: SizedBox(
              height: double.infinity,
              child: ColoredBox(
                color: AppColors.surfaceBrand,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Align(
                    alignment: Alignment.center,
                    child: TextBodySmall(
                      text: "${StringConstants.toRead} >",
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
