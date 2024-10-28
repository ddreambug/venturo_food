import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:venturo_food/features/main_menu/sub_features/checkout/views/components/custom_quantity_button.dart';
import 'package:venturo_food/shared/widgets/styles/google_text_style.dart';
import 'package:venturo_food/utils/enums/enum.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BuildQuantityButton extends StatelessWidget {
  const BuildQuantityButton({
    super.key,
    required this.menuItem,
    required this.dataSource,
    required this.isCart,
  });

  final Map<String, dynamic> menuItem;
  final RxList<Map<String, dynamic>> dataSource;
  final bool isCart;
  @override
  Widget build(BuildContext context) {
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
                  style: GoogleTextStyle.w500.copyWith(fontSize: 18.sp),
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
}
