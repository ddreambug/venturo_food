import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:panara_dialogs/panara_dialogs.dart';
import 'package:venturo_food/configs/themes/main_color.dart';
import 'package:venturo_food/features/forgot_password/views/component/otp_component.dart';
import 'package:venturo_food/global_controllers/global_controller.dart';

class ForgotPasswordController extends GetxController {
  static ForgotPasswordController get to => Get.find();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController otpTextController = TextEditingController();

  var formKey = GlobalKey<FormState>();
  var emailValue = "".obs;

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
      emailValue.value = emailController.text;
      EasyLoading.dismiss();

      otpTextController.clear();
      Get.dialog(const OtpView());
    }
  }

  void onOtpComplete(BuildContext context, String value) {
    if (value == "1234") {
      PanaraInfoDialog.show(
        context,
        message: 'Password telah di Reset!',
        buttonText: 'OK',
        onTapDismiss: () {
          Get.offAllNamed('/login');
        },
        panaraDialogType: PanaraDialogType.success,
        barrierDismissible: false,
      );
      Get.snackbar("Sukses", "Kode Otp Valid",
          backgroundColor: MainColor.white,
          duration: const Duration(seconds: 2));
    }
  }
}
