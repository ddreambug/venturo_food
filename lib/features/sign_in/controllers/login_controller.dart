import 'package:get/get.dart';

class LoginController extends GetxController {
  static LoginController get to => Get.find();

  var obscureText = true.obs;
  changePasswordVisibility() {
    obscureText.value = !obscureText.value;
  }
}
