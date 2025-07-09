import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:revalesuva/components/custom_Image_viewer.dart';
import 'package:revalesuva/components/custom_click.dart';
import 'package:revalesuva/components/custom_text.dart';
import 'package:revalesuva/generated/assets.dart';
import 'package:revalesuva/model/store/store_model.dart' as store_model;
import 'package:revalesuva/utils/app_colors.dart';
import 'package:revalesuva/utils/app_corner.dart';
import 'package:revalesuva/utils/helper_method.dart';
import 'package:revalesuva/utils/local_cart_helper.dart';
import 'package:revalesuva/utils/local_shopping_helper.dart';
import 'package:revalesuva/utils/navigation_helper.dart';
import 'package:revalesuva/view_models/home/home_view_model.dart';
import 'package:revalesuva/views/store/store_product_detail_view.dart';

class CartItemWidget extends StatefulWidget {
  const CartItemWidget({
    super.key,
    required this.data,
    required this.deleteItem,
    required this.id,
  });

  final store_model.Datum data;
  final Function() deleteItem;
  final int id;

  @override
  State<CartItemWidget> createState() => _CartItemWidgetState();
}

class _CartItemWidgetState extends State<CartItemWidget> {
  int qty = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        qty = widget.data.qty ?? 1;
        setState(() {});
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomClick(
      onTap: () {
        NavigationHelper.pushScreenWithNavBar(
          widget: StoreProductDetailView(
            data: widget.data,
          ),
          context: context,
        );
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AppColors.surfaceTertiary,
          border: Border.all(color: AppColors.lightGray),
          borderRadius: BorderRadius.circular(AppCorner.listTile),
        ),
        child: Row(
          children: [
            // Checkbox(
            //   activeColor: AppColors.surfaceGreen,
            //   value: false,
            //   onChanged: (value) {},
            // ),
            SizedBox(
              width: 70,
              height: 70,
              child: ClipRRect(
                clipBehavior: Clip.hardEdge,
                borderRadius: BorderRadius.circular(
                  AppCorner.listTileImage,
                ),
                child: CustomImageViewer(
                  imageUrl: widget.data.image,
                  errorImage: Image.asset(
                    Assets.imagesPlaceholderImg,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const Gap(15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextHeadlineMedium(
                    text: widget.data.productName ?? "",
                    maxLine: 1,
                  ),
                  TextHeadlineSmall(
                    text: "${widget.data.price ?? " "} ₪",
                    weight: 10,
                    size: 2,
                    maxLine: 1,
                  ),
                  CustomClick(
                    onTap: widget.deleteItem,
                    child: const TextBodySmall(
                      text: "מחיקת פריט",
                      color: AppColors.textError,
                      decoration: TextDecoration.underline,
                    ),
                  )
                ],
              ),
            ),
            Row(
              children: [
                CustomClick(
                  onTap: () {
                    if (qty < 100) {
                      qty++;
                      LocalCartHelper.instance.updateQty(widget.id, qty);
                      Get.find<HomeViewModel>().getCartListItemCount();
                      showToast(msg: "Updated Quantity Successfully");
                      setState(() {});
                    }
                  },
                  child: const ImageIcon(
                    AssetImage(Assets.iconsIcPlus),
                    size: 20,
                  ),
                ),
                const Gap(5),
                TextHeadlineMedium(
                  text: "$qty",
                  size: -1,
                ),
                const Gap(5),
                CustomClick(
                  onTap: () {
                    if (qty > 1) {
                      qty--;
                      LocalCartHelper.instance.updateQty(widget.id, qty);
                      Get.find<HomeViewModel>().getCartListItemCount();
                      showToast(msg: "Updated Quantity Successfully");
                      setState(() {});
                    }
                  },
                  child: const ImageIcon(
                    AssetImage(Assets.iconsIcMinus),
                    size: 20,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
