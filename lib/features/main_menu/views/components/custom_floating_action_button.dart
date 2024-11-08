import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:venturo_food/configs/themes/main_color.dart';
import 'package:venturo_food/features/main_menu/sub_features/checkout/controllers/checkout_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:venturo_food/shared/widgets/styles/google_text_style.dart';

class CustomFloatingActionButton extends StatelessWidget {
  const CustomFloatingActionButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed('/detail-pesanan');
      },
      child: Obx(
        () {
          var itemCount = CheckoutController.to.cart.length;

          if (itemCount == 0) return const SizedBox.shrink();

          return Stack(
            children: [
              Positioned(
                bottom: 0.w,
                right: 0.w,
                child: CircleAvatar(
                  radius: 30.r,
                  backgroundColor: MainColor.primary,
                  child: Icon(
                    Icons.shopping_cart,
                    size: 35.r,
                  ),
                ),
              ),
              Positioned(
                bottom: 40.w,
                right: 0.w,
                child: CircleAvatar(
                  radius: 12.r,
                  backgroundColor: Colors.red,
                  child: Text(
                    itemCount.toString(),
                    style: GoogleTextStyle.w500.copyWith(fontSize: 14.sp),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
