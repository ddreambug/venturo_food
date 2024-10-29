import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:venturo_food/configs/themes/main_color.dart';
import 'package:venturo_food/constants/cores/assets/image_constant.dart';
import 'package:venturo_food/features/main_menu/sub_features/checkout/controllers/checkout_controller.dart';
import 'package:venturo_food/features/main_menu/sub_features/checkout/views/components/checkout_cart.dart';
import 'package:venturo_food/features/main_menu/views/components/section_header.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CheckoutListItems extends StatelessWidget {
  const CheckoutListItems({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        final makananItems = CheckoutController.to.makananCart;
        final minumanItems = CheckoutController.to.minumanCart;
        final cartItem = CheckoutController.to.cart;

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
                    title: 'Food'.tr,
                    icon: SvgPicture.asset(
                      ImageConstant.makananIconSvg,
                      height: 14.h,
                    ),
                  ),
                );
              } else if (index > 0 && index <= makananItems.length) {
                final item = makananItems[index - 1];
                return CheckoutCart(
                  context: context,
                  item: item,
                );
              }
            }

            final minumanStartIndex =
                makananItems.isNotEmpty ? makananItems.length + 1 : 0;

            if (minumanItems.isNotEmpty && index == minumanStartIndex) {
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
            } else if (minumanItems.isNotEmpty && index > minumanStartIndex) {
              final minumanIndex = index - (minumanStartIndex + 1);
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
    );
  }
}
