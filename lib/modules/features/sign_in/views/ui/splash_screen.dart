import 'package:flutter/material.dart';
import 'package:venturo_food/configs/themes/main_color.dart';
import 'package:venturo_food/constants/cores/assets/image_constant.dart';
import 'package:venturo_food/modules/global_controllers/analytics_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AnalyticsController().setCurrentScreen(screenName: 'Splash Screen');

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Hero(
              tag: 'splashImage',
              child: Image.asset(
                ImageConstant.logo,
                width: 200.r,
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(height: 20.r),
            const CircularProgressIndicator(color: MainColor.primary)
          ],
        ),
      ),
    );
  }
}
