import 'package:flutter/material.dart';
import 'package:venturo_food/features/main_menu/sub_features/order/controllers/order_controller.dart';
import 'package:venturo_food/features/main_menu/sub_features/order/views/components/empty_order.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:venturo_food/features/main_menu/sub_features/order/views/components/order_card.dart';
import 'package:venturo_food/features/main_menu/sub_features/order/views/components/order_filter.dart';
import 'package:venturo_food/features/main_menu/sub_features/order/views/components/total_price_info.dart';

class BuildFinishedOrders extends StatelessWidget {
  const BuildFinishedOrders({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        final finishedOrders = OrderController.to.finishedOrders();
        final filterValue = OrderController.to.filterSelectedValue.value;

        if (finishedOrders.isEmpty) return const EmptyOrder();

        List<Map<String, dynamic>> filteredOrders;
        String emptyMessage;

        if (filterValue == 'Done') {
          filteredOrders = OrderController.to.finishedOrders(completed: true);
          emptyMessage = 'No Order Completed Yet'.tr;
        } else if (filterValue == 'Canceled') {
          filteredOrders = OrderController.to.finishedOrders(canceled: true);
          emptyMessage = 'No Order Canceled Yet'.tr;
        } else {
          filteredOrders = finishedOrders;
          emptyMessage = '';
        }

        return Column(
          children: [
            const OrderFilter(),
            if (filteredOrders.isEmpty) ...{
              SizedBox(
                height: 530.h,
                child: EmptyOrder(customMessage: emptyMessage),
              ),
            } else ...{
              if (finishedOrders[0]['status'] == 4) ...{
                Padding(
                  padding: EdgeInsets.fromLTRB(20.w, 250.w, 20.w, 200.w),
                  child: Text(
                    'Tidak ada order ditemukan di tanggal tersebut'.tr,
                    textAlign: TextAlign.center,
                  ),
                ),
              } else ...{
                SizedBox(
                  height: 530.h,
                  child: SingleChildScrollView(
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: filteredOrders.length,
                      itemBuilder: (context, index) => OrderCard(
                        isCompleted: true,
                        orderItem: filteredOrders[index],
                      ),
                    ),
                  ),
                ),
                if (filterValue != 'Canceled') ...{
                  const Spacer(),
                  const TotalPriceInfo(),
                }
              }
            },
          ],
        );
      },
    );
  }
}
