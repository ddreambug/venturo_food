import 'package:get/get.dart';
import 'package:venturo_food/modules/global_controllers/global_controller.dart';

class LoginController extends GetxController {
  static LoginController get to => Get.find();

  @override
  void onInit() async {
    super.onInit();

    await GlobalController.to.checkConnection();
  }

  var obscureText = true.obs;
  void changePasswordVisibility() {
    obscureText.value = !obscureText.value;
  }

  void changeScreen() {
    if (GlobalController.to.isConnect.value) {
      Get.toNamed('/counter');
    }
  }
}
