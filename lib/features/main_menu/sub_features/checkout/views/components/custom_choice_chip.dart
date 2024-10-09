import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:venturo_food/configs/themes/main_color.dart';
import 'package:venturo_food/features/main_menu/controllers/list_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:venturo_food/features/main_menu/sub_features/checkout/controllers/checkout_controller.dart';

/// Used in custom_bottom_sheet.dart
class CustomChoiceChip extends StatelessWidget {
  const CustomChoiceChip({
    super.key,
    required this.type,
    required this.menu,
  });

  final String type;
  final Map<String, dynamic> menu;
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
            final matchedItem = items.firstWhere(
              (item) => item['id_menu'] == menu['id_menu'],
            );
            int topingIndex = chipLabels
                .indexWhere((label) => label == matchedItem['toping']);

            return GestureDetector(
              onTap: () {
                if (type == 'toping') {
                  CheckoutController.to.updateToping(
                      idMenu: menu['id_menu'], newToping: chipLabels[index]);
                } else {
                  CheckoutController.to
                      .updateLevel(idMenu: menu['id_menu'], newLevel: index);
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
                      Text(chipLabels[index],
                          style: Get.textTheme.labelSmall!.copyWith(
                              color: topingIndex == index
                                  ? Colors.white
                                  : Colors.black,
                              fontSize: 14.sp)),
                      if (topingIndex == index) ...{
                        SizedBox(width: 8.w),
                        const Icon(
                          Icons.check,
                          size: 16,
                          color: Colors.white,
                        ),
                      },
                    } else ...{
                      Text('$index',
                          style: Get.textTheme.labelSmall!.copyWith(
                              color: matchedItem['level'] == index
                                  ? Colors.white
                                  : Colors.black,
                              fontSize: 14.sp)),
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
