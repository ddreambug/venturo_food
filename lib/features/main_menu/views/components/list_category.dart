import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:venturo_food/constants/cores/assets/image_constant.dart';
import 'package:venturo_food/features/main_menu/controllers/list_controller.dart';
import 'package:venturo_food/features/main_menu/views/components/menu_chip.dart';

/// Used in main_menu_view.dart
class ListCategory extends StatelessWidget {
  const ListCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 1.sw,
      height: 35.w,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: ListController.to.categories.length,
        padding: EdgeInsets.symmetric(horizontal: 25.w),
        itemBuilder: (context, index) {
          final category = ListController.to.categories[index];
          return Obx(
            () => MenuChip(
              onTap: () {
                ListController.to.selectedCategory(
                  category.toLowerCase(),
                );
              },
              isSelected: ListController.to.selectedCategory.value ==
                  category.toLowerCase(),
              text: category,
              icon: index == 0
                  ? ImageConstant.listIconSvg
                  : index == 1
                      ? ImageConstant.makananIconSvg
                      : index == 2
                          ? ImageConstant.minumanIconSvg
                          : ImageConstant.makananIconSvg,
            ),
          );
        },
        separatorBuilder: (context, index) => 13.horizontalSpace,
      ),
    );
  }
}
