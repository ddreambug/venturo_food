import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:venturo_food/configs/themes/main_color.dart';
import 'package:venturo_food/constants/cores/assets/image_constant.dart';
import 'package:venturo_food/features/main_menu/sub_features/checkout/controllers/checkout_controller.dart';
import 'package:venturo_food/shared/widgets/styles/google_text_style.dart';
import 'package:venturo_food/utils/enums/enum.dart';

class BuildMenuInfo extends StatelessWidget {
  const BuildMenuInfo({
    super.key,
    required this.nameMenu,
    required this.priceMenu,
    required this.matchedItem,
    required this.catatanMenu,
    required this.menu,
    required this.isCart,
  });

  final String nameMenu;
  final int priceMenu;
  final String catatanMenu;
  final Map<String, dynamic> matchedItem;
  final Map<String, dynamic> menu;
  final bool isCart;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: (matchedItem['stok'] == true && matchedItem['jumlah'] > 0)
          ? EdgeInsets.only(top: 6.h)
          : EdgeInsets.only(top: 17.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            nameMenu,
            style: GoogleTextStyle.w500.copyWith(fontSize: 23.sp),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            softWrap: true,
          ),
          Text(
            'Rp ${NumberFormat('#,###', 'id_ID').format(priceMenu)}',
            style: GoogleTextStyle.w800.copyWith(
              fontSize: 18.sp,
              color: MainColor.primary,
            ),
          ),
          SizedBox(height: 4.w),
          if (matchedItem['stok'] == true && matchedItem['jumlah'] > 0) ...{
            SizedBox(
              height: 20.h,
              child: GestureDetector(
                onTap: () {
                  CheckoutController.to.showMenuProperty(
                    menu,
                    DetailType.catatan,
                    isCart ? EditType.cart : EditType.list,
                  );
                },
                child: Row(
                  children: [
                    Image.asset(ImageConstant.listEdit),
                    SizedBox(width: 5.w),
                    Expanded(
                      child: Text(
                        catatanMenu,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleTextStyle.w500.copyWith(
                          fontSize: 12.sp,
                          color: MainColor.grey,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          }
        ],
      ),
    );
  }
}
