import 'package:flutter/material.dart';
import 'package:venturo_food/features/main_menu/sub_features/order/controllers/order_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:venturo_food/features/main_menu/sub_features/order/views/components/order_card.dart';

class OrderListItem extends StatelessWidget {
  const OrderListItem({super.key});

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> orderItems = OrderController.to.orders;

    return SingleChildScrollView(
      padding: EdgeInsets.only(
        top: 10.w,
        bottom: 50.w,
      ),
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: orderItems.length,
        itemBuilder: (context, index) {
          print(orderItems);
          return OrderCard(
            orderItem: orderItems[index],
          );
        },
      ),
    );
  }
}
