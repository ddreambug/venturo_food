import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:venturo_food/configs/themes/main_color.dart';
import 'package:venturo_food/features/main_menu/sub_features/checkout/controllers/checkout_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:venturo_food/shared/widgets/styles/google_text_style.dart';

class VoucherCard extends StatelessWidget {
  const VoucherCard({
    required this.voucher,
    super.key,
  });

  final Map<String, dynamic> voucher;
  
  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(20.r),
      onTap: () {
        Get.toNamed(
          '/detail-voucher',
          arguments: voucher,
        );
      },
      child: Container(
        height: 216.w,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r),
          color: const Color.fromARGB(77, 193, 193, 193),
        ),
        child: Stack(
          children: [
            // Promo description and checkbox
            Positioned(
              top: -8.w,
              left: 15.w,
              right: -5.w,
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      voucher['promo_description'],
                      style: GoogleTextStyle.w500.copyWith(fontSize: 16.sp),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                  Obx(() {
                    final usedPromo = CheckoutController.to.voucherValue.keys;

                    return Transform.scale(
                      scale: 14 / Checkbox.width,
                      child: Checkbox(
                        activeColor: Colors.transparent,
                        checkColor: MainColor.primary,
                        side: const BorderSide(width: 2),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.r),
                        ),
                        value: usedPromo.contains(voucher['promo_description']),
                        onChanged: (value) {
                          CheckoutController.to.changeVoucherValue(
                            voucher['promo_description'],
                            voucher['value'],
                          );
                        },
                      ),
                    );
                  })
                ],
              ),
            ),
            // Promo Image
            Positioned(
              bottom: 0,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10).r,
                child: SizedBox(
                  width: 364.w,
                  child: Image.asset(
                    voucher['promo_image'],
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
