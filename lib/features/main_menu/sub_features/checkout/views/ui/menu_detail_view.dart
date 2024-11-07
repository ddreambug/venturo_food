import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:venturo_food/configs/themes/main_color.dart';
import 'package:venturo_food/features/main_menu/sub_features/checkout/controllers/checkout_controller.dart';
import 'package:venturo_food/features/main_menu/sub_features/checkout/views/components/build_menu_properties.dart';
import 'package:venturo_food/features/main_menu/sub_features/checkout/views/components/build_quantity_button.dart';
import 'package:venturo_food/features/main_menu/sub_features/checkout/views/components/build_reactive_button.dart';
import 'package:venturo_food/features/main_menu/sub_features/checkout/views/components/checkout_bottom_navbar.dart';
import 'package:venturo_food/shared/widgets/styles/google_text_style.dart';
import 'package:venturo_food/features/main_menu/controllers/list_controller.dart';
import 'package:venturo_food/features/main_menu/views/components/custom_appbar.dart';
import 'package:venturo_food/features/main_menu/views/components/custom_bottomnavbar.dart';

class MenuDetailView extends StatelessWidget {
  const MenuDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    final arguments = Get.arguments as Map<String, dynamic>;
    final menuItem = arguments['item'];
    final isCart = arguments['isCart'] ?? false;
    final items = ListController.to.items;
    final cart = CheckoutController.to.cart;
    final dataSource = isCart ? cart : items;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: CustomAppbar(
          appBarTitle: isCart ? 'Edit Menu' : 'Menu Detail'.tr,
          useIcon: false,
        ),
        bottomNavigationBar: !isCart
            ? Obx(
                () => CustomBottomnavbar(
                  currentIndex: ListController.to.currentNavBarIndex.value,
                ),
              )
            : const CheckoutBottomNavbar(
                checkoutNavbarType: 'pesanan',
              ),
        body: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ///Build menu image
            SizedBox(height: 20.h),
            SizedBox(
              height: 181.h,
              width: 378.w,
              child: CachedNetworkImage(
                imageUrl: menuItem['foto'] ??
                    'https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/240px-No_image_available.svg.png',
                useOldImageOnUrlChange: true,
                errorWidget: (context, url, error) => Image.network(
                    'https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/240px-No_image_available.svg.png'),
                color: Colors.grey[100],
                colorBlendMode: BlendMode.darken,
                fit: BoxFit.contain,
              ),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(top: 20.h),
                decoration: const BoxDecoration(
                  color: MainColor.white,
                  borderRadius: BorderRadiusDirectional.vertical(
                    top: Radius.circular(30),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromARGB(21, 24, 24, 24),
                      blurRadius: 15,
                      spreadRadius: -1,
                      offset: Offset(0, 1),
                    ),
                  ],
                ),
                width: double.infinity,
                height: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            menuItem['name'],
                            style: GoogleTextStyle.w700.copyWith(
                              fontSize: 20.sp,
                              color: MainColor.primary,
                            ),
                          ),
                          const Spacer(),
                          BuildQuantityButton(
                            menuItem: menuItem,
                            dataSource: dataSource,
                            isCart: isCart,
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: 8.h,
                          bottom: 18.h,
                        ),
                        child: Text(
                          menuItem['deskripsi'],
                          style: GoogleTextStyle.w400.copyWith(fontSize: 12.sp),
                        ),
                      ),
                      const Divider(),
                      BuildMenuProperties(
                        menuItem: menuItem,
                        isCart: isCart,
                      ),
                      SizedBox(height: 15.h),
                      if (!isCart) ...{
                        BuildReactiveButton(
                          menuItem: menuItem,
                          dataSource: dataSource,
                        ),
                      },
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
