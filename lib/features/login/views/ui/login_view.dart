import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:venturo_food/configs/themes/main_color.dart';
import 'package:venturo_food/constants/cores/assets/image_constant.dart';
import 'package:venturo_food/features/login/controllers/login_controller.dart';
import 'package:venturo_food/features/login/views/components/social_login_button.dart';
import 'package:venturo_food/features/login/views/components/divider_custom.dart';
import 'package:venturo_food/global_controllers/analytics_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:venturo_food/shared/widgets/text_form_field_custom.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final loginController = LoginController.to;

    ///google analytic
    final analyticsController = AnalyticsController.to;
    analyticsController.logCurrentScreen(screenName: 'Login Screen');

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(40, 100, 40, 100).w,
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
                      height: 91.w,
                      width: 270.w,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                SizedBox(height: 100.w),
                Text(
                  'Masuk untuk melanjutkan!',
                  style: TextStyle(fontSize: 22.sp),
                ),
                SizedBox(height: 15.w),
                const TextFormFieldCustom(
                  fieldType: 'emailInput',
                ),
                SizedBox(height: 15.w),
                Obx(
                  () => TextFormFieldCustom(
                    fieldType: 'passwordInput',
                    obscureText: loginController.obscureText.value,
                  ),
                ),
                SizedBox(height: 30.w),
                SizedBox(
                  width: double.infinity,
                  height: 44.w,
                  child: ElevatedButton(
                    onPressed: () {
                      analyticsController.logButtonClick('Button Masuk');
                      loginController.validateForm(context);
                    },
                    style: ElevatedButton.styleFrom(
                      side: const BorderSide(
                        color: Color(0xFF00717F),
                        width: 1,
                      ),
                    ),
                    child: Text(
                      'Masuk',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: MainColor.white,
                          fontWeight: FontWeight.w800,
                          fontSize: 14.sp),
                    ),
                  ),
                ),
                SizedBox(
                  height: 40.w,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        Get.toNamed('forgot-password');
                      },
                      child: Text(
                        'Lupa Password?',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: const Color.fromARGB(255, 0, 0, 0),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 60.w),
                const DividerCustom(),
                SizedBox(height: 10.w),
                SocialLoginButton(onPress: () {})
              ],
            ),
          ),
        ),
      ),
    );
  }
}
