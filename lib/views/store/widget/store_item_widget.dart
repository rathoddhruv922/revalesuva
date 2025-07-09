import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:revalesuva/components/custom_Image_viewer.dart';
import 'package:revalesuva/components/custom_click.dart';
import 'package:revalesuva/components/custom_text.dart';
import 'package:revalesuva/generated/assets.dart';
import 'package:revalesuva/model/store/store_model.dart' as store_model;
import 'package:revalesuva/utils/app_colors.dart';
import 'package:revalesuva/utils/app_corner.dart';
import 'package:revalesuva/utils/extension.dart';
import 'package:revalesuva/utils/navigation_helper.dart';
import 'package:revalesuva/views/store/store_product_detail_view.dart';

class StoreItemWidget extends StatelessWidget {
  const StoreItemWidget({
    super.key,
    required this.data,
    this.isFavourite,
    this.onFavourite,
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
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          color: AppColors.surfaceTertiary,
          borderRadius: BorderRadius.circular(AppCorner.listTile),
        ),
        child: Stack(
          alignment: AlignmentDirectional.topCenter,
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
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
                  const Gap(5),
                  SizedBox(
                    height: 70,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              TextHeadlineMedium(
                                text: data.productName?.toCapitalized() ?? "",
                                maxLine: 2,
                              ),
                              TextHeadlineMedium(
                                text: "${data.price ?? " "} ₪",
                                weight: 10,
                                maxLine: 2,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 3.0),
                          child: CustomClick(
                            onTap: onFavourite,
                            child: Image.asset(
                              width: 18,
                              ((data.favourite ?? false) || (isFavourite ?? false))
                                  ? Assets.iconsIcLike
                                  : Assets.iconsIcLikeBlank,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
