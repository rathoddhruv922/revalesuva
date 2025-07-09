import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:revalesuva/components/custom_click.dart';
import 'package:revalesuva/components/custom_text.dart';
import 'package:revalesuva/generated/assets.dart';
import 'package:revalesuva/model/product_and_recipes/recipe_model.dart' as recipe_model;
import 'package:revalesuva/model/product_and_recipes/shopping_model.dart';
import 'package:revalesuva/utils/app_colors.dart';
import 'package:revalesuva/utils/enums.dart';
import 'package:revalesuva/utils/local_shopping_helper.dart';
import 'package:revalesuva/view_models/home/home_view_model.dart';

class IngredientsItem extends StatefulWidget {
  const IngredientsItem({
    super.key,
    required this.data,
  });

  final recipe_model.Ingredient data;

  @override
  State<IngredientsItem> createState() => _IngredientsItemState();
}

class _IngredientsItemState extends State<IngredientsItem> {
  int id = -1;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        var shoppingList = Get.find<HomeViewModel>().getShoppingListItemCount();
        id = shoppingList.indexWhere(
          (element) => element.id == "i${widget.data.id}",
        );
        if (kDebugMode) {
          print(id);
        }
        setState(() {});
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomClick(
          onTap: () async {
            if (id == -1) {
              await LocalShoppingHelper.instance.addProduct(
                ShoppingModel(
                  id: "i${widget.data.id}",
                  image: "",
                  name: widget.data.ingredientName,
                  qty: 1,
                ),
                ShopType.ingredients,
              );
            } else {
              await LocalShoppingHelper.instance.removeProduct(
                id,
                ShoppingModel(
                  id: "i${widget.data.id}",
                  image: "",
                  name: widget.data.ingredientName,
                  qty: 1,
                ),
              );
            }
            var shoppingList = Get.find<HomeViewModel>().getShoppingListItemCount();
            id = shoppingList.indexWhere(
              (element) => element.id == "i${widget.data.id}",
            );
            setState(() {});
          },
          child: id == -1
              ? Container(
                  width: 20,
                  height: 20,
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: AppColors.iconSecondary,
                      width: 1,
                    ),
                  ),
                )
              : Image.asset(
                  Assets.iconsIcCheckBox,
                  width: 20,
                ),
        ),
        const Gap(10),
        Expanded(
          child: TextBodyMedium(
            text: widget.data.ingredientName ?? "",
            color: AppColors.textPrimary,
          ),
        )
      ],
    );
  }
}
