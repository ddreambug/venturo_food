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
    final List<dynamic> selectedOrder =
        OrderController.to.selectedOrder['item'] as List<dynamic>;
    var voucher = OrderController.to.selectedOrder['voucher'] as Map;
    final foodOrder = OrderController.to.foodOrders;
    final drinkOrder = OrderController.to.drinkOrders;

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
                itemCount: drinkOrder.isNotEmpty
                    ? foodOrder.isNotEmpty
                        ? selectedOrder.length + 2
                        : drinkOrder.length + 1
                    : foodOrder.length + 1,
                itemBuilder: (context, index) {
                  if (foodOrder.isNotEmpty) {
                    if (index == 0) {
                      return Container(
                        margin: EdgeInsets.only(
                          top: 15.w,
                          bottom: 4.w,
                        ),
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
                    final item = drinkOrder[minumanIndex];
                    return OrderDetailCard(
                      menu: item,
                    );
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
