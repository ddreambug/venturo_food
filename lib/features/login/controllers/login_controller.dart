import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:panara_dialogs/panara_dialogs.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:venturo_food/configs/routes/main_route.dart';
import 'package:venturo_food/features/login/repositories/login_repository.dart';
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

      try {
        var response = await LoginRepository()
            .login(emailController.text, passwordController.text);

        if (response['status_code'] == 200) {
          await addUser(
            nama: response['data']['user']['nama'],
            tanggalLahir: '12/12/2012',
            nomorTelepon: '08224111400',
            alamatEmail: response['data']['user']['email'],
            pin: response['data']['user']['pin'],
            foto: response['data']['user']['foto'],
            token: response['data']['token'],
          );
          EasyLoading.dismiss();
          Get.offNamed('/search-location');
        } else if (response['status_code'] == 422) {
          EasyLoading.dismiss();
          PanaraInfoDialog.show(
            context,
            title: "Warning",
            message: response['errors'][0],
            buttonText: "Coba lagi",
            onTapDismiss: () {
              Get.back();
            },
            panaraDialogType: PanaraDialogType.warning,
            barrierDismissible: false,
          );
        } else {
          EasyLoading.dismiss();
          PanaraInfoDialog.show(
            context,
            title: "Warning",
            message: response['message'],
            buttonText: "Coba lagi",
            onTapDismiss: () {
              Get.back();
            },
            panaraDialogType: PanaraDialogType.warning,
            barrierDismissible: false,
          );
        }
      } catch (exception, stacktrace) {
        await Sentry.captureException(
          exception,
          stackTrace: stacktrace,
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

  Future<void> addUser({
    required String nama,
    required String tanggalLahir,
    required String nomorTelepon,
    required String alamatEmail,
    required String pin,
    required String foto,
    required String token,
  }) async {
    // Open the Hive box
    var box = Hive.box('venturo');

    // Store user data in the Hive box
    await box.put('nama', nama);
    await box.put('tanggalLahir', tanggalLahir);
    await box.put('nomorTelepon', nomorTelepon);
    await box.put('alamatEmail', alamatEmail);
    await box.put('pin', pin);
    await box.put('foto', foto);
    await box.put('token', token);
  }
}
