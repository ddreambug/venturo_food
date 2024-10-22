import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/healthicons.dart';
import 'package:venturo_food/configs/themes/main_color.dart';
import 'package:venturo_food/constants/cores/assets/image_constant.dart';
import 'package:venturo_food/features/main_menu/sub_features/order/controllers/order_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:venturo_food/features/main_menu/sub_features/order/views/components/order_card.dart';
import 'package:venturo_food/shared/widgets/styles/google_text_style.dart';

class OrderListItem extends StatelessWidget {
  const OrderListItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        final tabValue = OrderController.to.orderAppbarValue.value;
        final ongoingOrders = OrderController.to.ongoingOrders;
        final finishedOrders = OrderController.to.finishedOrders;

        if (tabValue == 0) {
          if (ongoingOrders.isNotEmpty) {
            return SingleChildScrollView(
              padding: EdgeInsets.only(
                top: 10.w,
                bottom: 50.w,
              ),
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: ongoingOrders.length,
                itemBuilder: (context, index) {
                  return OrderCard(
                    orderItem: ongoingOrders[index],
                  );
                },
              ),
            );
          } else {
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
                        SizedBox(
                          height: 200.w,
                          child: Text(
                            'Sudah Pesan?\nLacak pesananmu\ndi sini.',
                            textAlign: TextAlign.center,
                            style:
                                GoogleTextStyle.w400.copyWith(fontSize: 22.sp),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            );
          }
        } else {
          return SingleChildScrollView(
            padding: EdgeInsets.only(
              top: 10.w,
              bottom: 50.w,
            ),
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: finishedOrders.length,
              itemBuilder: (context, index) {
                return OrderCard(
                  isCompleted: true,
                  orderItem: finishedOrders[index],
                );
              },
            ),
          );
        }
      },
    );
  }
}
