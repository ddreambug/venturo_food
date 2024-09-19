import 'package:get/get.dart';
import 'package:venturo_food/modules/features/sign_in/controllers/splash_controller.dart';

class SplashBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(
      SplashController(),
    );
  }
}
