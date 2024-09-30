import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:venturo_food/constants/cores/assets/image_constant.dart';
import 'package:venturo_food/modules/features/sign_in/controllers/login_controller.dart';
import 'package:venturo_food/modules/features/sign_in/views/components/api_login.dart';
import 'package:venturo_food/modules/features/sign_in/views/components/divider_custom.dart';
import 'package:venturo_food/modules/global_controllers/analytics_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final loginController = LoginController.to;

    ///google analytic
    final analyticsController = Get.find<AnalyticsController>();
    analyticsController.logCurrentScreen(screenName: 'Login Screen');

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(25, 100, 25, 100).r,
          child: Form(
            key: loginController.formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Hero(
                  tag: 'splashImage',
                  child: GestureDetector(
                    onDoubleTap: () => loginController.flavorSeting(),
                    child: Image.asset(
                      ImageConstant.logo,
                      width: 300.r,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                SizedBox(height: 60.w),
                Text(
                  'Masuk untuk melanjutkan!',
                  style: TextStyle(fontSize: 18.sp),
                ),
                SizedBox(height: 10.r),
                TextFormField(
                  controller: loginController.emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Isikan Email';
                    } else if (!RegExp(r"^[a-zA-Z0-9._%+-]+@gmail\.com$")
                        .hasMatch(value)) {
                      return 'Format Email harus benar!';
                    }
                    return null;
                  },
                  style: TextStyle(fontSize: 16.sp),
                  decoration: const InputDecoration(
                    labelText: 'Alamat Email',
                    hintText: 'Lorem.ipsum@gmail.com',
                  ),
                  onSaved: (newValue) =>
                      loginController.emailValue.value = newValue!,
                ),
                Obx(
                  () => TextFormField(
                    controller: loginController.passwordController,
                    style: TextStyle(fontSize: 16.sp),
                    obscureText: loginController.obscureText.value,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Isikan Password';
                      } else if (value.contains(RegExp(r' '))) {
                        return 'Tidak boleh ada Whitespace!';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: 'Kata Sandi',
                      hintText: '***************',
                      suffixIcon: IconButton(
                        onPressed: () {
                          loginController.changePasswordVisibility();
                        },
                        icon: Icon(
                          loginController.obscureText.value
                              ? CupertinoIcons.eye_fill
                              : CupertinoIcons.eye_slash_fill,
                          color: const Color.fromARGB(255, 87, 87, 87),
                        ),
                      ),
                    ),
                    onSaved: (newValue) =>
                        loginController.passwordValue.value = newValue!,
                  ),
                ),
                SizedBox(height: 10.r),
                SizedBox(
                  width: double.infinity,
                  height: 35.w,
                  child: ElevatedButton(
                      onPressed: () {
                        analyticsController.logButtonClick('Button Masuk');
                        LoginController.to.validateForm(context);
                      },
                      child: const Text('Masuk')),
                ),
                SizedBox(
                  height: 32.w,
                  child: TextButton(
                    onPressed: () {
                      Get.toNamed('forgot-password');
                    },
                    child: Text(
                      'Lupa Password?',
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 12.sp),
                    ),
                  ),
                ),
                SizedBox(height: 70.w),
                const DividerCustom(),
                ApiLogin(onPress: () {})
              ],
            ),
          ),
        ),
      ),
    );
  }
}
