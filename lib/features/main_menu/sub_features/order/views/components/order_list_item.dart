import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:venturo_food/features/main_menu/sub_features/order/controllers/order_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:venturo_food/features/main_menu/sub_features/order/views/components/empty_order.dart';
import 'package:venturo_food/features/main_menu/sub_features/order/views/components/order_card.dart';
import 'package:venturo_food/features/main_menu/sub_features/order/views/components/order_filter.dart';
import 'package:venturo_food/features/main_menu/sub_features/order/views/components/total_price_info.dart';

class OrderListItem extends StatelessWidget {
  const OrderListItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        final tabValue = OrderController.to.orderAppbarValue.value;
        final ongoingOrders = OrderController.to.ongoingOrders;
        final finishedOrders = OrderController.to.finishedOrders();
        final completedOrders =
            OrderController.to.finishedOrders(completed: true);
        final canceledOrders =
            OrderController.to.finishedOrders(canceled: true);
        final filterValue = OrderController.to.filterSelectedValue.value;

        if (tabValue == 0) {
          if (ongoingOrders.isNotEmpty) {
            return SingleChildScrollView(
              padding: EdgeInsets.only(
                top: 10.w,
                bottom: 50.w,
              ),
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: ongoingOrders.length,
                itemBuilder: (context, index) {
                  return OrderCard(
                    orderItem: ongoingOrders[index],
                  );
                },
              ),
            );
          } else {
            return const EmptyOrder();
          }
        } else {
          if (finishedOrders.isNotEmpty) {
            return Column(
              children: [
                const OrderFilter(),
                if (filterValue == 'Semua Status') ...{
                  SizedBox(
                    height: 530.h,
                    child: SingleChildScrollView(
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: finishedOrders.length,
                        itemBuilder: (context, index) {
                          return OrderCard(
                            isCompleted: true,
                            orderItem: finishedOrders[index],
                          );
                        },
                      ),
                    ),
                  ),
                  const Spacer(),
                  const TotalPriceInfo(),
                } else if (filterValue == 'Selesai') ...{
                  if (completedOrders.isEmpty) ...{
                    SizedBox(
                      height: 530.h,
                      child: const EmptyOrder(
                        customMessage: 'Belum ada pesanan Selesai',
                      ),
                    ),
                  } else ...{
                    SizedBox(
                      height: 530.h,
                      child: SingleChildScrollView(
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: OrderController.to
                              .finishedOrders(completed: true)
                              .length,
                          itemBuilder: (context, index) {
                            return OrderCard(
                              isCompleted: true,
                              orderItem: OrderController.to.finishedOrders(
                                completed: true,
                              )[index],
                            );
                          },
                        ),
                      ),
                    ),
                    const Spacer(),
                    const TotalPriceInfo(),
                  },
                } else if (filterValue == 'Dibatalkan') ...{
                  if (canceledOrders.isEmpty) ...{
                    SizedBox(
                      height: 584.h,
                      child: const EmptyOrder(
                        customMessage: 'Belum ada pesanan Dibatalkan',
                      ),
                    ),
                  } else ...{
                    SizedBox(
                      height: 584.h,
                      child: SingleChildScrollView(
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: OrderController.to
                              .finishedOrders(canceled: true)
                              .length,
                          itemBuilder: (context, index) {
                            return OrderCard(
                              isCompleted: true,
                              orderItem: OrderController.to.finishedOrders(
                                canceled: true,
                              )[index],
                            );
                          },
                        ),
                      ),
                    ),
                  }
                }
              ],
            );
          } else {
            return const EmptyOrder();
          }
        }
      },
    );
  }
}
