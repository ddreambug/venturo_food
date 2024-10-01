import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:panara_dialogs/panara_dialogs.dart';
import 'package:venturo_food/configs/routes/main_route.dart';
import 'package:venturo_food/features/login/views/components/login_flavor.dart';
import 'package:venturo_food/global_controllers/global_controller.dart';
import 'package:flutter/material.dart';

class LoginController extends GetxController {
  static LoginController get to => Get.find();

  /// Form Variable Setting
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var emailValue = "".obs;
  var passwordController = TextEditingController();
  var passwordValue = "".obs;
  var obscureText = true.obs;

  /// Form Password show
  void changePasswordVisibility() {
    obscureText.value = !obscureText.value;
  }

  /// Form Validate & Submited
  void validateForm(context) async {
    await GlobalController.to.checkConnection();

    var isValid = formKey.currentState!.validate();
    Get.focusScope!.unfocus();

    if (isValid && GlobalController.to.isConnect.value == true) {
      EasyLoading.show(
        status: 'Sedang Diproses...',
        maskType: EasyLoadingMaskType.black,
        dismissOnTap: false,
      );

      formKey.currentState!.save();
      if (emailController.text == "admin@gmail.com" &&
          passwordController.text == "admin") {
        EasyLoading.dismiss();
        Get.offNamed('/search-location');
      } else {
        EasyLoading.dismiss();
        PanaraInfoDialog.show(
          context,
          title: "Warning",
          message: "Email & Password Salah",
          buttonText: "Coba lagi",
          onTapDismiss: () {
            Get.back();
          },
          panaraDialogType: PanaraDialogType.warning,
          barrierDismissible: false,
        );
      }
    } else if (GlobalController.to.isConnect.value == false) {
      Get.toNamed(MainRoute.noConnection);
    }
  }

  void flavorSeting() async {
    Get.bottomSheet(
      const LoginFlavor(),
    );
  }
}
