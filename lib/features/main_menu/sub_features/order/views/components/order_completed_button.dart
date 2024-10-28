import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:panara_dialogs/panara_dialogs.dart';
import 'package:venturo_food/configs/themes/main_color.dart';
import 'package:venturo_food/features/main_menu/sub_features/checkout/controllers/checkout_controller.dart';
import 'package:venturo_food/shared/widgets/styles/google_text_style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrderCompletedButton extends StatelessWidget {
  const OrderCompletedButton({
    super.key,
    required this.orderItem,
    this.isCanceled = false,
  });

  final bool isCanceled;
  final Map<String, dynamic> orderItem;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (!isCanceled) ...{
          SizedBox(
            height: 23.h,
            width: 100.w,
            child: ElevatedButton(
              onPressed: () {
                print('beri penilaian');
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.zero,
                backgroundColor: MainColor.white,
                foregroundColor: MainColor.primary,
                side: BorderSide(
                  color: const Color.fromARGB(255, 35, 112, 133),
                  width: 1.5.w,
                ),
              ),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Beri Penilaian',
                      style: GoogleTextStyle.w700.copyWith(
                        fontSize: 10.sp,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: 10.w),
        },
        SizedBox(
          height: 23.h,
          width: 100.w,
          child: ElevatedButton(
            onPressed: () {
              for (var item in orderItem['item']) {
                CheckoutController.to.addCartItem(item);
              }

              PanaraInfoDialog.show(
                context,
                message: 'Order Ditambahkan',
                buttonText: 'Oke',
                onTapDismiss: () {
                  Get.until(
                    (route) => route.settings.name == '/main-menu',
                  );
                  Get.toNamed(
                    '/detail-pesanan',
                  );
                },
                panaraDialogType: PanaraDialogType.success,
              );
            },
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.zero,
              side: BorderSide(
                color: const Color.fromARGB(255, 35, 112, 133),
                width: 1.5.w,
              ),
            ),
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Pesan Lagi',
                    style: GoogleTextStyle.w700.copyWith(
                      fontSize: 10.sp,
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
