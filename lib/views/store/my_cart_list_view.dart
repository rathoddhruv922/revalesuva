import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:revalesuva/components/custom_button.dart';
import 'package:revalesuva/components/custom_click.dart';
import 'package:revalesuva/components/custom_dialog.dart';
import 'package:revalesuva/components/custom_text.dart';
import 'package:revalesuva/model/store/store_model.dart' as store_model;
import 'package:revalesuva/utils/app_colors.dart';
import 'package:revalesuva/utils/helper_method.dart';
import 'package:revalesuva/utils/local_cart_helper.dart';
import 'package:revalesuva/utils/navigation_helper.dart';
import 'package:revalesuva/utils/strings_constant.dart';
import 'package:revalesuva/view_models/home/home_view_model.dart';
import 'package:revalesuva/view_models/order/order_view_model.dart';
import 'package:revalesuva/views/store/thank_you_view.dart';
import 'package:revalesuva/views/store/widget/cart_item_widget.dart';

class MyCartListView extends StatefulWidget {
  const MyCartListView({super.key});

  @override
  State<MyCartListView> createState() => _MyCartListViewState();
}

class _MyCartListViewState extends State<MyCartListView> {
  List<store_model.Datum> cartList = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        setState(() {
          cartList = Get.find<HomeViewModel>().getCartListItemCount();
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        NavigationHelper.onBackScreen(widget: const MyCartListView());
      },
      canPop: true,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Gap(10),
                  CustomClick(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: TextBodySmall(
                      text: "< ${StringConstants.backTo} ${StringConstants.personalArea}",
                      color: AppColors.textPrimary,
                      letterSpacing: 0,
                    ),
                  ),
                  const Gap(10),
                  TextHeadlineMedium(text: StringConstants.myShoppingCart),
                  const Gap(5),
                  Expanded(
                    child: RefreshIndicator(
                      onRefresh: () async {
                        setState(() {
                          cartList = Get.find<HomeViewModel>().getCartListItemCount();
                          ;
                          Get.find<HomeViewModel>().getCartListItemCount();
                        });
                      },
                      child: cartList.isEmpty
                          ? ListView(
                              children: [
                                SizedBox(
                                  height: 30.h,
                                  child: Center(
                                    child: TextHeadlineMedium(
                                      text: StringConstants.noDataFound,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          : ListView.separated(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              shrinkWrap: false,
                              physics:
                                  const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                              itemBuilder: (context, index) {
                                return CartItemWidget(
                                  id: index,
                                  data: cartList[index],
                                  deleteItem: () {
                                    CustomDialog.positiveNegativeButtons(
                                      title: StringConstants.areYouSureYouWantToRemoveItemFromCart,
                                      onNegativePressed: () {
                                        if (Get.isDialogOpen ?? false) {
                                          Get.back();
                                        }
                                      },
                                      onPositivePressed: () async {
                                        if (Get.isDialogOpen ?? false) {
                                          Get.back();
                                        }
                                        await LocalCartHelper.instance.removeProduct(index);
                                        setState(() {
                                          cartList = Get.find<HomeViewModel>().getCartListItemCount();
                                        });
                                      },
                                    );
                                  },
                                );
                              },
                              separatorBuilder: (context, index) {
                                return const Gap(10);
                              },
                              itemCount: cartList.length,
                            ),
                    ),
                  ),
                ],
              ),
              Obx(
                () => Get.find<HomeViewModel>().subTotal.value == 0
                    ? const SizedBox()
                    : Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 60),
                          child: CustomCard2(
                            color: AppColors.surfaceTertiary,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                // Row(
                                //   children: [
                                //     Expanded(
                                //       child: TextHeadlineMedium(
                                //         text: StringConstants.subTotal,
                                //       ),
                                //     ),
                                //     TextHeadlineSmall(
                                //       text: "${Get.find<HomeViewModel>().subTotal.value} ₪",
                                //       weight: 10,
                                //       size: 2,
                                //       maxLine: 1,
                                //     ),
                                //   ],
                                // ),
                                const Divider(),
                                Row(
                                  children: [
                                    Expanded(
                                      child: TextHeadlineMedium(
                                        text: StringConstants.totalToBePaid,
                                      ),
                                    ),
                                    TextHeadlineSmall(
                                      text: "${Get.find<HomeViewModel>().totalAmountToBePaid.value} ₪",
                                      weight: 10,
                                      size: 2,
                                      maxLine: 1,
                                    ),
                                  ],
                                ),
                                const Gap(10),
                                SimpleButton(
                                  width: 100.w,
                                  text: StringConstants.checkout,
                                  onPressed: () async {
                                    bool isSuccess = await Get.find<OrderViewModel>().createOrder(
                                      subTotal: Get.find<HomeViewModel>().subTotal.value,
                                      grandTotal: Get.find<HomeViewModel>().totalAmountToBePaid.value,
                                      cartList: cartList,
                                    );

                                    if (isSuccess && context.mounted) {
                                      setState(() {
                                        cartList = Get.find<HomeViewModel>().getCartListItemCount();
                                      });
                                      NavigationHelper.pushReplaceScreenWithNavBar(widget: const ThankYouView(), context: context);
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
