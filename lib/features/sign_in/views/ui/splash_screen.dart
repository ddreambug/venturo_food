import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:venturo_food/configs/themes/main_color.dart';
import 'package:venturo_food/shared/controllers/analytics_controller.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AnalyticsController().setCurrentScreen('Splash Screen');

    Future.delayed(const Duration(seconds: 3), () {
      Get.offNamed('/login');
    });

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Hero(
              tag: 'splashImage',
              child: Image.asset(
                'lib/assets/images/ic_splash.png',
                width: 150, // Set consistent width
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 20),
            const CircularProgressIndicator(color: MainColor.primary)
          ],
        ),
      ),
    );
  }
}
