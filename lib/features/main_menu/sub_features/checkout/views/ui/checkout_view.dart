import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:venturo_food/configs/themes/main_color.dart';
import 'package:venturo_food/features/main_menu/sub_features/checkout/controllers/checkout_controller.dart';
import 'package:venturo_food/features/main_menu/sub_features/checkout/views/components/checkout_bottom_navbar.dart';
import 'package:venturo_food/features/main_menu/sub_features/checkout/views/components/checkout_cart.dart';
import 'package:venturo_food/features/main_menu/sub_features/checkout/views/components/checkout_empty_cart.dart';
import 'package:venturo_food/features/main_menu/sub_features/checkout/views/components/checkout_price_detail.dart';
import 'package:venturo_food/features/main_menu/views/components/custom_appbar.dart';
import 'package:venturo_food/constants/cores/assets/image_constant.dart';
import 'package:venturo_food/features/main_menu/views/components/section_header.dart';

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
                        child: Obx(
                          () {
                            final makananItems =
                                CheckoutController.to.makananCart;
                            final minumanItems =
                                CheckoutController.to.minumanCart;

                            return ListView.builder(
                              padding: EdgeInsets.symmetric(horizontal: 25.w),
                              itemCount: minumanItems.isNotEmpty
                                  ? (makananItems.isNotEmpty
                                      ? cartItem.length + 2
                                      : minumanItems.length + 1)
                                  : makananItems.length + 1,
                              itemBuilder: (context, index) {
                                if (makananItems.isNotEmpty) {
                                  if (index == 0) {
                                    return Container(
                                      margin: EdgeInsets.only(
                                        top: 15.w,
                                        bottom: 4.w,
                                      ),
                                      child: SectionHeader(
                                        color: MainColor.primary,
                                        title: 'Makanan',
                                        icon: SvgPicture.asset(
                                          ImageConstant.makananIconSvg,
                                          height: 14.h,
                                        ),
                                      ),
                                    );
                                  } else if (index > 0 &&
                                      index <= makananItems.length) {
                                    final item = makananItems[index - 1];
                                    return CheckoutCart(
                                      context: context,
                                      item: item,
                                    );
                                  }
                                }

                                final minumanStartIndex =
                                    makananItems.isNotEmpty
                                        ? makananItems.length + 1
                                        : 0;

                                if (minumanItems.isNotEmpty &&
                                    index == minumanStartIndex) {
                                  return Container(
                                    margin: EdgeInsets.only(top: 15.w),
                                    child: SectionHeader(
                                      color: MainColor.primary,
                                      title: 'Minuman',
                                      icon: SvgPicture.asset(
                                        ImageConstant.minumanIconSvg,
                                      ),
                                    ),
                                  );
                                } else if (minumanItems.isNotEmpty &&
                                    index > minumanStartIndex) {
                                  final minumanIndex =
                                      index - (minumanStartIndex + 1);
                                  final item = minumanItems[minumanIndex];
                                  return CheckoutCart(
                                    context: context,
                                    item: item,
                                  );
                                }

                                return const SizedBox.shrink();
                              },
                            );
                          },
                        ),
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
