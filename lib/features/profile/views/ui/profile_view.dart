import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import 'package:get/get.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/heroicons.dart';
import 'package:venturo_food/configs/themes/main_color.dart';
import 'package:venturo_food/constants/cores/assets/image_constant.dart';
import 'package:venturo_food/features/profile/controllers/profile_controller.dart';
import 'package:venturo_food/global_controllers/analytics_controller.dart';

import '../components/tile_option.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});
  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  @override
  Widget build(BuildContext context) {
    AnalyticsController.to.logCurrentScreen(screenName: 'Profile Screen');

    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Profile'.tr,
          style: Get.textTheme.titleMedium,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30.r),
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(ImageConstant.patternBackground),
              fit: BoxFit.fitHeight,
              alignment: Alignment.center),
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
                      () => Conditional.single(
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
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Material(
                        color: MainColor.primary,
                        child: InkWell(
                          onTap: ProfileController.to.pickImage,
                          child: Container(
                            width: double.infinity,
                            padding: EdgeInsets.only(top: 10.r, bottom: 15.r),
                            child: Text(
                              "Change".tr,
                              style: Get.textTheme.labelMedium!
                                  .copyWith(color: Colors.white),
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
                    Icon(
                      Icons.check,
                      color: Colors.green,
                      size: 20.r,
                    ),
                    7.horizontalSpaceRadius,
                    Text(
                      ' Your have verified your ID card'.tr,
                      style: Get.textTheme.labelMedium!
                          .copyWith(color: Colors.blue),
                    )
                  ],
                ),
                fallbackBuilder: (context) => InkWell(
                  onTap: ProfileController.to.pickFile,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Iconify(Heroicons.identification_solid),
                      7.horizontalSpaceRadius,
                      Text(
                        'Verify your ID card now!'.tr,
                        style: Get.textTheme.labelMedium!
                            .copyWith(color: Colors.blue),
                      )
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
                      style: Get.textTheme.titleMedium!
                          .copyWith(color: Theme.of(context).primaryColor),
                    ),
                  ),
                  14.verticalSpacingRadius,
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.r),
                      color: Colors.grey[100],
                    ),
                    child: Column(
                      children: [
                        Obx(() => TileOption(
                              title: 'Name'.tr,
                              message:
                                  ProfileController.to.user.value['nama'] ??
                                      '-',
                              onTap: () {
                                ProfileController.to.updateProfileName();
                              },
                            )),
                        Divider(color: Colors.black45, height: 0.5.h),
                        Obx(() => TileOption(
                              title: 'Birth date'.tr,
                              message: ProfileController
                                      .to.user.value['tgl_lahir'] ??
                                  '-',
                              onTap: () {
                                ProfileController.to.updateBirthDate();
                              },
                            )),
                        Divider(color: Colors.black45, height: 0.5.h),
                        TileOption(
                          title: 'Phone number'.tr,
                          message: '-',
                          onTap: () {},
                        ),
                        Divider(color: Colors.black45, height: 0.5.h),
                        TileOption(
                          title: 'Email'.tr,
                          message: 'user@email.com',
                          onTap: () {},
                        ),
                        Divider(color: Colors.black45, height: 0.5.h),
                        TileOption(
                          title: 'Change PIN'.tr,
                          message: '******',
                          onTap: () {},
                        ),
                        Divider(color: Colors.black45, height: 0.5.h),
                        Obx(
                          () => TileOption(
                            title: 'Change language'.tr,
                            message: ProfileController.to.currentLang.value,
                            onTap: ProfileController.to.updateLanguage,
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
    );
  }
}
