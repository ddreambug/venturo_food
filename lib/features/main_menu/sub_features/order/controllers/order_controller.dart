import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class OrderController extends GetxController
    with GetSingleTickerProviderStateMixin {
  static OrderController get to => Get.find<OrderController>();
  late TabController tabController;
  RxInt orderAppbarValue = 0.obs;
  RxList<Map<String, dynamic>> orders = <Map<String, dynamic>>[].obs;
  RxMap<String, dynamic> selectedOrder = <String, dynamic>{}.obs;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }

  List<Map<String, dynamic>> get ongoingOrders {
    return orders
        .where((order) => order['status'] == 0 || order['status'] == 1)
        .toList();
  }

  List<Map<String, dynamic>> get finishedOrders {
    return orders
        .where((order) => order['status'] == 2 || order['status'] == 3)
        .toList();
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
          orders.refresh();
          selectedOrder.refresh();
        } else {
          orders[i]['status']++;
          orders.refresh();
          selectedOrder.refresh();
        }
      }
    }
  }
}
