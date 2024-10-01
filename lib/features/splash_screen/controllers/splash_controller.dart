import 'package:get/get.dart';
import 'package:venturo_food/global_controllers/global_controller.dart';

class SplashController extends GetxController {
  static SplashController get to => Get.find();

  @override
  void onInit() async {
    super.onInit();
    await GlobalController.to.checkConnection();

    if (GlobalController.to.isConnect.value) {
      _navigateToLogin();
    }
  }

  void _navigateToLogin() {
    Future.delayed(const Duration(seconds: 1), () {
      Get.offNamed('/login');
    });
  }
}
