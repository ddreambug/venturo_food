import 'package:flutter/material.dart';
import 'package:venturo_food/constants/cores/assets/image_constant.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:venturo_food/features/main_menu/sub_features/checkout/controllers/checkout_controller.dart';
import 'package:venturo_food/shared/widgets/styles/google_text_style.dart';
import 'package:venturo_food/utils/enums/enum.dart';

/// Used in menu_detail_view.dart
/// Used in mainfeatures menu_card.dart
class CustomQuantityButton extends StatelessWidget {
  const CustomQuantityButton({
    super.key,
    required this.menu,
    this.isAdd = true,
    this.editType = EditType.list,
  });
  final Map<String, dynamic> menu;
  final bool isAdd;
  final EditType editType;

  @override
  Widget build(BuildContext context) {
    if (menu['stok'] == true) {
      return GestureDetector(
        onTap: () {
          if (isAdd) {
            CheckoutController.to.updateItemCount(
              idMenu: menu['id_menu'],
              modifier: 1,
              editType: editType,
            );
          } else {
            CheckoutController.to.updateItemCount(
              idMenu: menu['id_menu'],
              modifier: -1,
              editType: editType,
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
        style: GoogleTextStyle.w400.copyWith(fontSize: 16.sp),
      );
    }
  }
}
