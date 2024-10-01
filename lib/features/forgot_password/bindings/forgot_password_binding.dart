import 'package:get/get.dart';
import 'package:venturo_food/features/forgot_password/controllers/forgot_password_controller.dart';

class ForgotPasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ForgotPasswordController());
  }
}
