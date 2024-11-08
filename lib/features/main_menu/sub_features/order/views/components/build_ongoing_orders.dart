import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:venturo_food/features/main_menu/sub_features/order/controllers/order_controller.dart';
import 'package:venturo_food/features/main_menu/sub_features/order/views/components/empty_order.dart';
import 'package:venturo_food/features/main_menu/sub_features/order/views/components/order_card.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BuildOngoingOrders extends StatelessWidget {
  const BuildOngoingOrders({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        final ongoingOrders = OrderController.to.ongoingOrders;
        if (ongoingOrders.isEmpty) return const EmptyOrder();

        return SingleChildScrollView(
          padding: EdgeInsets.only(top: 10.w, bottom: 50.w),
          child: ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: ongoingOrders.length,
            itemBuilder: (context, index) =>
                OrderCard(orderItem: ongoingOrders[index]),
          ),
        );
      },
    );
  }
}
