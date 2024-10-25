import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:venturo_food/configs/themes/main_color.dart';
import 'package:venturo_food/features/main_menu/sub_features/order/controllers/order_controller.dart';
import 'package:venturo_food/shared/widgets/styles/google_text_style.dart';

class TotalPriceInfo extends StatelessWidget {
  const TotalPriceInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color.fromARGB(112, 231, 231, 231),
        borderRadius: BorderRadiusDirectional.vertical(
          top: Radius.circular(30),
        ),
      ),
      height: 55.w,
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30.w),
        child: Row(
          children: [
            Text(
              'Total Pesanan',
              style: GoogleTextStyle.w700.copyWith(fontSize: 18.sp),
            ),
            const Spacer(),
            Text(
              OrderController.to.getFinalSpending(),
              style: GoogleTextStyle.w700.copyWith(
                fontSize: 18.sp,
                color: MainColor.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
