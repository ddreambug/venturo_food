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
        final snackItems = CheckoutController.to.snackCart;

        return ListView.builder(
          padding: EdgeInsets.symmetric(horizontal: 25.w),
          itemCount: CheckoutController.to.getItemCount(),
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

            /// Minuman
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
              if (minumanIndex < minumanItems.length) {
                final item = minumanItems[minumanIndex];
                return CheckoutCart(
                  context: context,
                  item: item,
                );
              }
            }

            /// Snack
            final snackStartIndex =
                (makananItems.isNotEmpty ? makananItems.length + 1 : 0) +
                    (minumanItems.isNotEmpty ? minumanItems.length + 1 : 0);

            if (snackItems.isNotEmpty && index == snackStartIndex) {
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
            } else if (snackItems.isNotEmpty && index > snackStartIndex) {
              final snackIndex = index - (snackStartIndex + 1);
              if (snackIndex < snackItems.length) {
                final item = snackItems[snackIndex];
                return CheckoutCart(
                  context: context,
                  item: item,
                );
              }
            }

            return const SizedBox.shrink();
          },
        );
      },
    );
  }
}
