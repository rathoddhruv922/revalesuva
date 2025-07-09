import 'package:get/get.dart';
import 'package:revalesuva/model/empty_model/empty_model.dart';
import 'package:revalesuva/model/order/create_order_model.dart' as create_order_model;
import 'package:revalesuva/model/order/order_model.dart' as order_model;
import 'package:revalesuva/model/store/store_model.dart' as store_model;
import 'package:revalesuva/repository/repository.dart';
import 'package:revalesuva/services/api_status.dart';
import 'package:revalesuva/utils/date_format_helper.dart';
import 'package:revalesuva/utils/helper_method.dart';
import 'package:revalesuva/utils/local_cart_helper.dart';
import 'package:revalesuva/view_models/home/home_view_model.dart';

class OrderViewModel extends GetxController {
  var listOrder = <order_model.Datum>[].obs;
  var isLoading = false.obs;

  Future<bool> createOrder({
    required double subTotal,
    required double grandTotal,
    required List<store_model.Datum> cartList,
  }) async {
    List<create_order_model.Product> product = [];
    for (var item in cartList) {
      product.add(
        create_order_model.Product(
          productId: item.id,
          quantity: item.qty,
          price: double.tryParse(item.price ?? "0"),
        ),
      );
    }

    create_order_model.CreateOrderModel order = create_order_model.CreateOrderModel(
      date: changeDateStringFormat(
        date: DateTime.now().toString(),
        format: DateFormatHelper.ymdFormat,
      ),
      orderStatus: "pending",
      grandTotal: grandTotal,
      subTotal: subTotal,
      products: product,
    );
    showLoader();
    var response = await Repository.instance.createOrderApi(
      order: order,
    );
    hideLoader();
    if (response is Success) {
      var result = emptyModelFromJson(response.response.toString());
      showToast(msg: result.message ?? "");
      LocalCartHelper.instance.clearAllData();
      Get.find<HomeViewModel>().getCartListItemCount();
      return true;
    } else if (response is Failure) {
      showToast(msg: "${response.errorResponse ?? ""}");
    }
    return false;
  }

  fetchOrders() async {
    isLoading.value = true;
    var response = await Repository.instance.getOrdersApi();
    if (response is Success) {
      var result = order_model.orderModelFromJson(response.response.toString());
      listOrder.assignAll(result.data ?? []);
    } else if (response is Failure) {
      showToast(msg: "${response.errorResponse ?? ""}");
    }
    isLoading.value = false;
  }

  Future<bool> cancelOrder({required int orderId}) async {
    showLoader();
    var response = await Repository.instance.orderCancelApi(orderId: orderId);
    hideLoader();
    if (response is Success) {
      var result = emptyModelFromJson(response.response.toString());
      showToast(msg: result.message ?? "");
      return true;
    } else if (response is Failure) {
      showToast(msg: "${response.errorResponse ?? ""}");
    }
    return false;
  }


}
