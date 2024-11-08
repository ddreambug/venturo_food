import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:venturo_food/constants/cores/assets/image_constant.dart';
import 'package:venturo_food/features/main_menu/views/components/custom_bottomnavbar.dart';
import 'package:venturo_food/features/profile/views/components/user_device_info.dart';
import 'package:venturo_food/features/profile/views/components/user_logout_button.dart';
import 'package:venturo_food/features/profile/views/components/user_rating.dart';
import 'package:venturo_food/features/profile/views/components/profile_app_bar.dart';
import 'package:venturo_food/features/profile/views/components/user_avatar.dart';
import 'package:venturo_food/features/profile/views/components/user_detail.dart';
import 'package:venturo_food/features/profile/views/components/user_identity.dart';
import 'package:venturo_food/global_controllers/analytics_controller.dart';

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
              const UserAvatar(),
              21.verticalSpacingRadius,

              /// Info KTP
              const UserIdentity(),
              22.verticalSpacingRadius,

              /// Detail Account
              const UserDetail(),
              14.verticalSpacingRadius,

              /// Rating
              const UserRating(),
              22.verticalSpacingRadius,

              /// Device Info
              const UserDeviceInfo(),

              /// Logout Button
              const UserLogoutButton(),
            ],
          ),
        ),
      ),
    );
  }
}
