import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
    } catch (e) {
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
}
