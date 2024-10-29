import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:panara_dialogs/panara_dialogs.dart';
import 'package:venturo_food/configs/themes/main_color.dart';
import 'package:venturo_food/constants/cores/assets/image_constant.dart';
import 'package:venturo_food/features/main_menu/sub_features/order/controllers/order_controller.dart';
import 'package:venturo_food/shared/widgets/styles/google_text_style.dart';

/// Used in promo_detail_view.dart
/// Used in subfeatures menu_detail_view.dart
class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppbar({
    super.key,
    required this.appBarTitle,
    this.useIcon = true,
    this.icon = ImageConstant.promoIcon,
    this.isOrder = false,
  });

  final String appBarTitle;
  final bool useIcon;
  final bool isOrder;
  final String icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 68.w,
      padding: EdgeInsets.symmetric(
        horizontal: 5.w,
        vertical: 10.h,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(30.r),
        ),
        boxShadow: const [
          BoxShadow(
            color: Color.fromARGB(68, 24, 24, 24),
            blurRadius: 15,
            spreadRadius: -1,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(
                CupertinoIcons.back,
                color: MainColor.black,
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (useIcon) ...{
                  Image.asset(
                    icon,
                    width: 18.w,
                    color: MainColor.primary,
                  ),
                },
                SizedBox(width: 8.w),
                Text(
                  appBarTitle,
                  style: GoogleTextStyle.w700.copyWith(fontSize: 20.sp),
                ),
              ],
            ),
          ),
          if (isOrder) ...{
            Obx(
              () {
                var orderStatus = OrderController.to.selectedOrder['status'];
                if (orderStatus != 2 && orderStatus != 3) {
                  return Positioned(
                    top: 5.w,
                    right: 15.w,
                    child: SizedBox(
                      height: 40.w,
                      child: ElevatedButton(
                        onPressed: () {
                          PanaraConfirmDialog.show(
                            context,
                            panaraDialogType: PanaraDialogType.error,
                            message: 'Are you going to cancel this order?'.tr,
                            confirmButtonText: 'Yes'.tr,
                            cancelButtonText: 'No'.tr,
                            onTapConfirm: () {
                              OrderController.to
                                  .updateOrderStatus(isCancelOrder: true);
                              Get.until(
                                (route) => route.settings.name == '/order',
                              );
                            },
                            onTapCancel: () {
                              Get.back();
                            },
                          );
                        },
                        style: const ButtonStyle(
                          backgroundColor:
                              WidgetStatePropertyAll(MainColor.danger),
                        ),
                        child: Text(
                          'Cancel'.tr,
                          style: GoogleTextStyle.w500.copyWith(fontSize: 12.sp),
                        ),
                      ),
                    ),
                  );
                } else {
                  return const SizedBox.shrink();
                }
              },
            )
          }
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
