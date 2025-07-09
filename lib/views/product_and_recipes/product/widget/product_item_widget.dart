import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:revalesuva/components/custom_Image_viewer.dart';
import 'package:revalesuva/components/custom_button.dart';
import 'package:revalesuva/components/custom_click.dart';
import 'package:revalesuva/components/custom_dialog.dart';
import 'package:revalesuva/components/custom_text.dart';
import 'package:revalesuva/generated/assets.dart';
import 'package:revalesuva/model/product_and_recipes/product_model.dart' as product_model;
import 'package:revalesuva/model/product_and_recipes/shopping_model.dart';
import 'package:revalesuva/utils/app_colors.dart';
import 'package:revalesuva/utils/app_corner.dart';
import 'package:revalesuva/utils/enums.dart';
import 'package:revalesuva/utils/helper_method.dart';
import 'package:revalesuva/utils/local_shopping_helper.dart';
import 'package:revalesuva/utils/strings_constant.dart';
import 'package:revalesuva/view_models/home/home_view_model.dart';
import 'package:revalesuva/views/product_and_recipes/product/widget/recommended_widget.dart';

class ProductItemWidget extends StatefulWidget {
  const ProductItemWidget({
    super.key,
    required this.data,
  });

  final product_model.Datum data;

  @override
  State<ProductItemWidget> createState() => _ProductItemWidgetState();
}

class _ProductItemWidgetState extends State<ProductItemWidget> {
  int qty = 0;
  int id = -1;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        var shoppingList = Get.find<HomeViewModel>().getShoppingListItemCount();

        id = shoppingList.indexWhere(
          (element) => element.id == "p${widget.data.id}",
        );
        if (id >= 0) {
          qty = shoppingList[id].qty ?? 0;
        }

        setState(() {});
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomClick(
      onTap: () {
        CustomDialog.imageDialog(
          url: widget.data.image ?? "",
        );
      },
      child: Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          color: AppColors.surfaceTertiary,
          borderRadius: BorderRadius.circular(AppCorner.listTile),
        ),
        child: Stack(
          alignment: AlignmentDirectional.center,
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
                        imageUrl: widget.data.image,
                        errorImage: Image.asset(
                          Assets.imagesPlaceholderImg,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  const Gap(5),
                  TextHeadlineSmall(text: widget.data.name ?? ""),
                  const Gap(5),
                  Row(
                    children: [
                      CustomClick(
                        onTap: () {
                          if (qty < 100) {
                            qty++;
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
                          if (qty > 0) {
                            qty--;
                            setState(() {});
                          }
                        },
                        child: const ImageIcon(
                          AssetImage(Assets.iconsIcMinus),
                          size: 20,
                        ),
                      ),
                      const Gap(10),
                      Expanded(
                        child: SimpleButton(
                          text: id == -1 ? StringConstants.add : StringConstants.update,
                          onPressed: () async {
                            if (qty != 0) {
                              if (id == -1) {
                                await LocalShoppingHelper.instance.addProduct(
                                  ShoppingModel(
                                    id: "p${widget.data.id}",
                                    image: widget.data.image,
                                    name: widget.data.name,
                                    qty: qty,
                                  ),
                                  ShopType.product,
                                );
                                showToast(msg: "added in Shopping list");
                              } else {
                                LocalShoppingHelper.instance.updateQty(id, qty);
                                showToast(msg: "Updated Quantity Successfully");
                              }
                              var shoppingList = Get.find<HomeViewModel>().getShoppingListItemCount();
                              id = shoppingList.indexWhere(
                                (element) => element.id == "p${widget.data.id}",
                              );
                              if (id >= 0) {
                                qty = shoppingList[id].qty ?? 0;
                              }
                              Get.find<HomeViewModel>().getShoppingListItemCount();
                              setState(() {});
                            } else {
                              showToast(msg: "quantity is 0");
                            }
                          },
                          height: 35,
                          backgroundColor: id == -1 ? AppColors.surfaceBrand : AppColors.surfaceTertiary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            widget.data.recommended == 0 ? const SizedBox() : const RecommendedWidget(),
          ],
        ),
      ),
    );
  }
}
