import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:venturo_food/configs/themes/main_color.dart';
import 'package:venturo_food/constants/cores/assets/image_constant.dart';
import 'package:venturo_food/features/no_connection/controllers/no_internet_controller.dart';

class NoInternet extends StatelessWidget {
  const NoInternet({super.key});

  @override
  Widget build(BuildContext context) {
    final noInternetController = Get.find<NoInternetController>();

    Widget content = Padding(
      padding: const EdgeInsets.all(20.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.wifi_off_sharp,
              size: 100,
            ),
            const SizedBox(height: 20),
            const Text(
              'OOPS!\nTidak ada koneksi Internet',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: MainColor.primary, fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 30,
              child: ElevatedButton(
                  onPressed: () {
                    Get.offNamed('/login');
                  },
                  child: const Text('Coba Lagi')),
            ),
          ],
        ),
      ),
    );

    return Scaffold(
      body: Stack(
        children: [
          Obx(() {
            return AnimatedPositioned(
              curve: Curves.ease,
              top: noInternetController.animationPlay.value ? 20 : 50,
              left: 0,
              right: 0,
              duration: const Duration(seconds: 4),
              child: Center(
                child: Image.asset(
                  ImageConstant.patternBackground,
                  width: 260,
                  color: MainColor.primary,
                ),
              ),
            );
          }),
          content
        ],
      ),
    );
  }
}
