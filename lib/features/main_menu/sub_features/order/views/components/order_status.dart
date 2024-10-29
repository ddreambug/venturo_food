import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/ic.dart';
import 'package:panara_dialogs/panara_dialogs.dart';
import 'package:venturo_food/configs/themes/main_color.dart';
import 'package:venturo_food/features/main_menu/sub_features/order/controllers/order_controller.dart';
import 'package:venturo_food/shared/widgets/styles/google_text_style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrderStatus extends StatelessWidget {
  const OrderStatus({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(
            bottom: 7.w,
            top: 3.w,
          ),
          child: Obx(
            () {
              final orderStatus = OrderController.to.selectedOrder['status'];
              return Text(
                orderStatus == 3
                    ? 'Order Canceled'.tr
                    : orderStatus == 2
                        ? 'Order Complete'.tr
                        : 'Order Prepared'.tr,
                style: GoogleTextStyle.w600.copyWith(
                  fontSize: 16.sp,
                  color: Colors.black,
                ),
              );
            },
          ),
        ),
        SizedBox(height: 10.w),
        GestureDetector(
          onTap: () {
            PanaraConfirmDialog.show(
              context,
              title: "Update Status",
              message: "Are you sure to update this order status?".tr,
              confirmButtonText: "Yes".tr,
              cancelButtonText: 'No'.tr,
              onTapConfirm: () {
                Navigator.pop(context);
                OrderController.to.updateOrderStatus();
              },
              onTapCancel: () {
                Navigator.pop(context);
              },
              panaraDialogType: PanaraDialogType.normal,
              barrierDismissible: false,
            );
          },
          child: Obx(
            () {
              final orderItem = OrderController.to.selectedOrder;
              final List<int> status = [0, 1, 2];

              return Row(
                children: [
                  for (int i = 0; i < status.length; i++) ...[
                    if (i > 0)
                      Expanded(
                        child: Divider(thickness: 3.h),
                      ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.w),
                      child: Iconify(
                        orderItem['status'] == status[i]
                            ? Ic.baseline_check_circle
                            : Ic.baseline_circle,
                        size: orderItem['status'] == status[i] ? 22.h : 12.h,
                        color: orderItem['status'] == status[i]
                            ? MainColor.primary
                            : const Color.fromARGB(255, 150, 150, 150),
                      ),
                    ),
                  ],
                ],
              );
            },
          ),
        ),
        Row(
          children: [
            SizedBox(
              width: 60.w,
              height: 35.w,
              child: Text(
                'Order Recieved'.tr,
                style: GoogleTextStyle.w400.copyWith(fontSize: 12.w),
                textAlign: TextAlign.center,
              ),
            ),
            const Spacer(),
            SizedBox(
              width: 60.w,
              height: 35.w,
              child: Text(
                'Please Take'.tr,
                style: GoogleTextStyle.w400.copyWith(fontSize: 12.w),
                textAlign: TextAlign.center,
              ),
            ),
            const Spacer(),
            SizedBox(
              width: 64.w,
              height: 35.w,
              child: Text(
                'Order Complete'.tr,
                style: GoogleTextStyle.w400.copyWith(fontSize: 12.w),
                textAlign: TextAlign.right,
              ),
            ),
          ],
        )
      ],
    );
  }
}
