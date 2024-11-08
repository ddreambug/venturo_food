import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:venturo_food/configs/themes/main_color.dart';
import 'package:venturo_food/features/profile/controllers/profile_controller.dart';
import 'package:venturo_food/features/profile/views/components/tile_option.dart';
import 'package:venturo_food/shared/widgets/styles/google_text_style.dart';

class UserDeviceInfo extends StatelessWidget {
  const UserDeviceInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 20.w),
            child: Text(
              'Other info'.tr,
              style: GoogleTextStyle.w600.copyWith(
                fontSize: 20.sp,
                color: MainColor.primary,
              ),
            ),
          ),
          14.verticalSpacingRadius,
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 20.w,
              vertical: 30.h,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30.r),
              color: Colors.grey[100],
            ),
            child: Column(
              children: [
                Obx(
                  () => TileOption(
                    title: 'Device Info'.tr,
                    titleStyle: GoogleTextStyle.w600.copyWith(
                      fontSize: 16.sp,
                      color: MainColor.black,
                    ),
                    message: ProfileController.to.deviceModel.value,
                    messageStyle: GoogleTextStyle.w400.copyWith(
                      fontSize: 16.sp,
                      color: MainColor.black,
                    ),
                  ),
                ),
                Divider(color: Colors.black45, height: 0.5.h),
                Obx(
                  () => TileOption(
                    title: 'Version'.tr,
                    titleStyle: GoogleTextStyle.w600.copyWith(
                      fontSize: 16.sp,
                      color: MainColor.black,
                    ),
                    message: ProfileController.to.deviceVersion.value,
                    messageStyle: GoogleTextStyle.w400.copyWith(
                      fontSize: 16.sp,
                      color: MainColor.black,
                    ),
                  ),
                ),
                Divider(color: Colors.black45, height: 0.5.h),
                TileOption(
                  title: 'Privacy Policy'.tr,
                  titleStyle: GoogleTextStyle.w600.copyWith(
                    fontSize: 16.sp,
                    color: MainColor.black,
                  ),
                  message: 'Here',
                  messageStyle: GoogleTextStyle.w400.copyWith(
                    fontSize: 16.sp,
                    color: MainColor.black,
                  ),
                  onTap: ProfileController.to.privacyPolicyWebView,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
