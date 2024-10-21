import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/ic.dart';
import 'package:venturo_food/configs/themes/main_color.dart';
import 'package:venturo_food/features/main_menu/sub_features/order/controllers/order_controller.dart';
import 'package:venturo_food/shared/widgets/styles/google_text_style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrderStatus extends StatelessWidget {
  const OrderStatus({super.key});

  @override
  Widget build(BuildContext context) {
    final orderItem = OrderController.to.selectedOrder;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(
            bottom: 7.w,
            top: 3.w,
          ),
          child: GestureDetector(
            child: Text(
              'Pesanan Kamu Sedang Disiapkan',
              style: GoogleTextStyle.w600.copyWith(
                fontSize: 16.sp,
                color: Colors.black,
              ),
            ),
          ),
        ),
        SizedBox(height: 10.w),
        Padding(
          padding: EdgeInsets.only(left: 15.w, right: 28.w),
          child: Row(
            children: [
              if (orderItem['status'] == 0) ...{
                Iconify(
                  Ic.baseline_check_circle,
                  size: 22.h,
                  color: MainColor.primary,
                ),
              } else ...{
                CircleAvatar(
                  backgroundColor: const Color.fromARGB(255, 150, 150, 150),
                  radius: 5.w,
                ),
              },
              Expanded(
                child: Divider(
                  indent: 10.w,
                  endIndent: 10.w,
                  thickness: 3.h,
                ),
              ),
              if (orderItem['status'] == 1) ...{
                Iconify(
                  Ic.baseline_check_circle,
                  size: 22.h,
                  color: MainColor.primary,
                ),
              } else ...{
                CircleAvatar(
                  backgroundColor: const Color.fromARGB(255, 150, 150, 150),
                  radius: 5.w,
                ),
              },
              Expanded(
                child: Divider(
                  indent: 10.w,
                  endIndent: 10.w,
                  thickness: 3.h,
                ),
              ),
              if (orderItem['status'] == 2) ...{
                Iconify(
                  Ic.baseline_check_circle,
                  size: 22.h,
                  color: MainColor.primary,
                ),
              } else ...{
                CircleAvatar(
                  backgroundColor: const Color.fromARGB(255, 150, 150, 150),
                  radius: 5.w,
                ),
              },
            ],
          ),
        ),
        Row(
          children: [
            SizedBox(
              width: 60.w,
              height: 35.w,
              child: Text(
                'Pesanan Diterima',
                style: GoogleTextStyle.w400.copyWith(fontSize: 12.w),
                textAlign: TextAlign.center,
              ),
            ),
            const Spacer(),
            SizedBox(
              width: 60.w,
              height: 35.w,
              child: Text(
                'Silahkan Diambil',
                style: GoogleTextStyle.w400.copyWith(fontSize: 12.w),
                textAlign: TextAlign.center,
              ),
            ),
            const Spacer(),
            SizedBox(
              width: 60.w,
              height: 35.w,
              child: Text(
                'Pesanan Selesai',
                style: GoogleTextStyle.w400.copyWith(fontSize: 12.w),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        )
      ],
    );
  }
}
