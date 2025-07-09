import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:revalesuva/components/custom_click.dart';
import 'package:revalesuva/components/custom_text.dart';
import 'package:revalesuva/model/order/order_model.dart' as order_model;
import 'package:revalesuva/utils/app_colors.dart';
import 'package:revalesuva/utils/app_corner.dart';
import 'package:revalesuva/utils/date_format_helper.dart';
import 'package:revalesuva/utils/helper_method.dart';
import 'package:revalesuva/utils/navigation_helper.dart';
import 'package:revalesuva/views/order/order_detail_view.dart';

class OrderItemsWidget extends StatelessWidget {
  const OrderItemsWidget({
    super.key,
    required this.data,
  });

  final order_model.Datum data;

  @override
  Widget build(BuildContext context) {
    return CustomClick(
      onTap: () {
        NavigationHelper.pushScreenWithNavBar(
            widget: OrderDetailView(
              data: data,
            ),
            context: context);
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextTitleMedium(
                  text: data.orderNumber ?? "",
                  maxLine: 1,
                ),
                TextBodyMedium(
                  text: changeDateStringFormat(
                    date: data.date.toString(),
                    format: DateFormatHelper.ymdFormat,
                  ),
                  maxLine: 1,
                  color: AppColors.textPrimary,
                ),
                const Gap(10),
                getStatusOrderStatus(orderStatus: data.orderStatus ?? "")
              ],
            ),
          ],
        ),
      ),
    );
  }
}
