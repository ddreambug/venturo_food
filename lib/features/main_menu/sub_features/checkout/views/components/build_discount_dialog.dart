import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:venturo_food/configs/themes/main_color.dart';
import 'package:venturo_food/shared/widgets/styles/google_text_style.dart';

class BuildDiscountDialog extends StatelessWidget {
  const BuildDiscountDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
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
              "Discount Info".tr,
              style: GoogleTextStyle.w700.copyWith(
                fontSize: 22.sp,
                color: MainColor.primary,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 25.w),
            Row(
              children: [
                Text(
                  'Fill Survey'.tr,
                  style: GoogleTextStyle.w400.copyWith(fontSize: 16.sp),
                ),
                const Spacer(),
                const Text('10%'),
              ],
            ),
            Row(
              children: [
                Text(
                  'Late <3x'.tr,
                  style: GoogleTextStyle.w400.copyWith(fontSize: 16.sp),
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
                  'Ok'.tr,
                  style: GoogleTextStyle.w700.copyWith(
                    color: MainColor.white,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
