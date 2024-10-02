import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:venturo_food/constants/cores/assets/image_constant.dart';
import 'package:venturo_food/features/list/controllers/list_controller.dart';
import 'package:venturo_food/features/list/views/components/menu_chip.dart';

class ListCategory extends StatelessWidget {
  const ListCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        width: 1.sw,
        height: 35.h,
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
                        : ImageConstant.minumanIconSvg,
              ),
            );
          },
          separatorBuilder: (context, index) => 13.horizontalSpace,
        ),
      ),
    );
  }
}
