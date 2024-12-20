import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/healthicons.dart';
import 'package:venturo_food/configs/themes/main_color.dart';
import 'package:venturo_food/constants/cores/assets/image_constant.dart';
import 'package:venturo_food/features/main_menu/sub_features/order/controllers/order_controller.dart';
import 'package:venturo_food/shared/widgets/styles/google_text_style.dart';

class EmptyOrder extends StatelessWidget {
  const EmptyOrder({
    super.key,
    this.customMessage = '',
  });

  final String customMessage;
  @override
  Widget build(BuildContext context) {
    String emptyOrderText;

    return Center(
      child: Stack(
        children: [
          Positioned(
            top: 30.w,
            bottom: 30.w,
            left: 30.w,
            right: 30.w,
            child: Image.asset(
              ImageConstant.patternBackground,
              color: const Color.fromARGB(91, 44, 138, 164),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Iconify(
                  Healthicons.i_note_action_outline,
                  size: 200.w,
                  color: MainColor.primary,
                ),
                Obx(
                  () {
                    final tabValue = OrderController.to.orderAppbarValue.value;
                    if (tabValue == 1) {
                      if (customMessage != '') {
                        emptyOrderText = customMessage;
                      } else {
                        emptyOrderText =
                            'Start making orders.\n\nYour order\nwill show up here so\nyou can find\nyour favourite menu again!'
                                .tr;
                      }
                    } else {
                      emptyOrderText =
                          'Already Order?\nTrace your orders\nhere'.tr;
                    }

                    return SizedBox(
                      height: 200.w,
                      child: Text(
                        emptyOrderText,
                        textAlign: TextAlign.center,
                        style: GoogleTextStyle.w400.copyWith(fontSize: 22.sp),
                      ),
                    );
                  },
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
