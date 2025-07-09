import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:revalesuva/components/custom_click.dart';
import 'package:revalesuva/components/custom_dialog.dart';
import 'package:revalesuva/components/custom_text.dart';
import 'package:revalesuva/generated/assets.dart';
import 'package:revalesuva/model/product_and_recipes/shopping_model.dart';
import 'package:revalesuva/utils/app_colors.dart';
import 'package:revalesuva/utils/helper_method.dart';
import 'package:revalesuva/utils/local_shopping_helper.dart';
import 'package:revalesuva/utils/strings_constant.dart';
import 'package:revalesuva/view_models/home/home_view_model.dart';
import 'package:revalesuva/views/product_and_recipes/shopping_list/widget/shopping_item.dart';

class ShoppingListWidget extends StatefulWidget {
  const ShoppingListWidget({super.key});

  @override
  State<ShoppingListWidget> createState() => _ShoppingListWidgetState();
}

class _ShoppingListWidgetState extends State<ShoppingListWidget> {
  List<ShoppingModel> shoppingList = [];
  bool isDelete = false;
  bool isSelectAll = false;
  String shareString = "";

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        setState(() {
          shoppingList = Get.find<HomeViewModel>().getShoppingListItemCount();
          for (var item in shoppingList) {
            item.isSelected = false;
          }

        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Gap(20),
          Row(
            children: [
              Expanded(
                child: TextHeadlineMedium(text: StringConstants.myShoppingList),
              ),
              CustomClick(
                onTap: () {
                  if(shoppingList.isNotEmpty){
                    shareString = "${StringConstants.myShoppingList} \n \n";
                    shareString += shoppingList.map((item) => "${item.name} :- ${item.qty}").join('\n');
                    shareContent(
                      title: StringConstants.myShoppingList,
                      message: shareString,
                    );
                  }else{
                    showToast(msg: StringConstants.shoppingListIsEmpty);
                  }
                },
                child: Row(
                  children: [
                    const ImageIcon(
                      AssetImage(Assets.iconsIcShare),
                      size: 15,
                    ),
                    const Gap(5),
                    TextBodyMedium(
                      text: StringConstants.share,
                      color: AppColors.iconPrimary,
                    )
                  ],
                ),
              ),
            ],
          ),
          const Gap(20),
          if (shoppingList.isNotEmpty)
            Row(
              children: [
                Checkbox(
                  semanticLabel: StringConstants.selectAll,
                  activeColor: AppColors.surfaceGreen,
                  value: isSelectAll,
                  onChanged: (value) {
                    isSelectAll = value ?? false;
                    for (var item in shoppingList) {
                      item.isSelected = value ?? false;
                    }
                    isDelete = shoppingList.any(
                      (element) => element.isSelected ?? false,
                    );
                    setState(() {});
                  },
                ),
                TextBodyMedium(
                  text: StringConstants.selectAll,
                  color: AppColors.textError,
                  letterSpacing: 0,
                ),
                const Gap(10),
                isDelete
                    ? CustomClick(
                        onTap: () {
                          CustomDialog.positiveNegativeButtons(
                            title: StringConstants.areYouSureYouWantToDeleteThisAllProduct,
                            onNegativePressed: () {
                              if (Get.isDialogOpen ?? false) {
                                Get.back();
                              }
                            },
                            onPositivePressed: () async {
                              if (Get.isDialogOpen ?? false) {
                                Get.back();
                              }
                              List<ShoppingModel> items = shoppingList
                                  .where(
                                    (element) => element.isSelected ?? false,
                                  )
                                  .toList();
                              await LocalShoppingHelper.instance.removeProductByProductList(items);
                              await Future.delayed(const Duration(seconds: 1));
                              setState(() {
                                shoppingList = Get.find<HomeViewModel>().getShoppingListItemCount();
                                isSelectAll = false;
                                isDelete = shoppingList.any(
                                  (element) => element.isSelected ?? false,
                                );
                              });
                            },
                          );
                        },
                        child: Row(
                          children: [
                            const ImageIcon(
                              AssetImage(Assets.iconsTrash),
                              size: 20,
                              color: AppColors.textError,
                            ),
                            const SizedBox(width: 10),
                            TextBodyMedium(
                              text: StringConstants.delete,
                              color: AppColors.textError,
                              letterSpacing: 0,
                            ),
                          ],
                        ),
                      )
                    : const SizedBox(),
              ],
            ),
          Flexible(
            child: RefreshIndicator(
              onRefresh: () async {
                setState(() {
                  shoppingList = Get.find<HomeViewModel>().getShoppingListItemCount();
                });
              },
              child: ListView(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                children: [
                  shoppingList.isEmpty
                      ? Container(
                          alignment: Alignment.center,
                          height: 30.h,
                          child: TextHeadlineMedium(
                            text: StringConstants.noDataFound,
                          ),
                        )
                      : ListView.separated(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return ShoppingItem(
                              id: index,
                              data: shoppingList[index],
                              onChange: (value) {
                                shoppingList[index].isSelected = value;
                                isDelete = shoppingList.any(
                                  (element) => element.isSelected ?? false,
                                );
                                setState(() {});
                              },
                              deleteItem: () {
                                LocalShoppingHelper.instance.removeProduct(
                                  index,
                                  ShoppingModel(
                                    id: shoppingList[index].id,
                                    image: "",
                                    name: shoppingList[index].name,
                                    qty: 1,
                                  ),
                                );
                                setState(() {
                                  shoppingList = Get.find<HomeViewModel>().getShoppingListItemCount();
                                });
                              },
                            );
                          },
                          separatorBuilder: (context, index) {
                            return const Gap(10);
                          },
                          itemCount: shoppingList.length,
                        ),
                ],
              ),
            ),
          ),
          const Gap(40)
        ],
      ),
    );
  }
}
