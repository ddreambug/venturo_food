import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 50.h),
              GestureDetector(
                child: Image.asset(
                  ImageConstant.logo,
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(height: 70.h),
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
                  controller: ForgotPasswordController.to.emailCtrl,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: "Email Address",
                    hintText: "Input Email Address",
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Email address cannot be empty";
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(height: 20.h),
              ElevatedButton(
                onPressed: () {},
                child: Text(
                  "Ubah Password",
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: MainColor.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
