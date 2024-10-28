import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:venturo_food/features/main_menu/controllers/list_controller.dart';
import 'package:venturo_food/features/main_menu/sub_features/order/controllers/order_controller.dart';
import 'package:venturo_food/features/main_menu/sub_features/order/views/components/empty_order.dart';
import 'package:venturo_food/features/main_menu/sub_features/order/views/components/order_appbar.dart';
import 'package:venturo_food/features/main_menu/sub_features/order/views/components/order_list_item.dart';
import 'package:venturo_food/features/main_menu/views/components/custom_bottomnavbar.dart';

class OrderView extends StatelessWidget {
  const OrderView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const OrderAppBar(),
      bottomNavigationBar: Obx(
        () => CustomBottomnavbar(
          currentIndex: ListController.to.currentNavBarIndex.value,
        ),
      ),
      body: Obx(
        () {
          final orderData = OrderController.to.orders;

          if (orderData.isEmpty) {
            return const EmptyOrder();
          } else {
            return const OrderListItem();
          }
        },
      ),
    );
  }
}
