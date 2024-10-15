import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:venturo_food/configs/themes/main_color.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/material_symbols.dart';
import 'package:iconify_flutter/icons/fa.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:venturo_food/features/main_menu/sub_features/checkout/controllers/checkout_controller.dart';
import 'package:venturo_food/shared/widgets/styles/google_text_style.dart';

class CheckoutBottomNavbar extends StatelessWidget {
  const CheckoutBottomNavbar({
    super.key,
    this.checkoutNavbarType = 'detail',
    this.voucher,
  });

  final String checkoutNavbarType;
  final Map<String, dynamic>? voucher;

  @override
  Widget build(BuildContext context) {
    final formatCurrency =
        NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);

    return Container(
      padding: EdgeInsets.only(left: 20.w, right: 10.w),
      width: double.infinity,
      height: checkoutNavbarType == 'voucher' ? 120.w : 66.w,
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
                  style: GoogleTextStyle.w400.copyWith(fontSize: 12.sp),
                ),
                Obx(() {
                  final finalHarga = CheckoutController.to.finalHarga.value;
                  return Text(
                    formatCurrency.format(finalHarga),
                    style: GoogleTextStyle.w600.copyWith(
                      fontSize: 20.sp,
                      color: MainColor.primary,
                      fontWeight: FontWeight.w900,
                    ),
                  );
                }),
              ],
            ),
            const Spacer(),
            SizedBox(
              height: 42.w,
              width: 200.w,
              child: OutlinedButton(
                onPressed: () {
                  CheckoutController.to.verify();
                  print('pesan sekarang pressed');
                },
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.black, width: 0.5),
                  backgroundColor: MainColor.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text(
                  'Pesan Sekarang',
                  style: GoogleTextStyle.w600.copyWith(
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
              height: 90.w,
              width: 377.w,
              child: Column(
                children: [
                  Row(
                    children: [
                      Iconify(
                        MaterialSymbols.check_circle_outline_rounded,
                        size: 16.w,
                        color: MainColor.primary,
                      ),
                      SizedBox(width: 1.w),
                      SizedBox(
                        width: 360.w,
                        child: Text.rich(
                          TextSpan(
                            text:
                                'Penggunaan voucher tidak dapat digabung dengan ',
                            style:
                                GoogleTextStyle.w400.copyWith(fontSize: 13.sp),
                            children: [
                              TextSpan(
                                text: 'discount employee reward program',
                                style: GoogleTextStyle.w700.copyWith(
                                  color: MainColor.primary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 4.w),
                  SizedBox(
                    width: double.infinity,
                    height: 42.h,
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
                        style: GoogleTextStyle.w600.copyWith(
                          fontSize: 18.sp,
                          color: MainColor.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          } else ...{
            SizedBox(
              height: 42.w,
              width: 377.w,
              child: OutlinedButton(
                onPressed: () {
                  if (checkoutNavbarType == 'detail_voucher') {
                    CheckoutController.to.changeVoucherValue(
                      voucher!['promo_description'],
                      voucher!['value'],
                    );
                    Get.back();

                    // Get.until((route) => Get.currentRoute == '/detail-pesanan');
                  } else {
                    Get.back();
                  }
                },
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.black, width: 0.5),
                  backgroundColor: MainColor.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text(
                  checkoutNavbarType == 'detail_voucher'
                      ? 'Pakai Voucher'
                      : 'Simpan',
                  style: GoogleTextStyle.w600.copyWith(
                    fontSize: 14.sp,
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
