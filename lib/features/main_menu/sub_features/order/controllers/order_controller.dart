import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:venturo_food/features/main_menu/sub_features/order/repositories/order_repository.dart';
import 'package:venturo_food/utils/services/firebase_messaging_service.dart';

class OrderController extends GetxController
    with GetSingleTickerProviderStateMixin {
  static OrderController get to => Get.find<OrderController>();
  late TabController tabController;
  RxInt orderAppbarValue = 0.obs;
  RxList<Map<String, dynamic>> orders = <Map<String, dynamic>>[].obs;
  RxMap<String, dynamic> selectedOrder = <String, dynamic>{}.obs;
  final formatter = NumberFormat.currency(
    locale: 'id_ID',
    symbol: 'Rp. ',
    decimalDigits: 0,
  );
  RxString filterSelectedValue = 'All Status'.tr.obs;
  RxString filterStartDate = '12/10/24'.obs;
  RxString filterEndDate = '30/12/24'.obs;
  var repository = OrderRepository();

  @override
  void onInit() {
    repository.getOrders();
    super.onInit();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }

  int getItemCount() {
    int count = 0;

    if (drinkOrders.isNotEmpty) {
      count += drinkOrders.length + 1;
    }

    if (foodOrders.isNotEmpty) {
      count += foodOrders.length + 1;
    }

    if (snackOrders.isNotEmpty) {
      count += snackOrders.length + 1;
    }

    return count;
  }

  List<Map<String, dynamic>> get ongoingOrders {
    return orders
        .where((order) => order['status'] == 0 || order['status'] == 1)
        .toList();
  }

  List<Map<String, dynamic>> finishedOrders({
    bool completed = false,
    bool canceled = false,
  }) {
    if (completed) {
      return orders.where((order) => order['status'] == 2).toList();
    } else if (canceled) {
      return orders.where((order) => order['status'] == 3).toList();
    } else {
      return orders
          .where((order) => order['status'] == 2 || order['status'] == 3)
          .toList();
    }
  }

  Future<bool> addOrder(
    List<Map<String, dynamic>> newOrder,
    Map<String, int> voucher,
    num harga,
  ) async {
    try {
      orders.add(
        {
          'item': newOrder,
          'voucher': voucher,
          'harga': harga,
          'date': DateTime.now(),
          'status': 0 //0=ongoing, 1=ready, 2=success, 3=canceled
        },
      );

      repository.getOrders();

      return true;
    } catch (exception, stacktrace) {
      await Sentry.captureException(
        exception,
        stackTrace: stacktrace,
      );

      return false;
    }
  }

  String extractMenuTitles(Map<String, dynamic> data) {
    return (data['item'] as List<dynamic>)
        .map((item) => item['name'] as String)
        .join(', ');
  }

  String getFinalSpending() {
    num totalSpending = 0;
    List<dynamic> items = finishedOrders() as List<dynamic>;

    for (var i = 0; i < items.length; i++) {
      if (items[i]['status'] == 2) {
        totalSpending = totalSpending + items[i]['harga'];
      }
    }

    return formatter.format(totalSpending);
  }

  List<Map<String, dynamic>> get foodOrders {
    List<Map<String, dynamic>> foods = [];
    List<dynamic> items = selectedOrder['item'] as List<dynamic>;

    for (var item in items) {
      if (item['category'] == 'makanan') {
        foods.add(item);
      }
    }
    return foods;
  }

  List<Map<String, dynamic>> get drinkOrders {
    List<Map<String, dynamic>> drinks = [];
    List<dynamic> items = selectedOrder['item'] as List<dynamic>;

    for (var item in items) {
      if (item['category'] == 'minuman') {
        drinks.add(item);
      }
    }
    return drinks;
  }

  List<Map<String, dynamic>> get snackOrders {
    List<Map<String, dynamic>> drinks = [];
    List<dynamic> items = selectedOrder['item'] as List<dynamic>;

    for (var item in items) {
      if (item['category'] == 'snack') {
        drinks.add(item);
      }
    }
    return drinks;
  }

  num get totalOrderPrice {
    num price = 0;
    List<dynamic> items = selectedOrder['item'] as List<dynamic>;

    for (var item in items) {
      price = price + (item['harga'] * item['jumlah']);
    }
    return price;
  }

  void updateOrderStatus({isCancelOrder = false}) {
    bool cancel = isCancelOrder;

    for (int i = 0; i < orders.length; i++) {
      var currentOrder = orders[i];

      bool isMatch = (currentOrder['item'] == selectedOrder['item']) &&
          (currentOrder['harga'] == selectedOrder['harga']) &&
          (currentOrder['date'] == selectedOrder['date']);

      if (isMatch) {
        if (cancel) {
          orders[i]['status'] = 3;
          FirebaseMessagingService.showNotification(
            title: 'Success'.tr,
            body: 'Order Canceled'.tr,
          );
          orders.refresh();
          selectedOrder.refresh();
        } else if (orders[i]['status'] == 2) {
          FirebaseMessagingService.showNotification(
            title: 'Success'.tr,
            body: 'Order Completed'.tr,
          );
          orders.refresh();
          selectedOrder.refresh();
        } else {
          orders[i]['status']++;
          orders.refresh();
          selectedOrder.refresh();
          if (orders[i]['status'] == 2) {
            FirebaseMessagingService.showNotification(
              title: 'Success'.tr,
              body: 'Order Completed'.tr,
            );
          }
        }
      }
    }
  }
}
