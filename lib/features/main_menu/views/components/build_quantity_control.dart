import 'package:flutter/material.dart';
import 'package:venturo_food/features/main_menu/sub_features/checkout/views/components/custom_quantity_button.dart';
import 'package:venturo_food/shared/widgets/styles/google_text_style.dart';
import 'package:venturo_food/utils/enums/enum.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BuildQuantityControl extends StatelessWidget {
  const BuildQuantityControl({
    super.key,
    required this.stockMenu,
    required this.isCart,
    required this.matchedItem,
    required this.menu,
  });

  final bool stockMenu;
  final bool isCart;
  final Map<String, dynamic> matchedItem;
  final Map<String, dynamic> menu;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 10.w),
      width: menu['stok'] == true ? 73.w : 105.w,
      child: Row(
        mainAxisAlignment: matchedItem['jumlah'] == 0
            ? MainAxisAlignment.end
            : MainAxisAlignment.spaceBetween,
        children: [
          if (matchedItem['jumlah'] != 0) ...[
            CustomQuantityButton(
              menu: menu,
              isAdd: false,
              editType: isCart ? EditType.cart : EditType.list,
            ),
            Text(
              '${matchedItem['jumlah']}',
              style: GoogleTextStyle.w500.copyWith(fontSize: 18.sp),
            ),
            CustomQuantityButton(
              menu: menu,
              editType: isCart ? EditType.cart : EditType.list,
            ),
          ] else ...{
            CustomQuantityButton(
              menu: menu,
              editType: isCart ? EditType.cart : EditType.list,
            ),
          }
        ],
      ),
    );
  }
}
