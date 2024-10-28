import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:venturo_food/configs/themes/main_color.dart';
import 'package:venturo_food/features/main_menu/sub_features/checkout/controllers/checkout_controller.dart';
import 'package:venturo_food/features/main_menu/sub_features/checkout/views/components/checkout_bottom_navbar.dart';
import 'package:venturo_food/features/main_menu/sub_features/checkout/views/components/checkout_empty_cart.dart';
import 'package:venturo_food/features/main_menu/sub_features/checkout/views/components/checkout_list_items.dart';
import 'package:venturo_food/features/main_menu/sub_features/checkout/views/components/checkout_price_detail.dart';
import 'package:venturo_food/features/main_menu/views/components/custom_appbar.dart';
import 'package:venturo_food/constants/cores/assets/image_constant.dart';

class CheckoutView extends StatelessWidget {
  const CheckoutView({super.key});

  @override
  Widget build(BuildContext context) {
    final cartItem = CheckoutController.to.cart;

    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: Obx(
          () => cartItem.isNotEmpty
              ? const CheckoutBottomNavbar()
              : const SizedBox.shrink(),
        ),
        backgroundColor: MainColor.white,
        appBar: const CustomAppbar(
          appBarTitle: 'Pesanan',
          icon: ImageConstant.pesananIcon,
        ),
        body: Obx(
          () {
            if (cartItem.isEmpty) {
              return const CheckoutEmptyCart();
            } else {
              return Stack(
                children: [
                  Column(
                    children: [
                      SizedBox(
                        height: 440.h,
                        child: const CheckoutListItems(),
                      ),
                      CheckoutPriceDetail(cartItem: cartItem),
                    ],
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
