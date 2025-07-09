import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:revalesuva/components/custom_click.dart';
import 'package:revalesuva/components/custom_text.dart';
import 'package:revalesuva/utils/app_colors.dart';
import 'package:revalesuva/utils/app_corner.dart';
import 'package:revalesuva/utils/helper_method.dart';
import 'package:revalesuva/utils/navigation_helper.dart';
import 'package:revalesuva/utils/strings_constant.dart';
import 'package:revalesuva/view_models/order/order_view_model.dart';
import 'package:revalesuva/views/order/widget/order_items_widget.dart';

class OrderListView extends StatefulWidget {
  const OrderListView({super.key});

  @override
  State<OrderListView> createState() => _OrderListViewState();
}

class _OrderListViewState extends State<OrderListView> {
  final OrderViewModel orderViewModel = Get.find<OrderViewModel>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        orderViewModel.fetchOrders();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        NavigationHelper.onBackScreen(widget: const OrderListView());
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
                  text: "< ${StringConstants.backTo} ${StringConstants.personalArea}",
                  color: AppColors.textPrimary,
                  letterSpacing: 0,
                ),
              ),
              const Gap(10),
              TextHeadlineMedium(text: StringConstants.myOrders),
              const Gap(5),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () async {
                    await orderViewModel.fetchOrders();
                  },
                  child: Obx(
                    () => orderViewModel.isLoading.isTrue
                        ? ListView.separated(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: 10,
                            itemBuilder: (context, index) {
                              return const CustomShimmer(
                                height: 80,
                                radius: AppCorner.listTile,
                              );
                            },
                            separatorBuilder: (context, index) => const Gap(10),
                          )
                        : orderViewModel.listOrder.isEmpty
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
                                  return OrderItemsWidget(
                                    data: orderViewModel.listOrder[index],
                                  );
                                },
                                separatorBuilder: (context, index) {
                                  return const Gap(10);
                                },
                                itemCount: orderViewModel.listOrder.length,
                              ),
                  ),
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
