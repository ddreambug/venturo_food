import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:venturo_food/configs/themes/main_color.dart';
import 'package:venturo_food/features/main_menu/sub_features/checkout/controllers/checkout_controller.dart';
import 'package:venturo_food/features/main_menu/sub_features/checkout/views/components/checkout_bottom_navbar.dart';
import 'package:venturo_food/utils/enums/enum.dart';
import 'package:venturo_food/features/main_menu/controllers/list_controller.dart';
import 'package:venturo_food/features/main_menu/views/components/custom_appbar.dart';
import 'package:venturo_food/features/main_menu/views/components/custom_bottomnavbar.dart';
import 'package:venturo_food/features/main_menu/sub_features/checkout/views/components/custom_quantity_button.dart';
import 'package:venturo_food/features/main_menu/sub_features/checkout/views/components/menu_detail_list.dart';

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
          appBarTitle: isCart ? 'Edit Menu' : 'Detail Menu',
          useIcon: false,
        ),
        bottomNavigationBar: !isCart
            ? Obx(
                () => CustomBottomnavbar(
                  currentIndex: ListController.to.currentNavBarIndex.value,
                ),
              )
            : const CheckoutBottomNavbar(checkoutNavbarType: 'pesanan'),
        body: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 20.h),
            _buildMenuImage(menuItem),
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
                            style: Get.textTheme.displayMedium!.copyWith(
                                color: MainColor.primary,
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w900),
                          ),
                          const Spacer(),
                          _buildQuantityButton(menuItem, dataSource, isCart),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 8.h, bottom: 18.h),
                        child: Text(
                          menuItem['deskripsi'],
                          style: Get.textTheme.labelSmall!.copyWith(
                            fontSize: 12.sp,
                          ),
                        ),
                      ),
                      const Divider(),
                      ..._buildMenuProperties(menuItem, isCart),
                      if (!isCart) ...{
                        _buildReactiveSubmitButton(menuItem, dataSource),
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

  List<Widget> _buildMenuProperties(
      Map<String, dynamic> menuItem, bool isCart) {
    return [
      if (menuItem['category'] == 'minuman') ...{
        MenuDetailList(
          menuItem: menuItem,
          detailType: DetailType.harga,
          isCart: isCart,
        ),
        const Divider(),
        MenuDetailList(
          menuItem: menuItem,
          detailType: DetailType.level,
          isCart: isCart,
        ),
      } else ...[
        MenuDetailList(
          menuItem: menuItem,
          detailType: DetailType.harga,
          isCart: isCart,
        ),
        const Divider(),
        MenuDetailList(
          menuItem: menuItem,
          detailType: DetailType.level,
          isCart: isCart,
        ),
        const Divider(),
        MenuDetailList(
          menuItem: menuItem,
          detailType: DetailType.toping,
          isCart: isCart,
        ),
        const Divider(),
        MenuDetailList(
          menuItem: menuItem,
          detailType: DetailType.catatan,
          isCart: isCart,
        )
      ],
      const Divider(),
    ];
  }

  Widget _buildMenuImage(Map<String, dynamic> menuItem) {
    return SizedBox(
      height: 181.h,
      width: 378.w,
      child: Hero(
        tag: menuItem['id_menu'],
        child: CachedNetworkImage(
          imageUrl: menuItem['foto'],
          useOldImageOnUrlChange: true,
          color: Colors.grey[100],
          colorBlendMode: BlendMode.darken,
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  Widget _buildQuantityButton(
    Map<String, dynamic> menuItem,
    RxList<Map<String, dynamic>> dataSource,
    bool isCart,
  ) {
    return Container(
      margin: EdgeInsets.only(right: 10.w),
      width: menuItem['stok'] == true ? 73.w : 105.w,
      child: Obx(
        () {
          final matchedItem = dataSource
              .firstWhere((item) => item['id_menu'] == menuItem['id_menu']);
          return Row(
            mainAxisAlignment: matchedItem['jumlah'] == 0
                ? MainAxisAlignment.end
                : MainAxisAlignment.spaceBetween,
            children: [
              if (matchedItem['jumlah'] != 0) ...{
                CustomQuantityButton(
                  menu: menuItem,
                  isAdd: false,
                  editType: isCart ? EditType.cart : EditType.list,
                ),
                Text(
                  '${matchedItem['jumlah']}',
                  style: Get.textTheme.labelMedium!.copyWith(
                    fontWeight: FontWeight.w900,
                  ),
                ),
                CustomQuantityButton(
                  menu: menuItem,
                  editType: isCart ? EditType.cart : EditType.list,
                ),
              } else
                CustomQuantityButton(
                  menu: menuItem,
                  editType: isCart ? EditType.cart : EditType.list,
                ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildReactiveSubmitButton(
    Map<String, dynamic> menuItem,
    RxList<Map<String, dynamic>> dataSource,
  ) {
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
                'Tambahkan Ke Pesanan',
                style: Get.textTheme.bodyMedium!.copyWith(
                    color: MainColor.white,
                    fontWeight: FontWeight.w800,
                    fontSize: 14.sp),
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
