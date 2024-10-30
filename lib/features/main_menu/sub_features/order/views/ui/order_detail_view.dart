import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:venturo_food/configs/themes/main_color.dart';
import 'package:venturo_food/features/main_menu/controllers/list_controller.dart';
import 'package:venturo_food/features/main_menu/sub_features/order/controllers/order_controller.dart';
import 'package:venturo_food/features/main_menu/sub_features/order/views/components/order_price_detail.dart';
import 'package:venturo_food/features/main_menu/views/components/custom_appbar.dart';
import 'package:venturo_food/constants/cores/assets/image_constant.dart';
import 'package:venturo_food/features/main_menu/views/components/custom_bottomnavbar.dart';
import 'package:venturo_food/features/main_menu/sub_features/order/views/components/order_detail_card.dart';
import 'package:venturo_food/features/main_menu/views/components/section_header.dart';

class OrderDetailView extends StatelessWidget {
  const OrderDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    var voucher = OrderController.to.selectedOrder['voucher'] as Map;
    final foodOrder = OrderController.to.foodOrders;
    final drinkOrder = OrderController.to.drinkOrders;
    final snackOrder = OrderController.to.snackOrders;

    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: Obx(
          () => CustomBottomnavbar(
            currentIndex: ListController.to.currentNavBarIndex.value,
          ),
        ),
        backgroundColor: MainColor.white,
        appBar: CustomAppbar(
          appBarTitle: 'Orders'.tr,
          icon: ImageConstant.pesananIcon,
          isOrder: true,
        ),
        body: Column(
          children: [
            SizedBox(
              height: voucher.isNotEmpty ? 300.h : 310.h,
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 25.w),
                itemCount: OrderController.to.getItemCount(),
                itemBuilder: (context, index) {
                  // Check for Food Orders
                  if (foodOrder.isNotEmpty) {
                    if (index == 0) {
                      return Container(
                        margin: EdgeInsets.only(top: 15.w, bottom: 4.w),
                        child: SectionHeader(
                          color: MainColor.primary,
                          title: 'Food'.tr,
                          icon: SvgPicture.asset(
                            ImageConstant.makananIconSvg,
                            height: 14.h,
                          ),
                        ),
                      );
                    } else if (index > 0 && index <= foodOrder.length) {
                      final item = foodOrder[index - 1];
                      return OrderDetailCard(
                        menu: item,
                      );
                    }
                  }

                  final drinkStartIndex =
                      foodOrder.isNotEmpty ? foodOrder.length + 1 : 0;
                  if (drinkOrder.isNotEmpty && index == drinkStartIndex) {
                    return Container(
                      margin: EdgeInsets.only(top: 15.w),
                      child: SectionHeader(
                        color: MainColor.primary,
                        title: 'Beverages'.tr,
                        icon: SvgPicture.asset(
                          ImageConstant.minumanIconSvg,
                        ),
                      ),
                    );
                  } else if (drinkOrder.isNotEmpty && index > drinkStartIndex) {
                    final minumanIndex = index - (drinkStartIndex + 1);
                    if (minumanIndex < drinkOrder.length) {
                      final item = drinkOrder[minumanIndex];
                      return OrderDetailCard(
                        menu: item,
                      );
                    }
                  }

                  final snackStartIndex =
                      (foodOrder.isNotEmpty ? foodOrder.length + 1 : 0) +
                          (drinkOrder.isNotEmpty ? drinkOrder.length + 1 : 0);
                  if (snackOrder.isNotEmpty && index == snackStartIndex) {
                    return Container(
                      margin: EdgeInsets.only(top: 15.w),
                      child: SectionHeader(
                        color: MainColor.primary,
                        title: 'Snack'.tr,
                        icon: SvgPicture.asset(
                          ImageConstant.makananIconSvg,
                        ),
                      ),
                    );
                  } else if (snackOrder.isNotEmpty && index > snackStartIndex) {
                    final snackIndex = index - (snackStartIndex + 1);
                    if (snackIndex < snackOrder.length) {
                      final item = snackOrder[snackIndex];
                      return OrderDetailCard(
                        menu: item,
                      );
                    }
                  }

                  return const SizedBox.shrink();
                },
              ),
            ),
            const OrderPriceDetail(),
          ],
        ),
      ),
    );
  }
}
