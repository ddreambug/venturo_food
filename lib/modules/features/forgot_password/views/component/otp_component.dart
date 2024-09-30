import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:venturo_food/configs/themes/main_color.dart';
import 'package:venturo_food/modules/features/forgot_password/controllers/forgot_password_controller.dart';
import 'package:venturo_food/modules/global_controllers/analytics_controller.dart';

class OtpView extends StatelessWidget {
  const OtpView({super.key});

  @override
  Widget build(BuildContext context) {
    ///google analytics
    final analyticsController = Get.find<AnalyticsController>();
    analyticsController.logCurrentScreen();

    return Center(
      child: Container(
        height: 300.r,
        width: 300.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: MainColor.white,
        ),
        padding: const EdgeInsets.fromLTRB(20, 35, 20, 35),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Obx(
              () => Text(
                'Masukkan kode OTP yang telah dikirimkan ke email ${ForgotPasswordController.to.emailValue.value}',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: MainColor.black,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 20.w,
            ),
            // pin input
            Pinput(
              controller: ForgotPasswordController.to.otpTextController,
              length: 4,
              pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value != "1234") {
                  return "Kode OTP salah";
                }
                return null;
              },
              onCompleted: (value) {
                ForgotPasswordController.to.onOtpComplete(context, value);
              },
            ),
          ],
        ),
      ),
    );
  }
}
