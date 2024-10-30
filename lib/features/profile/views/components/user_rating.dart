import 'package:flutter/material.dart';
import 'package:venturo_food/configs/themes/main_color.dart';
import 'package:venturo_food/constants/cores/assets/image_constant.dart';
import 'package:venturo_food/shared/widgets/styles/google_text_style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class UserRating extends StatelessWidget {
  const UserRating({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        height: 60.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.r),
          color: Colors.grey[100],
        ),
        child: Stack(
          children: [
            Positioned(
              top: 22.w,
              child: Image.asset(
                ImageConstant.icPenilaian,
                height: 18.w,
              ),
            ),
            Positioned(
              top: 18.w,
              left: 25.w,
              child: Text(
                'Rating'.tr,
                style: GoogleTextStyle.w600.copyWith(
                  fontSize: 16.sp,
                ),
              ),
            ),
            Positioned(
              top: 15.w,
              right: 0.w,
              child: GestureDetector(
                onTap: () {
                  print('nilai sekarang');
                },
                child: Container(
                  width: 134.w,
                  height: 35.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.r),
                    color: MainColor.primary,
                  ),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Rate Now'.tr,
                      style: GoogleTextStyle.w400.copyWith(
                        fontSize: 14.sp,
                        color: MainColor.white,
                      ),
                    ),
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
