import 'package:get/get.dart';
import 'package:venturo_food/features/splash_screen/controllers/splash_controller.dart';

class SplashBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(
      SplashController(),
    );
  }
}
