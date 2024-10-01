import 'package:get/get.dart';
import 'package:venturo_food/features/login/controllers/login_controller.dart';

class LoginBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(
      LoginController(),
    );
  }
}
