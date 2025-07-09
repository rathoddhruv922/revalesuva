import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:revalesuva/components/custom_Image_viewer.dart';
import 'package:revalesuva/components/custom_text.dart';
import 'package:revalesuva/generated/assets.dart';
import 'package:revalesuva/model/order/order_model.dart' as order_model;
import 'package:revalesuva/utils/app_colors.dart';
import 'package:revalesuva/utils/app_corner.dart';
import 'package:revalesuva/utils/strings_constant.dart';

class OrderDetailProductItemWidget extends StatelessWidget {
  const OrderDetailProductItemWidget({super.key, required this.data});

  final order_model.OrderDetail data;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppCorner.listTile),
        border: Border.all(
          color: AppColors.borderLightGray,
        ),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 60,
            height: 60,
            child: ClipRRect(
              clipBehavior: Clip.hardEdge,
              borderRadius: BorderRadius.circular(
                AppCorner.listTileImage,
              ),
              child: CustomImageViewer(
                imageUrl: data.product?.image ?? "",
                errorImage: Image.asset(
                  Assets.imagesPlaceholderImg,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          const Gap(10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextHeadlineMedium(
                  text: data.product?.productName ?? "",
                  maxLine: 1,
                ),
                const Gap(5),
                TextHeadlineSmall(
                  text: "${data.product?.price ?? " "} ₪",
                  weight: 10,
                  size: 2,
                  maxLine: 1,
                ),
              ],
            ),
          ),
          TextBodySmall(
            text: "${StringConstants.items} ${data.quantity ?? ""}",
            color: AppColors.textPrimary,
          ),
        ],
      ),
    );
  }
}
