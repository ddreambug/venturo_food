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
import 'package:venturo_food/features/main_menu/sub_features/checkout/views/components/build_discount_dialog.dart';
import 'package:venturo_food/shared/widgets/styles/google_text_style.dart';

class CheckoutPriceDetail extends StatelessWidget {
  const CheckoutPriceDetail({
    super.key,
    required this.cartItem,
  });

  final RxList<Map<String, dynamic>> cartItem;
  @override
  Widget build(BuildContext context) {
    final formatCurrency = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    );

    return Expanded(
      child: Obx(
        () {
          var isUsingVoucher = CheckoutController.to.voucherValue.isNotEmpty;
          num totalHarga = CheckoutController.to.totalHarga;

          return Container(
            margin: isUsingVoucher
                ? EdgeInsets.only(top: 50.h)
                : EdgeInsets.only(top: 5.h),
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
                  /// Total Row
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text.rich(
                        TextSpan(
                          text: 'Total Orders'.tr,
                          style: GoogleTextStyle.w700.copyWith(
                            fontSize: 16.sp,
                          ),
                          children: [
                            TextSpan(
                              text: '(${cartItem.length} Menu) :',
                              style: GoogleTextStyle.w400.copyWith(
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      Text(
                        formatCurrency.format(totalHarga),
                        style: GoogleTextStyle.w600.copyWith(
                          color: MainColor.primary,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w900,
                        ),
                        textAlign: TextAlign.end,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                  const Divider(),

                  /// Discount Row
                  if (!isUsingVoucher) ...{
                    Obx(
                      () {
                        final discountValue =
                            CheckoutController.to.discountValue.toInt();
                        final double discount =
                            (discountValue / 100) * totalHarga;

                        if (CheckoutController.to.voucherValue.isEmpty) {
                          return Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Get.dialog(const BuildDiscountDialog());
                                },
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Image.asset(ImageConstant.discountIcon,
                                        width: 22.w),
                                    SizedBox(width: 8.w),
                                    SizedBox(
                                      width: 220.w,
                                      child: Row(
                                        children: [
                                          Text(
                                            'Discount '.tr,
                                            style:
                                                GoogleTextStyle.w700.copyWith(
                                              fontSize: 16.sp,
                                            ),
                                          ),
                                          Text(
                                            '$discountValue',
                                            style:
                                                GoogleTextStyle.w700.copyWith(
                                              fontSize: 16.sp,
                                            ),
                                          ),
                                          Text(
                                            '%',
                                            style:
                                                GoogleTextStyle.w700.copyWith(
                                              fontSize: 16.sp,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const Spacer(),
                                    Text(
                                      formatCurrency.format(discount),
                                      style: GoogleTextStyle.w400.copyWith(
                                        color: MainColor.danger,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w100,
                                      ),
                                      textAlign: TextAlign.end,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Iconify(Ep.arrow_right_bold,
                                        size: 14.w, color: MainColor.grey),
                                  ],
                                ),
                              ),
                              const Divider(),
                            ],
                          );
                        } else {
                          return const SizedBox.shrink();
                        }
                      },
                    ),
                  },

                  // Voucher Row
                  GestureDetector(
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
                          style: GoogleTextStyle.w700.copyWith(
                            fontSize: 16.sp,
                          ),
                        ),
                        const Spacer(),
                        SizedBox(
                          width: 230.w,
                          child: Obx(
                            () {
                              var voucherAmount = CheckoutController
                                      .to.voucherValue.values.isNotEmpty
                                  ? CheckoutController
                                      .to.voucherValue.values.first
                                  : 'Choose Voucher'.tr;

                              return Text(
                                voucherAmount != 'Choose Voucher'.tr
                                    ? formatCurrency.format(voucherAmount)
                                    : voucherAmount.toString(),
                                style: GoogleTextStyle.w400.copyWith(
                                  color: CheckoutController
                                          .to.voucherValue.values.isNotEmpty
                                      ? MainColor.danger
                                      : MainColor.black,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w100,
                                ),
                                textAlign: TextAlign.end,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              );
                            },
                          ),
                        ),
                        Iconify(Ep.arrow_right_bold,
                            size: 14.w, color: MainColor.grey),
                      ],
                    ),
                  ),
                  const Divider(),

                  // Payment Row
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Iconify(
                        La.coins,
                        color: const Color.fromRGBO(44, 139, 164, 1),
                        size: 24.w,
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        'Payment'.tr,
                        style: GoogleTextStyle.w700.copyWith(
                          fontSize: 16.sp,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        'Pay Later',
                        style: GoogleTextStyle.w400.copyWith(
                          color: MainColor.black,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w100,
                        ),
                        textAlign: TextAlign.end,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
