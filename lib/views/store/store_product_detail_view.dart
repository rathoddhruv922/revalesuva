import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:revalesuva/components/custom_Image_viewer.dart';
import 'package:revalesuva/components/custom_button.dart';
import 'package:revalesuva/components/custom_click.dart';
import 'package:revalesuva/components/custom_text.dart';
import 'package:revalesuva/components/half_circle_painter.dart';
import 'package:revalesuva/generated/assets.dart';
import 'package:revalesuva/model/store/store_model.dart' as store_model;
import 'package:revalesuva/utils/app_colors.dart';
import 'package:revalesuva/utils/app_corner.dart';
import 'package:revalesuva/utils/extension.dart';
import 'package:revalesuva/utils/helper_method.dart';
import 'package:revalesuva/utils/local_cart_helper.dart';
import 'package:revalesuva/utils/navigation_helper.dart';
import 'package:revalesuva/utils/strings_constant.dart';
import 'package:revalesuva/view_models/home/home_view_model.dart';
import 'package:revalesuva/view_models/store/store_favorites_view_model.dart';
import 'package:revalesuva/views/store/my_cart_list_view.dart';

class StoreProductDetailView extends StatefulWidget {
  const StoreProductDetailView({super.key, required this.data, this.isFavourite});

  final store_model.Datum data;
  final bool? isFavourite;

  @override
  State<StoreProductDetailView> createState() => _StoreProductDetailViewState();
}

class _StoreProductDetailViewState extends State<StoreProductDetailView> {
  int qty = 0;
  int id = -1;
  bool? isFavourite;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        var cartList = Get.find<HomeViewModel>().getCartListItemCount();
        Get.find<HomeViewModel>().getCartListItemCount();
        id = cartList.indexWhere(
          (element) => element.id == widget.data.id,
        );
        if (id >= 0) {
          qty = cartList[id].qty ?? 0;
        }
        isFavourite = widget.isFavourite;
        setState(() {});
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        NavigationHelper.onBackScreen(
          widget: StoreProductDetailView(
            data: widget.data,
          ),
        );
      },
      canPop: true,
      child: Scaffold(
        body: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: CustomClick(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: TextBodySmall(
                      text: "< ${StringConstants.backTo} ${StringConstants.store}",
                      color: AppColors.textPrimary,
                      letterSpacing: 0,
                    ),
                  ),
                ),
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(AppCorner.cardBoarder),
                        child: AspectRatio(
                          aspectRatio: 18 / 10,
                          child: Stack(
                            fit: StackFit.loose,
                            children: [
                              CustomImageViewer(
                                imageUrl: widget.data.image,
                                errorImage: Image.asset(
                                  Assets.imagesPlaceholderImg,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Align(
                                alignment: AlignmentDirectional.bottomEnd,
                                child: Container(
                                  margin: const EdgeInsets.all(10),
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: AppColors.shadowColor),
                                    color: AppColors.surfaceTertiary,
                                    shape: BoxShape.circle,
                                  ),
                                  child: CustomClick(
                                    onTap: () async {
                                      bool isSuccess = await Get.find<StoreFavoritesViewModel>()
                                          .addRemoveStoreFavourite(storeProductId: widget.data.id ?? 0);
                                      if (isSuccess) {
                                        if (isFavourite == null) {
                                          widget.data.favourite = !(widget.data.favourite ?? true);
                                        } else {
                                          isFavourite = !(isFavourite ?? true);
                                        }
                                        setState(() {});
                                      }
                                    },
                                    child: Image.asset(
                                      width: 20,
                                      ((widget.data.favourite ?? false) || (isFavourite ?? false))
                                          ? Assets.iconsIcLike
                                          : Assets.iconsIcLikeBlank,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const Gap(20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextHeadlineMedium(
                                text: widget.data.productName?.toCapitalized() ?? "",
                                maxLine: 2,
                              ),
                            ),
                            TextHeadlineMedium(
                              text: "${widget.data.price ?? " "} ₪",
                              weight: 4,
                              maxLine: 2,
                              size: -1,
                            ),
                          ],
                        ),
                      ),
                      const Gap(20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Row(
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
                            const Gap(10),
                            TextHeadlineMedium(
                              text: "$qty",
                              size: -1,
                            ),
                            const Gap(10),
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
                            const Gap(20),
                            Expanded(
                              child: SimpleButton(
                                text: id == -1 ? StringConstants.addToCart : StringConstants.update,
                                onPressed: () async {
                                  if (qty != 0) {
                                    if (id == -1) {
                                      await LocalCartHelper.instance.addProduct(
                                        store_model.Datum(
                                          id: widget.data.id,
                                          description: widget.data.description,
                                          createdAt: widget.data.createdAt,
                                          favoriteUsersCount: widget.data.favoriteUsersCount,
                                          favourite: widget.data.favourite,
                                          isActive: widget.data.isActive,
                                          price: widget.data.price,
                                          productName: widget.data.productName,
                                          quantity: widget.data.quantity,
                                          recommended: widget.data.recommended,
                                          storeCategoryId: widget.data.storeCategoryId,
                                          updatedAt: widget.data.updatedAt,
                                          image: widget.data.image,
                                          qty: qty,
                                        ),
                                      );
                                      showToast(msg: "added in cart");
                                    } else {
                                      LocalCartHelper.instance.updateQty(id, qty);
                                      showToast(msg: "Updated Quantity Successfully");
                                    }
                                    var cartList = Get.find<HomeViewModel>().getCartListItemCount();
                                    Get.find<HomeViewModel>().getCartListItemCount();
                                    id = cartList.indexWhere(
                                      (element) => element.id == widget.data.id,
                                    );
                                    if (id >= 0) {
                                      qty = cartList[id].qty ?? 0;
                                    }

                                    setState(() {});
                                  } else {
                                    showToast(msg: "quantity is 0");
                                  }
                                },
                                height: 35,
                                backgroundColor:
                                    id == -1 ? AppColors.surfaceBrand : AppColors.surfaceTertiary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Gap(20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: customHtmlWidget(widget.data.description ?? ""),
                      ),
                      const Gap(20),
                    ],
                  ),
                ),
                const Gap(80),
              ],
            ),
            Obx(
              () => Get.find<HomeViewModel>().cartListItemCount.value != 0
                  ? Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: CustomClick(
                          onTap: () {
                            Navigator.of(context).pop();
                            NavigationHelper.pushScreenWithNavBar(
                                widget: const MyCartListView(), context: context);
                          },
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              CustomPaint(
                                size: const Size(100, 15),
                                painter: HalfCirclePainter(color: AppColors.surfaceGreen),
                              ),
                              SizedBox(
                                width: 80,
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 50, top: 5),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Badge(
                                        label: TextBodySmall(
                                            text:
                                                "${Get.find<HomeViewModel>().cartListItemCount.value}"),
                                        child: const ImageIcon(
                                          AssetImage(Assets.iconsIcCart),
                                          color: Colors.white,
                                          size: 25,
                                        ),
                                      ),
                                      const Gap(2),
                                      TextBodySmall(
                                        text: StringConstants.toShoppingList,
                                        textAlign: TextAlign.center,
                                        size: -1,
                                        maxLine: 1,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  : const SizedBox(),
            )
          ],
        ),
      ),
    );
  }
}
