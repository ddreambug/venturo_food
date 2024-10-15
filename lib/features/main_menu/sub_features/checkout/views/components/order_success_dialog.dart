import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:venturo_food/constants/cores/assets/image_constant.dart';
import 'package:venturo_food/shared/widgets/styles/google_text_style.dart';

class OrderSuccessDialog extends StatelessWidget {
  const OrderSuccessDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.r),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 149.w,
            width: 151.w,
            child: SvgPicture.asset(ImageConstant.orderCompleteSvg),
          ),
          SizedBox(height: 15.w),
          Text(
            'Pesanan Sedang Disiapkan'.tr,
            style: GoogleTextStyle.w500.copyWith(fontSize: 22.sp),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 10.w),
          Text.rich(
            TextSpan(children: [
              TextSpan(
                text: 'Kamu dapat melacak pesananmu di fitur',
                style: GoogleTextStyle.w400.copyWith(
                  color: const Color.fromARGB(255, 147, 146, 146),
                  fontSize: 16.sp,
                ),
              ),
              TextSpan(
                text: ' Pesanan',
                style: GoogleTextStyle.w700.copyWith(
                  color: const Color.fromARGB(255, 147, 146, 146),
                  fontSize: 16.sp,
                ),
              ),
            ]),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 20.w,
          ),
          SizedBox(
            width: 168.w,
            height: 42.w,
            child: ElevatedButton(
              onPressed: () => Get.back(),
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
                side: BorderSide(
                  color: Theme.of(context).primaryColorDark,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50.r),
                ),
                elevation: 2,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Oke',
                    textAlign: TextAlign.center,
                    style: GoogleTextStyle.w700.copyWith(fontSize: 16.sp),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
