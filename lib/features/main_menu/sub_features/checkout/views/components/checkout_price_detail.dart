import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/ep.dart';
import 'package:iconify_flutter/icons/la.dart';
import 'package:venturo_food/configs/themes/main_color.dart';
import 'package:venturo_food/constants/cores/assets/image_constant.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:venturo_food/features/main_menu/sub_features/checkout/controllers/checkout_controller.dart';
import 'package:intl/intl.dart';

class CheckoutPriceDetail extends StatelessWidget {
  const CheckoutPriceDetail({
    super.key,
    required this.cartItem,
  });

  final RxList<Map<String, dynamic>> cartItem;
  @override
  Widget build(BuildContext context) {
    num totalHarga = CheckoutController.to.totalHarga;

    return Expanded(
      child: Container(
        margin: EdgeInsets.only(top: 5.h),
        decoration: const BoxDecoration(
          color: Color.fromARGB(102, 211, 211, 211),
          borderRadius: BorderRadiusDirectional.vertical(
            top: Radius.circular(30),
          ),
        ),
        width: double.infinity,
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Total Row
              _buildTotalRow(totalHarga),
              const Divider(),

              // Discount Row
              _buildDiscountRow(totalHarga),
              const Divider(),

              // Voucher Row
              _buildVoucherRow(),
              const Divider(),

              // Payment Row
              _buildPaymentRow(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTotalRow(num totalHarga) {
    final formatCurrency =
        NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text.rich(
          TextSpan(
            text: 'Total Pesanan ',
            style: Get.textTheme.bodyMedium!.copyWith(
              fontWeight: FontWeight.w900,
              fontSize: 16.sp,
            ),
            children: [
              TextSpan(
                text: '(${cartItem.length} Menu) :',
                style: Get.textTheme.labelSmall!.copyWith(
                  fontWeight: FontWeight.w300,
                ),
              ),
            ],
          ),
        ),
        const Spacer(),
        Text(
          formatCurrency.format(totalHarga),
          style: Get.textTheme.bodyMedium!.copyWith(
            color: MainColor.primary,
            fontSize: 14.sp,
            fontWeight: FontWeight.w900,
          ),
          textAlign: TextAlign.end,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  Widget _buildDiscountRow(num totalHarga) {
    final formatCurrency =
        NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);
    final double discount = (20 / 100) * totalHarga;
    return GestureDetector(
      onTap: () {
        _buildDiscountDialog();
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(ImageConstant.discountIcon, width: 22.w),
          SizedBox(width: 8.w),
          SizedBox(
            width: 230.w,
            child: Text(
              'Diskon 20%',
              style: Get.textTheme.bodyMedium!.copyWith(
                fontWeight: FontWeight.w900,
                fontSize: 16.sp,
              ),
            ),
          ),
          const Spacer(),
          Text(
            formatCurrency.format(discount),
            style: Get.textTheme.titleSmall!.copyWith(
              color: MainColor.danger,
              fontSize: 14.sp,
              fontWeight: FontWeight.w100,
            ),
            textAlign: TextAlign.end,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Iconify(Ep.arrow_right_bold, size: 14.w, color: MainColor.grey),
        ],
      ),
    );
  }

  Widget _buildVoucherRow() {
    return GestureDetector(
      onTap: () {
        Get.toNamed('/voucher');
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(ImageConstant.voucherIcon, width: 22.w),
          SizedBox(width: 8.w),
          Text(
            'Voucher',
            style: Get.textTheme.bodyMedium!.copyWith(
              fontWeight: FontWeight.w900,
              fontSize: 16.sp,
            ),
          ),
          const Spacer(),
          SizedBox(
            width: 230.w,
            child: Text(
              'Pilih Voucher',
              style: Get.textTheme.titleSmall!.copyWith(
                color: MainColor.black,
                fontSize: 14.sp,
                fontWeight: FontWeight.w100,
              ),
              textAlign: TextAlign.end,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Iconify(Ep.arrow_right_bold, size: 14.w, color: MainColor.grey),
        ],
      ),
    );
  }

  Widget _buildPaymentRow() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Iconify(La.coins,
            color: const Color.fromRGBO(44, 139, 164, 1), size: 24.w),
        SizedBox(width: 8.w),
        Text(
          'Pembayaran',
          style: Get.textTheme.bodyMedium!.copyWith(
            fontWeight: FontWeight.w900,
            fontSize: 16.sp,
          ),
        ),
        const Spacer(),
        Text(
          'Pay Later',
          style: Get.textTheme.titleSmall!.copyWith(
            color: MainColor.black,
            fontSize: 14.sp,
            fontWeight: FontWeight.w100,
          ),
          textAlign: TextAlign.end,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  void _buildDiscountDialog() {
    Get.dialog(
      Center(
        child: Container(
          height: 205.h,
          width: 340.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: MainColor.white,
          ),
          padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Info Diskon",
                style: Get.textTheme.titleMedium!.copyWith(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.w900,
                  color: MainColor.primary,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 25.w),
              Row(
                children: [
                  Text(
                    'Mengisi Survey',
                    style: Get.textTheme.labelMedium!.copyWith(fontSize: 16.sp),
                  ),
                  const Spacer(),
                  const Text('10%'),
                ],
              ),
              Row(
                children: [
                  Text(
                    'Terlambat <3x',
                    style: Get.textTheme.labelMedium!.copyWith(fontSize: 16.sp),
                  ),
                  const Spacer(),
                  const Text('10%'),
                ],
              ),
              SizedBox(height: 25.w),
              SizedBox(
                height: 40.h,
                width: 200.w,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: MainColor.primary,
                    side: BorderSide(
                      color: Colors.black.withOpacity(0.5),
                      width: 0.5,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0).r,
                    ),
                  ),
                  onPressed: () {
                    Get.back();
                  },
                  child: Text(
                    'Oke',
                    style: Get.textTheme.bodyMedium!
                        .copyWith(color: MainColor.white),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}