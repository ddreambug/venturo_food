import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:venturo_food/modules/features/forgot_password/controllers/forgot_password_controller.dart';
import 'package:venturo_food/configs/themes/main_color.dart';
import 'package:venturo_food/constants/cores/assets/image_constant.dart';
import 'package:venturo_food/modules/global_controllers/analytics_controller.dart';

class ForgotPasswordView extends StatelessWidget {
  const ForgotPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    final analytics = AnalyticsController.to;

    /// Google analytics untuk tracking user di setiap halaman
    if (Platform.isAndroid) {
      /// Tracking bawah dia masuk screen lupa password di device android
      analytics.setCurrentScreen(
        screenName: 'Forgot Password Screen',
        screenClass: 'Android',
      );
    } else if (Platform.isIOS) {
      /// Tracking bawah dia masuk screen lupa password di device ios
      analytics.setCurrentScreen(
        screenName: 'Forgot Password Screen',
        screenClass: 'IOS',
      );
    } else if (Platform.isMacOS) {
      /// Tracking bawah dia masuk screen lupa password di device macos
      analytics.setCurrentScreen(
        screenName: 'Forgot Password Screen',
        screenClass: 'MacOS',
      );
    }

    if (kIsWeb) {
      /// Tracking bawah dia masuk screen lupa password di device web
      analytics.setCurrentScreen(
        screenName: 'Forgot Password Screen',
        screenClass: 'Web',
      );
    }

    return Scaffold(
      appBar: null,
      extendBody: false,
      backgroundColor: MainColor.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(45),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 50.h),
              Image.asset(
                ImageConstant.logo,
                width: 200.w,
                fit: BoxFit.contain,
              ),
              SizedBox(height: 70.h),
              Column(
                children: [
                  Text(
                    'Masukkan alamat email untuk mengubah password anda',
                    style: TextStyle(
                      fontSize: 20.sp,
                      color: MainColor.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20.h),
                  Form(
                    key: ForgotPasswordController.to.formKey,
                    child: TextFormField(
                      controller: ForgotPasswordController.to.emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        labelText: "Email Address",
                        hintText: "Input Email Address",
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Email address cannot be empty";
                        } else if (!RegExp(r"^[a-zA-Z0-9._%+-]+@gmail\.com$")
                            .hasMatch(value)) {
                          return 'Email must be a valid Gmail address';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 45.h,
                    width: 170.h,
                    child: ElevatedButton(
                      style: const ButtonStyle(
                        backgroundColor:
                            WidgetStatePropertyAll(MainColor.danger),
                      ),
                      onPressed: () {
                        Get.back();
                      },
                      child: Text(
                        "Cancel",
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: MainColor.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  const Spacer(),
                  SizedBox(
                    height: 45.h,
                    width: 170.h,
                    child: ElevatedButton(
                      onPressed: () {
                        ForgotPasswordController.to.validateForm(context);
                      },
                      child: Text(
                        "Ubah Password",
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: MainColor.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
