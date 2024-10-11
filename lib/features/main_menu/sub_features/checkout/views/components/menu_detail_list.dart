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
import 'package:venturo_food/shared/widgets/styles/google_text_style.dart';
import 'package:venturo_food/utils/enums/enum.dart';
import 'package:venturo_food/features/main_menu/controllers/list_controller.dart';
import 'package:venturo_food/features/main_menu/sub_features/checkout/controllers/checkout_controller.dart';

class MenuDetailList extends StatelessWidget {
  const MenuDetailList({
    super.key,
    required this.menuItem,
    required this.detailType,
    this.isCart = false,
  });

  //variabel passed
  final Map<String, dynamic> menuItem;
  final DetailType detailType;
  final bool isCart;

  @override
  Widget build(BuildContext context) {
    final items = ListController.to.items;
    final cart = CheckoutController.to.cart;
    final dataSource = isCart ? cart : items;

    String listIcon;
    String listTitle;
    String listPrice = 'Rp ${NumberFormat('#,###', 'id_ID').format(
      menuItem['harga'],
    )}';

    //conditionaly render list
    if (detailType.name == 'harga') {
      listIcon = Bi.cash_coin;
      listTitle = 'Harga';
    } else if (detailType.name == 'level' &&
        menuItem['category'] == 'minuman') {
      listIcon = Ri.fire_line;
      listTitle = 'Level Gula';
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
          CheckoutController.to.showMenuProperty(
            menuItem,
            detailType,
            isCart ? EditType.cart : EditType.list,
          );
        }
      },
      child: Obx(() {
        final matchedItem = dataSource.firstWhere(
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
                style: GoogleTextStyle.w600.copyWith(fontSize: 14.sp),
              ),
            ),
            const Spacer(),
            SizedBox(
              width: 230.w,
              child: Text(
                detailType.name == 'catatan'
                    ? matchedItem['catatan']
                    : detailType.name == 'toping'
                        ? matchedItem['toping']
                        : detailType.name == 'level'
                            ? matchedItem['level'].toString()
                            : listPrice,
                style: detailType.name == 'harga'
                    ? GoogleTextStyle.w700.copyWith(
                        color: MainColor.primary,
                        fontSize: 15.sp,
                      )
                    : GoogleTextStyle.w400.copyWith(fontSize: 14.sp),
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
