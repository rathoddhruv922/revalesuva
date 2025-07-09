import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:revalesuva/components/custom_Image_viewer.dart';
import 'package:revalesuva/components/custom_click.dart';
import 'package:revalesuva/components/custom_text.dart';
import 'package:revalesuva/generated/assets.dart';
import 'package:revalesuva/model/store/store_model.dart' as store_model;
import 'package:revalesuva/utils/app_colors.dart';
import 'package:revalesuva/utils/app_corner.dart';
import 'package:revalesuva/utils/navigation_helper.dart';
import 'package:revalesuva/views/store/store_product_detail_view.dart';

class StoreFavoritesItemWidget extends StatelessWidget {
  const StoreFavoritesItemWidget({
    super.key,
    required this.data,
    this.isFavourite,
    required this.onFavourite,
  });

  final store_model.Datum data;
  final bool? isFavourite;
  final Function()? onFavourite;

  @override
  Widget build(BuildContext context) {
    return CustomClick(
      onTap: () {
        NavigationHelper.pushScreenWithNavBar(
          widget: StoreProductDetailView(
            data: data,
            isFavourite: isFavourite,
          ),
          context: context,
        );
      },
      child: Container(
        height: 80,
        clipBehavior: Clip.hardEdge,
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: AppColors.surfaceTertiary,
          borderRadius: BorderRadius.circular(AppCorner.listTile),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            AspectRatio(
              aspectRatio: 11 / 10,
              child: ClipRRect(
                clipBehavior: Clip.hardEdge,
                borderRadius: BorderRadius.circular(
                  AppCorner.listTileImage,
                ),
                child: CustomImageViewer(
                  imageUrl: data.image,
                  errorImage: Image.asset(
                    Assets.imagesPlaceholderImg,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const Gap(20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextTitleLarge(
                    text: data.productName ?? "",
                    maxLine: 1,
                  ),
                  const Gap(5),
                  TextTitleSmall(
                    text: data.storeCategory?.name ?? "",
                    maxLine: 1,
                  ),
                  const Gap(5),
                  TextBodySmall(
                    text: "${data.price ?? " "} ₪",
                    color: AppColors.textPrimary,
                  ),
                ],
              ),
            ),
            const Gap(10),
            CustomClick(
              onTap: onFavourite,
              child: Image.asset(
                width: 20,
                ((data.favourite ?? false) || (isFavourite ?? false))
                    ? Assets.iconsIcLike
                    : Assets.iconsIcLikeBlank,
              ),
            ),
            const Gap(10),
          ],
        ),
      ),
    );
  }
}
