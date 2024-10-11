import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:venturo_food/configs/themes/main_color.dart';
import 'package:venturo_food/features/main_menu/controllers/list_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:venturo_food/features/main_menu/sub_features/checkout/controllers/checkout_controller.dart';
import 'package:venturo_food/shared/widgets/styles/google_text_style.dart';
import 'package:venturo_food/utils/enums/enum.dart';

/// Used in custom_bottom_sheet.dart
class CustomChoiceChip extends StatelessWidget {
  const CustomChoiceChip({
    super.key,
    required this.type,
    required this.menu,
    this.editType = EditType.list,
  });

  final String type;
  final Map<String, dynamic> menu;
  final EditType editType;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10.w,
      children: List<Widget>.generate(
        type == 'toping' ? 4 : 6,
        (int index) {
          final List<String> chipLabels = [
            'Tanpa Toping',
            'Mozarella',
            'Sosis',
            'Dimsum'
          ];

          return Obx(() {
            final items = ListController.to.items;
            final cart = CheckoutController.to.cart;
            final dataSource = editType == EditType.cart ? cart : items;
            final matchedItem = dataSource.firstWhere(
              (item) => item['id_menu'] == menu['id_menu'],
            );
            int topingIndex = chipLabels
                .indexWhere((label) => label == matchedItem['toping']);

            return GestureDetector(
              onTap: () {
                if (type == 'toping') {
                  CheckoutController.to.updateToping(
                      idMenu: menu['id_menu'],
                      newToping: chipLabels[index],
                      editType: editType);

                  Get.back();
                } else {
                  CheckoutController.to.updateLevel(
                      idMenu: menu['id_menu'],
                      newLevel: index,
                      editType: editType);

                  Get.back();
                }
              },
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 12.w,
                  vertical: 2.h,
                ),
                margin: EdgeInsets.only(bottom: 10.h),
                decoration: BoxDecoration(
                  color: type == 'toping'
                      ? topingIndex == index
                          ? MainColor.primary
                          : MainColor.white
                      : matchedItem['level'] == index
                          ? MainColor.primary
                          : MainColor.white,
                  border: Border.all(color: MainColor.primary),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (type == 'toping') ...{
                      Text(
                        chipLabels[index],
                        style: GoogleTextStyle.w400.copyWith(
                          fontSize: 14.sp,
                          color: topingIndex == index
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                      if (topingIndex == index) ...{
                        SizedBox(width: 8.w),
                        const Icon(
                          Icons.check,
                          size: 16,
                          color: Colors.white,
                        ),
                      },
                    } else ...{
                      Text(
                        '$index',
                        style: GoogleTextStyle.w400.copyWith(
                            color: matchedItem['level'] == index
                                ? Colors.white
                                : Colors.black,
                            fontSize: 14.sp),
                      ),
                      if (matchedItem['level'] == index) ...{
                        SizedBox(width: 8.w),
                        const Icon(
                          Icons.check,
                          size: 16,
                          color: Colors.white,
                        ),
                      },
                    }
                  ],
                ),
              ),
            );
          });
        },
      ).toList(),
    );
  }
}
