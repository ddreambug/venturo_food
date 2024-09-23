import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:panara_dialogs/panara_dialogs.dart';
import 'package:venturo_food/configs/routes/main_route.dart';
import 'package:venturo_food/configs/themes/main_color.dart';
import 'package:venturo_food/constants/cores/api/api_constant.dart';
import 'package:venturo_food/modules/global_controllers/global_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
        Get.toNamed('/search-location');
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
      Obx(
        () => Wrap(
          children: [
            Container(
              width: double.infinity.w,
              padding: EdgeInsets.symmetric(
                horizontal: 5.w,
                vertical: 5.h,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                color: MainColor.white,
              ),
              child: Column(
                children: <Widget>[
                  ListTile(
                    onTap: () {
                      GlobalController.to.isStaging.value = false;
                      GlobalController.to.baseUrl = ApiConstant.production;
                    },
                    title: Text(
                      "Production",
                      style: TextStyle(
                        color: GlobalController.to.isStaging.value == true
                            ? MainColor.black
                            : MainColor.primary,
                        fontSize: 14.sp,
                      ),
                    ),
                    trailing: GlobalController.to.isStaging.value == true
                        ? null
                        : Icon(
                            Icons.check,
                            color: MainColor.primary,
                            size: 14.sp,
                          ),
                  ),
                  Divider(
                    height: 1.h,
                  ),
                  ListTile(
                    onTap: () {
                      GlobalController.to.isStaging.value = true;
                      GlobalController.to.baseUrl = ApiConstant.staging;
                    },
                    title: Text(
                      "Staging",
                      style: TextStyle(
                        color: GlobalController.to.isStaging.value == true
                            ? MainColor.primary
                            : MainColor.black,
                        fontSize: 14.sp,
                      ),
                    ),
                    trailing: GlobalController.to.isStaging.value == true
                        ? Icon(
                            Icons.check,
                            color: MainColor.primary,
                            size: 14.sp,
                          )
                        : null,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
