import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:venturo_food/configs/themes/main_color.dart';
import 'package:venturo_food/shared/widgets/styles/google_text_style.dart';

class PinDialog extends StatefulWidget {
  final String pin;

  const PinDialog({
    super.key,
    required this.pin,
  });

  @override
  State<PinDialog> createState() => _PinDialogState();
}

class _PinDialogState extends State<PinDialog> {
  final RxBool obscure = RxBool(true);
  final RxnString errorText = RxnString();
  final TextEditingController controller = TextEditingController();
  int tries = 3;

  Future<void> processPin(String? pin) async {
    await Future.delayed(const Duration(milliseconds: 500));

    if (pin == '123456') {
      // if pin is correct close the dialog
      Get.back<bool>(result: true);
    } else {
      // if pin incorrect, type again
      tries--;

      if (tries == 0) {
        // if tries more than 3, close the dialog
        Get.back<bool>(result: false);
      } else {
        // show how many tries user have left
        controller.clear();
        errorText.value = 'PIN wrong! $tries chances left.';
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 34.w,
      height: 35.h,
      textStyle: Get.textTheme.titleLarge,
      margin: EdgeInsets.symmetric(horizontal: 0.w),
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).primaryColor),
        borderRadius: BorderRadius.circular(10.r),
      ),
    );

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 6.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // title
          Text(
            'Verifikasi Pesanan',
            style: GoogleTextStyle.w600.copyWith(fontSize: 22.sp),
          ),

          // subtitle
          Text(
            'Masukkan kode PIN',
            style: GoogleTextStyle.w400.copyWith(fontSize: 16.sp),
          ),
          24.verticalSpacingRadius,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Obx(
                () => Expanded(
                  // pin input
                  child: Pinput(
                    controller: controller,
                    showCursor: false,
                    length: 6,
                    autofocus: true,
                    closeKeyboardWhenCompleted: false,
                    defaultPinTheme: defaultPinTheme,
                    obscureText: obscure.value,
                    onSubmitted: processPin,
                    onCompleted: processPin,
                    separatorBuilder: (index) {
                      if (index == 1 || index == 3) {
                        // Add dash after index 1 and index 3
                        return const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 2.0),
                          child: Text(
                            '-',
                            style: TextStyle(
                              fontSize: 15.0, // Dash size
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        );
                      }
                      return const SizedBox(
                          width: 3.0); // Add spacing between other boxes
                    },
                  ),
                ),
              ),
              3.horizontalSpace,
              // show pin button
              Obx(
                () => InkWell(
                  radius: 24.r,
                  child: Icon(
                    obscure.value ? Icons.visibility : Icons.visibility_off,
                    color: MainColor.grey,
                    size: 20.r,
                  ),
                  onTap: () {
                    obscure.value = !obscure.value;
                  },
                ),
              ),
            ],
          ),

          /// Pesan error
          Obx(
            () => errorText.value != null
                ? Padding(
                    padding: EdgeInsets.only(left: 2.r, right: 15.r, top: 10.r),
                    child: Text(
                      errorText.value!,
                      style: Get.textTheme.bodySmall!
                          .copyWith(color: Theme.of(context).colorScheme.error),
                      textAlign: TextAlign.center,
                    ),
                  )
                : Container(),
          ),
        ],
      ),
    );
  }
}
