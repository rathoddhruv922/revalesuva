import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:revalesuva/components/custom_button.dart';
import 'package:revalesuva/components/custom_click.dart';
import 'package:revalesuva/components/custom_dialog.dart';
import 'package:revalesuva/components/custom_text.dart';
import 'package:revalesuva/model/order/order_model.dart' as order_model;
import 'package:revalesuva/utils/app_colors.dart';
import 'package:revalesuva/utils/date_format_helper.dart';
import 'package:revalesuva/utils/helper_method.dart';
import 'package:revalesuva/utils/navigation_helper.dart';
import 'package:revalesuva/utils/strings_constant.dart';
import 'package:revalesuva/view_models/order/order_view_model.dart';
import 'package:revalesuva/views/order/widget/order_detail_product_item_widget.dart';

class OrderDetailView extends StatelessWidget {
  OrderDetailView({
    super.key,
    required this.data,
  });

  final order_model.Datum data;

  final OrderViewModel orderViewModel = Get.find<OrderViewModel>();

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        NavigationHelper.onBackScreen(
            widget: OrderDetailView(
          data: data,
        ));
      },
      canPop: true,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Gap(10),
              CustomClick(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: TextBodySmall(
                  text: "< ${StringConstants.backTo} ${StringConstants.myOrders}",
                  color: AppColors.textPrimary,
                  letterSpacing: 0,
                ),
              ),
              const Gap(10),
              TextHeadlineMedium(text: StringConstants.orderDetails),
              const Gap(10),
              Flexible(
                child: ListView(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                  children: [
                    CustomCard2(
                      color: AppColors.surfaceTertiary,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextTitleMedium(
                                      text: data.orderNumber ?? "",
                                      weight: 4,
                                    ),
                                    TextBodyMedium(
                                      text: changeDateStringFormat(
                                        date: data.date.toString(),
                                        format: DateFormatHelper.ymdFormat,
                                      ),
                                      maxLine: 1,
                                      color: AppColors.textPrimary,
                                    ),
                                  ],
                                ),
                              ),
                              getStatusOrderStatus(orderStatus: data.orderStatus ?? "")
                            ],
                          ),
                          const Gap(10),
                          Flexible(
                            child: ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return OrderDetailProductItemWidget(
                                  data: data.orderDetails?[index] ?? order_model.OrderDetail(),
                                );
                              },
                              separatorBuilder: (context, index) => const Gap(10),
                              itemCount: data.orderDetails?.length ?? 0,
                            ),
                          ),
                          const Gap(10),
                          Row(
                            children: [
                              Expanded(
                                child: TextHeadlineMedium(
                                  text: StringConstants.totalAmount,
                                ),
                              ),
                              TextHeadlineMedium(
                                text: "${data.grandTotal} ₪",
                                size: -2,
                                weight: 10,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const Gap(20),
                    data.orderStatus == "cancelled"
                        || data.orderStatus == "returned"
                        || data.orderStatus == "refunded"
                        || data.orderStatus == "delivered"
                        ? const SizedBox()
                        : SimpleButton(
                            text: StringConstants.cancelOrder,
                            onPressed: () {
                              CustomDialog.positiveNegativeButtons(
                                title: StringConstants.areYouSureYouWantToCancelThisOrder,
                                onNegativePressed: () {
                                  if (Get.isDialogOpen ?? false) {
                                    Get.back();
                                  }
                                },
                                onPositivePressed: () async {
                                  if (Get.isDialogOpen ?? false) {
                                    Get.back();
                                  }
                                  bool isSuccess =
                                      await orderViewModel.cancelOrder(orderId: data.id ?? 0);
                                  await orderViewModel.fetchOrders();
                                  if (isSuccess && context.mounted) {
                                    Navigator.of(context).pop();
                                  }
                                },
                              );
                            },
                          ),
                  ],
                ),
              ),
              const Gap(50),
            ],
          ),
        ),
      ),
    );
  }
}
