import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/carbon.dart';
import 'package:iconify_flutter/icons/heroicons.dart';
import 'package:venturo_food/configs/themes/main_color.dart';
import 'package:venturo_food/constants/cores/assets/image_constant.dart';
import 'package:venturo_food/features/main_menu/controllers/list_controller.dart';
import 'package:venturo_food/features/main_menu/sub_features/order/controllers/order_controller.dart';
import 'package:venturo_food/shared/widgets/styles/google_text_style.dart';

/// Used in main_menu_view.dart
/// Used in promo_detail_view.dart
/// Used in subfeatures menu_detail_view.dart
class CustomBottomnavbar extends StatelessWidget {
  const CustomBottomnavbar({super.key, this.currentIndex = 0});

  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(30.r),
          ),
          child: Container(
            width: double.infinity,
            height: 66.w,
            padding: const EdgeInsets.symmetric(),
            decoration: BoxDecoration(
              color: MainColor.black,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(30.r),
              ),
            ),
            child: BottomNavigationBar(
              backgroundColor: Colors.transparent,
              selectedItemColor: Colors.white,
              unselectedItemColor: Colors.grey,
              selectedFontSize: 10.sp,
              unselectedFontSize: 10.sp,
              currentIndex: ListController.to.currentNavBarIndex.value,
              onTap: (value) {
                ListController.to.currentNavBarIndex.value = value;

                if (ListController.to.currentNavBarIndex.value == 1) {
                  Get.toNamed('/order');
                } else if (ListController.to.currentNavBarIndex.value == 0) {
                  Get.until((route) => route.settings.name == '/main-menu');
                } else if (ListController.to.currentNavBarIndex.value == 2) {
                  Get.toNamed('/profil');
                }
              },
              items: [
                BottomNavigationBarItem(
                  icon: Iconify(
                    Heroicons.home_20_solid,
                    color: ListController.to.currentNavBarIndex.value == 0
                        ? MainColor.white
                        : MainColor.grey,
                    size: 34.w,
                  ),
                  label: 'Beranda',
                ),
                BottomNavigationBarItem(
                  icon: Image.asset(
                    ImageConstant.pesananIcon,
                    color: ListController.to.currentNavBarIndex.value == 1
                        ? MainColor.white
                        : MainColor.grey,
                    width: 34.w,
                    height: 34.w,
                  ),
                  label: 'Pesanan',
                ),
                BottomNavigationBarItem(
                  icon: Iconify(
                    Carbon.user_avatar_filled_alt,
                    color: ListController.to.currentNavBarIndex.value == 2
                        ? MainColor.white
                        : MainColor.grey,
                    size: 34.w,
                  ),
                  label: 'Profil',
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: 4.w,
          right: 170.w,
          child: Obx(
            () {
              if (OrderController.to.ongoingOrders.isNotEmpty) {
                return CircleAvatar(
                  radius: 10.w,
                  child: Obx(
                    () {
                      var orderCount = OrderController.to.ongoingOrders.length;

                      return Text(
                        '$orderCount',
                        style: GoogleTextStyle.w700.copyWith(fontSize: 14.sp),
                      );
                    },
                  ),
                );
              } else {
                return const SizedBox.shrink();
              }
            },
          ),
        ),
      ],
    );
  }
}
