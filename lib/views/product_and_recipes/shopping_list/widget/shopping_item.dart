import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:revalesuva/components/custom_Image_viewer.dart';
import 'package:revalesuva/components/custom_click.dart';
import 'package:revalesuva/components/custom_text.dart';
import 'package:revalesuva/generated/assets.dart';
import 'package:revalesuva/model/product_and_recipes/shopping_model.dart';
import 'package:revalesuva/utils/app_colors.dart';
import 'package:revalesuva/utils/app_corner.dart';
import 'package:revalesuva/utils/helper_method.dart';
import 'package:revalesuva/utils/local_shopping_helper.dart';

class ShoppingItem extends StatefulWidget {
  const ShoppingItem({
    super.key,
    required this.data,
    required this.deleteItem,
    required this.id,
    required this.onChange,
  });

  final ShoppingModel data;
  final Function() deleteItem;
  final Function(bool? value) onChange;
  final int id;

  @override
  State<ShoppingItem> createState() => _ShoppingItemState();
}

class _ShoppingItemState extends State<ShoppingItem> {
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
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.surfaceTertiary,
        border: Border.all(color: AppColors.lightGray),
        borderRadius: BorderRadius.circular(AppCorner.listTile),
      ),
      child: Row(
        children: [
          Checkbox(
              activeColor: AppColors.surfaceGreen,
              value: widget.data.isSelected ?? false,
              onChanged: widget.onChange),
          const Gap(10),
          SizedBox(
            width: 50,
            height: 50,
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
          const Gap(20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextHeadlineMedium(text: widget.data.name ?? ""),
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
                    LocalShoppingHelper.instance.updateQty(widget.id, qty);
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
                    LocalShoppingHelper.instance.updateQty(widget.id, qty);
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
    );
  }
}
