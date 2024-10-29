import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:venturo_food/features/forgot_password/controllers/forgot_password_controller.dart';
import 'package:venturo_food/configs/themes/main_color.dart';
import 'package:venturo_food/constants/cores/assets/image_constant.dart';
import 'package:venturo_food/global_controllers/analytics_controller.dart';
import 'package:venturo_food/shared/widgets/text_form_field_custom.dart';

class ForgotPasswordView extends StatelessWidget {
  const ForgotPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    ///google analytics
    final analyticsController = AnalyticsController.to;
    analyticsController.logCurrentScreen();

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
              Hero(
                tag: 'splashImage',
                child: Image.asset(
                  ImageConstant.logoIcon,
                  width: 200.r,
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(height: 70.h),
              Column(
                children: [
                  Text(
                    'Enter email address to change your password'.tr,
                    style: TextStyle(
                      fontSize: 20.sp,
                      color: MainColor.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20.h),
                  Form(
                    key: ForgotPasswordController.to.formKey,
                    child: const TextFormFieldCustom(
                      fieldType: 'forgotEmailInput',
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
                        "Cancel".tr,
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
                        "Change Password".tr,
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
