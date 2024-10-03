import 'package:flutter/material.dart';
import 'package:venturo_food/constants/cores/assets/image_constant.dart';
import 'package:venturo_food/features/list/controllers/list_controller.dart';

class CustomQuantityButton extends StatelessWidget {
  const CustomQuantityButton({
    super.key,
    required this.idMenu,
    this.isAdd = true,
  });
  final int idMenu;
  final bool isAdd;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (isAdd) {
          ListController.to.updateItemCount(
            idMenu: idMenu,
            modifier: 1,
          );
        } else {
          ListController.to.updateItemCount(
            idMenu: idMenu,
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
  }
}
