import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:venturo_food/configs/themes/main_color.dart';
import 'package:venturo_food/features/main_menu/sub_features/checkout/controllers/checkout_controller.dart';
import 'package:venturo_food/shared/widgets/styles/google_text_style.dart';

class BuildDiscountDialog extends StatelessWidget {
  const BuildDiscountDialog({super.key});

  @override
  Widget build(BuildContext context) {
    var discountList = CheckoutController.to.discounts;
    return Center(
      child: Container(
        height: 280.h,
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
              "Discount Info".tr,
              style: GoogleTextStyle.w700.copyWith(
                fontSize: 22.sp,
                color: MainColor.primary,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 25.w),
            ListView.builder(
              shrinkWrap: true,
              itemCount: discountList.length,
              itemBuilder: (context, index) {
                var discount = discountList[index];
                return Row(
                  children: [
                    Text(
                      discount['promo_description'].toString(),
                      style: GoogleTextStyle.w400.copyWith(fontSize: 16.sp),
                    ),
                    const Spacer(),
                    Text('${discount['value'].toString()}%'),
                    Obx(() {
                      var controllerValue =
                          CheckoutController.to.discountValue.value;

                      return Checkbox(
                        value: discount['value'] == controllerValue,
                        onChanged: (bool? value) {
                          int value = discount['value'] as int;
                          CheckoutController.to
                              .changeDiscountValue(value.toDouble());
                        },
                      );
                    }),
                  ],
                );
              },
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
                  'Ok'.tr,
                  style: GoogleTextStyle.w700.copyWith(
                    color: MainColor.white,
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
