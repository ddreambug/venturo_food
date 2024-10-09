import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/ic.dart';
import 'package:iconify_flutter/icons/bi.dart';
import 'package:iconify_flutter/icons/ep.dart';
import 'package:iconify_flutter/icons/ri.dart';
import 'package:iconify_flutter/icons/la.dart';
import 'package:venturo_food/configs/themes/main_color.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:venturo_food/features/main_menu/constants/enum.dart';
import 'package:venturo_food/features/main_menu/controllers/list_controller.dart';
import 'package:venturo_food/features/main_menu/sub_features/checkout/controllers/checkout_controller.dart';

class MenuDetailList extends StatelessWidget {
  const MenuDetailList({
    super.key,
    required this.menuItem,
    required this.detailType,
  });

  //variabel passed
  final Map<String, dynamic> menuItem;
  final DetailType detailType;

  @override
  Widget build(BuildContext context) {
    String listIcon;
    String listTitle;
    String listPrice = 'Rp ${NumberFormat('#,###', 'id_ID').format(
      menuItem['harga'],
    )}';

    //conditionaly render list
    if (detailType.name == 'harga') {
      listIcon = Bi.cash_coin;
      listTitle = 'Harga';
    } else if (detailType.name == 'level') {
      listIcon = Ri.fire_line;
      listTitle = 'Level';
    } else if (detailType.name == 'toping') {
      listIcon = La.cheese;
      listTitle = 'Toping';
    } else {
      listIcon = Ic.round_edit_note;
      listTitle = 'Catatan';
    }

    //ontap bottomdialog
    return GestureDetector(
      onTap: () {
        if (detailType.name == 'harga') {
          null;
        } else {
          CheckoutController.to.showMenuProperty(menuItem, detailType);
        }
      },
      child: Obx(() {
        final items = ListController.to.items;
        final matchedItem = items.firstWhere(
          (item) => item['id_menu'] == menuItem['id_menu'],
        );

        return Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Iconify(
              listIcon,
              color: const Color.fromRGBO(44, 139, 164, 1),
              size: 18.w,
            ),
            SizedBox(width: 8.w),
            Padding(
              padding: EdgeInsets.only(bottom: 1.h),
              child: Text(
                listTitle,
                style: Get.textTheme.labelSmall!.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 14.sp,
                ),
              ),
            ),
            const Spacer(),
            SizedBox(
              width: 240.w,
              child: Text(
                detailType.name == 'catatan'
                    ? matchedItem['catatan']
                    : detailType.name == 'toping'
                        ? matchedItem['toping']
                        : detailType.name == 'level'
                            ? matchedItem['level'].toString()
                            : listPrice,
                style: Get.textTheme.titleSmall!.copyWith(
                  color: detailType.name == 'harga'
                      ? Theme.of(context).primaryColor
                      : MainColor.black,
                  fontSize: 16.sp,
                  fontWeight: detailType.name == 'harga'
                      ? FontWeight.w900
                      : FontWeight.w100,
                ),
                textAlign: TextAlign.end,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            if (detailType.name != 'harga') ...{
              SizedBox(width: 5.w),
              Iconify(
                Ep.arrow_right_bold,
                size: 14.w,
                color: MainColor.grey,
              )
            },
          ],
        );
      }),
    );
  }
}
