import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:venturo_food/configs/themes/main_color.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/fa.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CheckoutBottomNavbar extends StatelessWidget {
  const CheckoutBottomNavbar({
    super.key,
    this.checkoutNavbarType = 'detail',
  });

  final String checkoutNavbarType;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20.w, right: 10.w),
      width: double.infinity,
      height: 66.w,
      decoration: BoxDecoration(
        color: MainColor.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(30.r)),
        boxShadow: const [
          BoxShadow(
            color: Color.fromARGB(68, 24, 24, 24),
            blurRadius: 15,
            spreadRadius: -1,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        children: [
          if (checkoutNavbarType == 'detail') ...{
            Iconify(Fa.shopping_basket, color: MainColor.primary, size: 30.w),
            SizedBox(width: 5.w),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Total Pembayaran',
                  style: Get.textTheme.labelSmall!.copyWith(fontSize: 12.sp),
                ),
                Text(
                  'Rp 110.000',
                  style: Get.textTheme.bodyMedium!.copyWith(
                    fontSize: 20.sp,
                    color: MainColor.primary,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
            const Spacer(),
            SizedBox(
              height: 42.w,
              width: 168.w,
              child: OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.black, width: 0.5),
                  backgroundColor: MainColor.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text(
                  'Pesan Sekarang',
                  style: Get.textTheme.bodyMedium!.copyWith(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w900,
                    color: MainColor.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          } else if (checkoutNavbarType == 'pesanan') ...{
            SizedBox(
              height: 42.w,
              width: 377.w,
              child: OutlinedButton(
                onPressed: () {
                  Get.back();
                },
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.black, width: 0.5),
                  backgroundColor: MainColor.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text(
                  'Simpan',
                  style: Get.textTheme.bodyMedium!.copyWith(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w900,
                    color: MainColor.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          } else if (checkoutNavbarType == 'voucher') ...{
            SizedBox(
              height: 42.w,
              width: 377.w,
              child: OutlinedButton(
                onPressed: () {
                  Get.back();
                },
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.black, width: 0.5),
                  backgroundColor: MainColor.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text(
                  'Oke',
                  style: Get.textTheme.bodyMedium!.copyWith(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w900,
                    color: MainColor.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          }
        ],
      ),
    );
  }
}
