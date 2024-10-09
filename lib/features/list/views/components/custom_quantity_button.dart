import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:venturo_food/constants/cores/assets/image_constant.dart';
import 'package:venturo_food/features/list/controllers/list_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomQuantityButton extends StatelessWidget {
  const CustomQuantityButton({
    super.key,
    required this.menu,
    this.isAdd = true,
  });
  final Map<String, dynamic> menu;
  final bool isAdd;

  @override
  Widget build(BuildContext context) {
    if (menu['stok'] == true) {
      return GestureDetector(
        onTap: () {
          if (isAdd) {
            ListController.to.updateItemCount(
              idMenu: menu['id_menu'],
              modifier: 1,
            );
          } else {
            ListController.to.updateItemCount(
              idMenu: menu['id_menu'],
              modifier: -1,
            );
          }
        },
        child: isAdd
            ? Image.asset(
                ImageConstant.plusIcon,
                height: 14,
                width: 14,
              )
            : Image.asset(
                ImageConstant.minusIcon,
                height: 14,
                width: 14,
              ),
      );
    } else {
      return Text(
        'Stok Habis',
        style: Get.textTheme.labelSmall!.copyWith(fontSize: 16.sp),
      );
    }
  }
}
