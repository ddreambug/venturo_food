import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:venturo_food/features/main_menu/sub_features/checkout/controllers/checkout_controller.dart';
import 'package:venturo_food/shared/widgets/styles/google_text_style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BuildReactiveButton extends StatelessWidget {
  const BuildReactiveButton(
      {super.key, required this.menuItem, required this.dataSource});

  final Map<String, dynamic> menuItem;
  final RxList<Map<String, dynamic>> dataSource;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        final matchedItem = dataSource
            .firstWhere((item) => item['id_menu'] == menuItem['id_menu']);
        if (matchedItem['jumlah'] > 0) {
          return SizedBox(
            width: double.infinity,
            height: 42.w,
            child: ElevatedButton(
              onPressed: () async {
                final result =
                    await CheckoutController.to.addCartItem(menuItem);
                Get.back();
                Get.showSnackbar(
                  GetSnackBar(
                    message: result,
                    snackPosition: SnackPosition.TOP,
                    duration: const Duration(milliseconds: 1500),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                side: const BorderSide(
                  color: Color(0xFF00717F),
                  width: 1,
                ),
              ),
              child: Text(
                'Add to Order'.tr,
                style: GoogleTextStyle.w700.copyWith(fontSize: 14.sp),
              ),
            ),
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
