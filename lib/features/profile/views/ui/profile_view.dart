import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import 'package:get/get.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/uiw.dart';
import 'package:venturo_food/configs/themes/main_color.dart';
import 'package:venturo_food/constants/cores/assets/image_constant.dart';
import 'package:venturo_food/features/main_menu/views/components/custom_bottomnavbar.dart';
import 'package:venturo_food/features/profile/controllers/profile_controller.dart';
import 'package:venturo_food/features/profile/views/components/profile_app_bar.dart';
import 'package:venturo_food/global_controllers/analytics_controller.dart';
import 'package:venturo_food/shared/widgets/styles/google_text_style.dart';

import '../components/tile_option.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});
  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  @override
  Widget build(BuildContext context) {
    AnalyticsController.to.logCurrentScreen(screenName: 'Profile Screen');

    return SafeArea(
      child: Scaffold(
        appBar: const ProfileAppBar(),
        bottomNavigationBar: const CustomBottomnavbar(),
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(ImageConstant.patternBackground),
              fit: BoxFit.fitHeight,
              opacity: 0.4,
            ),
          ),
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 16.r, vertical: 25.r),
            children: [
              /// Profile Icon
              Center(
                child: Container(
                  width: 170.r,
                  height: 170.r,
                  clipBehavior: Clip.antiAlias,
                  decoration: const BoxDecoration(shape: BoxShape.circle),
                  child: Stack(
                    children: [
                      Obx(
                        () => GestureDetector(
                          child: Conditional.single(
                            context: context,
                            conditionBuilder: (context) =>
                                ProfileController.to.imageFile != null,
                            widgetBuilder: (context) => Image.file(
                              ProfileController.to.imageFile!,
                              width: 170.r,
                              height: 170.r,
                              fit: BoxFit.cover,
                            ),
                            fallbackBuilder: (context) => Image.asset(
                              ImageConstant.bgProfile,
                              width: 170.r,
                              height: 170.r,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Material(
                          color: MainColor.primary,
                          child: InkWell(
                            onTap: ProfileController.to.pickImage,
                            child: Container(
                              width: double.infinity,
                              padding: EdgeInsets.only(top: 5.r, bottom: 8.r),
                              child: Text(
                                "Change".tr,
                                style: GoogleTextStyle.w400.copyWith(
                                  fontSize: 12.sp,
                                  color: MainColor.white,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              21.verticalSpacingRadius,

              // Info KTP
              Obx(
                () => Conditional.single(
                  context: context,
                  conditionBuilder: (context) =>
                      ProfileController.to.isVerif.value != false,
                  widgetBuilder: (context) => Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Iconify(
                        Uiw.verification,
                        color: MainColor.primary,
                        size: 22.w,
                      ),
                      7.horizontalSpaceRadius,
                      Text(
                        'Your have verified your ID card'.tr,
                        style: GoogleTextStyle.w400.copyWith(
                          color: MainColor.primary,
                          fontSize: 14.sp,
                        ),
                      ),
                    ],
                  ),
                  fallbackBuilder: (context) => InkWell(
                    onTap: ProfileController.to.pickFile,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Iconify(
                          Uiw.verification,
                          color: MainColor.primary,
                          size: 22.w,
                        ),
                        7.horizontalSpaceRadius,
                        Text(
                          'Verify your ID card now!'.tr,
                          style: GoogleTextStyle.w400.copyWith(
                            color: MainColor.primary,
                            fontSize: 14.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              22.verticalSpacingRadius,
              Padding(
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
                              message:
                                  ProfileController.to.user.value['nama'] ??
                                      '-',
                              messageStyle: GoogleTextStyle.w400.copyWith(
                                fontSize: 16.sp,
                                color: MainColor.black,
                              ),
                              onTap: () {
                                ProfileController.to.updateProfileName();
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
                              message: ProfileController
                                      .to.user.value['tgl_lahir'] ??
                                  '-',
                              messageStyle: GoogleTextStyle.w400.copyWith(
                                fontSize: 16.sp,
                                color: MainColor.black,
                              ),
                              onTap: () {
                                ProfileController.to.updateBirthDate();
                              },
                            ),
                          ),
                          Divider(color: Colors.black45, height: 0.5.h),
                          TileOption(
                            title: 'Phone number'.tr,
                            titleStyle: GoogleTextStyle.w600.copyWith(
                              fontSize: 16.sp,
                              color: MainColor.black,
                            ),
                            message: '-',
                            messageStyle: GoogleTextStyle.w400.copyWith(
                              fontSize: 16.sp,
                              color: MainColor.black,
                            ),
                            onTap: () {},
                          ),
                          Divider(color: Colors.black45, height: 0.5.h),
                          TileOption(
                            title: 'Email'.tr,
                            titleStyle: GoogleTextStyle.w600.copyWith(
                              fontSize: 16.sp,
                              color: MainColor.black,
                            ),
                            message: 'user@email.com',
                            messageStyle: GoogleTextStyle.w400.copyWith(
                              fontSize: 16.sp,
                              color: MainColor.black,
                            ),
                            onTap: () {},
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
                            onTap: () {},
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
              ),
              14.verticalSpacingRadius,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  height: 60.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.r),
                    color: Colors.grey[100],
                  ),
                  child: Stack(
                    // Center the contents inside the Container
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
              ),

              22.verticalSpacingRadius,
              Padding(
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
                              onTap: () {},
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
                              onTap: () {},
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
