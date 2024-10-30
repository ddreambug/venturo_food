import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:venturo_food/configs/themes/main_color.dart';
import 'package:venturo_food/features/profile/controllers/profile_controller.dart';
import 'package:venturo_food/features/profile/views/components/tile_option.dart';
import 'package:venturo_food/shared/widgets/styles/google_text_style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserDetail extends StatelessWidget {
  const UserDetail({super.key});

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
              'Account info'.tr,
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
                    title: 'Name'.tr,
                    titleStyle: GoogleTextStyle.w600.copyWith(
                      fontSize: 16.sp,
                      color: MainColor.black,
                    ),
                    message: ProfileController.to.user.value['nama'],
                    messageStyle: GoogleTextStyle.w400.copyWith(
                      fontSize: 16.sp,
                      color: MainColor.black,
                    ),
                    onTap: () {
                      ProfileController.to.updateUser('Name'.tr);
                    },
                  ),
                ),
                Divider(color: Colors.black45, height: 0.5.h),
                Obx(
                  () => TileOption(
                    title: 'Birth date'.tr,
                    titleStyle: GoogleTextStyle.w600.copyWith(
                      fontSize: 16.sp,
                      color: MainColor.black,
                    ),
                    message: ProfileController.to.user.value['tanggalLahir'],
                    messageStyle: GoogleTextStyle.w400.copyWith(
                      fontSize: 16.sp,
                      color: MainColor.black,
                    ),
                    onTap: () {
                      ProfileController.to.updateBirthDate(context);
                    },
                  ),
                ),
                Divider(color: Colors.black45, height: 0.5.h),
                Obx(
                  () => TileOption(
                    title: 'Phone number'.tr,
                    titleStyle: GoogleTextStyle.w600.copyWith(
                      fontSize: 16.sp,
                      color: MainColor.black,
                    ),
                    message: ProfileController.to.user.value['nomorTelepon'],
                    messageStyle: GoogleTextStyle.w400.copyWith(
                      fontSize: 16.sp,
                      color: MainColor.black,
                    ),
                    onTap: () {
                      ProfileController.to.updateUser('Phone number'.tr);
                    },
                  ),
                ),
                Divider(color: Colors.black45, height: 0.5.h),
                Obx(
                  () => TileOption(
                    title: 'Email'.tr,
                    titleStyle: GoogleTextStyle.w600.copyWith(
                      fontSize: 16.sp,
                      color: MainColor.black,
                    ),
                    message: ProfileController.to.user.value['alamatEmail'],
                    messageStyle: GoogleTextStyle.w400.copyWith(
                      fontSize: 16.sp,
                      color: MainColor.black,
                    ),
                    onTap: () {
                      ProfileController.to.updateUser('Email'.tr);
                    },
                  ),
                ),
                Divider(color: Colors.black45, height: 0.5.h),
                TileOption(
                  title: 'Change PIN'.tr,
                  titleStyle: GoogleTextStyle.w600.copyWith(
                    fontSize: 16.sp,
                    color: MainColor.black,
                  ),
                  message: '******',
                  messageStyle: GoogleTextStyle.w400.copyWith(
                    fontSize: 16.sp,
                    color: MainColor.black,
                  ),
                  onTap: () {
                    ProfileController.to.updateUser('Change PIN'.tr);
                  },
                ),
                Divider(color: Colors.black45, height: 0.5.h),
                Obx(
                  () => TileOption(
                    title: 'Change language'.tr,
                    titleStyle: GoogleTextStyle.w600.copyWith(
                      fontSize: 16.sp,
                      color: MainColor.black,
                    ),
                    message: ProfileController.to.currentLang.value,
                    messageStyle: GoogleTextStyle.w400.copyWith(
                      fontSize: 16.sp,
                      color: MainColor.black,
                    ),
                    onTap: ProfileController.to.updateLanguage,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
