import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:venturo_food/features/main_menu/sub_features/order/controllers/order_controller.dart';
import 'package:venturo_food/features/main_menu/sub_features/order/views/components/build_finished_orders.dart';
import 'package:venturo_food/features/main_menu/sub_features/order/views/components/build_ongoing_orders.dart';

class OrderListItem extends StatelessWidget {
  const OrderListItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final tabValue = OrderController.to.orderAppbarValue.value;

      if (tabValue == 0) {
        return const BuildOngoingOrders();
      } else {
        return const BuildFinishedOrders();
      }
    });
  }
}
