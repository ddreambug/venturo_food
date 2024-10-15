import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:venturo_food/configs/themes/main_color.dart';
import 'package:venturo_food/features/main_menu/sub_features/checkout/controllers/checkout_controller.dart';
import 'package:venturo_food/features/main_menu/views/components/menu_card.dart';

class CheckoutCart extends StatelessWidget {
  const CheckoutCart({
    super.key,
    required this.context,
    required this.item,
  });

  final BuildContext context;
  final Map<String, dynamic> item;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.w),
      child: Slidable(
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              onPressed: (context) {
                CheckoutController.to.deleteCartItem(item['id_menu']);
              },
              borderRadius: BorderRadius.horizontal(
                right: Radius.circular(10.r),
              ),
              backgroundColor: const Color(0xFFFE4A49),
              foregroundColor: MainColor.white,
              icon: Icons.delete,
              label: 'Delete',
            ),
          ],
        ),
        child: Material(
          borderRadius: BorderRadius.circular(10.r),
          elevation: 2,
          child: MenuCard(
            menu: item,
            isSelected: CheckoutController.to.selectedItems.contains(item),
            isCart: true,
            onTap: () {
              Get.toNamed(
                '/detail-menu',
                arguments: {
                  'item': item,
                  'isCart': true,
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
