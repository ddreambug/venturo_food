import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:venturo_food/features/main_menu/views/components/build_menu_image.dart';
import 'package:venturo_food/features/main_menu/views/components/build_menu_info.dart';
import 'package:venturo_food/features/main_menu/views/components/build_quantity_control.dart';
import 'package:venturo_food/features/main_menu/controllers/list_controller.dart';
import 'package:venturo_food/features/main_menu/sub_features/checkout/controllers/checkout_controller.dart';

/// Used in list_item.dart
class MenuCard extends StatelessWidget {
  const MenuCard({
    super.key,
    required this.menu,
    this.onTap,
    this.isSelected = false,
    this.isCart = false,
  });

  final Map<String, dynamic> menu;
  final bool isSelected;
  final void Function()? onTap;
  final bool isCart;

  @override
  Widget build(BuildContext context) {
    final items = ListController.to.items;
    final cart = CheckoutController.to.cart;
    final dataSource = isCart ? cart : items;
    final matchedItem = dataSource.firstWhere(
      (item) => item['id_menu'] == menu['id_menu'],
    );

    return InkWell(
      onTap: menu['stok'] == true ? onTap : null,
      borderRadius: BorderRadius.circular(10.r),
      child: Ink(
        padding: EdgeInsets.all(0.r),
        height: 89.h,
        decoration: BoxDecoration(
          backgroundBlendMode: BlendMode.darken,
          color: const Color.fromARGB(67, 219, 219, 219),
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(
            color: isSelected ? Get.theme.primaryColor : Colors.transparent,
            width: 2.w,
          ),
        ),
        child: Stack(
          children: [
            Row(
              children: [
                BuildMenuImage(idMenu: menu['id_menu'], fotoMenu: menu['foto']),
                Expanded(
                  child: BuildMenuInfo(
                    nameMenu: menu['name'],
                    priceMenu: menu['harga'],
                    matchedItem: matchedItem,
                    catatanMenu: menu['catatan'],
                    menu: menu,
                    isCart: isCart,
                  ),
                ),
                BuildQuantityControl(
                  stockMenu: menu['stok'],
                  isCart: isCart,
                  matchedItem: matchedItem,
                  menu: menu,
                ),
              ],
            ),
            if (menu['stok'] == false) ...{
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                ),
              )
            },
          ],
        ),
      ),
    );
  }
}
