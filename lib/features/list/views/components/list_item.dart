import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:venturo_food/configs/themes/main_color.dart';
import 'package:venturo_food/constants/cores/assets/image_constant.dart';
import 'package:venturo_food/features/list/controllers/list_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:venturo_food/features/list/views/components/menu_card.dart';
import 'package:venturo_food/features/list/views/components/section_header.dart';

class ListItem extends StatelessWidget {
  const ListItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Obx(
        () {
          final String listType = ListController.to.selectedCategory.value;
          return SmartRefresher(
            controller: ListController.to.refreshController,
            enablePullDown: true,
            onRefresh: ListController.to.onRefresh,
            enablePullUp: ListController.to.canLoadMore.isTrue ? true : false,
            onLoading: ListController.to.getListOfData,
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 25.w),
              itemCount: ListController.to.filteredList.length + 1,
              itemBuilder: (context, index) {
                /// Item Category
                if (index == 0) {
                  return Obx(() {
                    final currentCategory =
                        ListController.to.selectedCategory.value;
                    return Container(
                      margin: EdgeInsets.only(top: 15.w, bottom: 4.w),
                      child: SectionHeader(
                        color: MainColor.primary,
                        title: currentCategory == 'semua menu'
                            ? 'Makanan'
                            : currentCategory == 'makanan'
                                ? 'Makanan'
                                : 'Minuman',
                        icon: currentCategory == 'semua menu'
                            ? SvgPicture.asset(
                                ImageConstant.makananIconSvg,
                                height: 14.h,
                              )
                            : currentCategory == 'makanan'
                                ? SvgPicture.asset(
                                    ImageConstant.makananIconSvg,
                                    height: 14.h,
                                  )
                                : SvgPicture.asset(
                                    ImageConstant.minumanIconSvg,
                                    height: 14.h,
                                  ),
                      ),
                    );
                  });
                } else if (index == ListController.to.makananList.length &&
                    listType == 'semua menu' &&
                    ListController.to.minumanList.isNotEmpty) {
                  return Container(
                    margin: EdgeInsets.only(top: 15.w),
                    child: SectionHeader(
                      color: MainColor.primary,
                      title: 'Minuman',
                      icon: SvgPicture.asset(
                        ImageConstant.minumanIconSvg,
                      ),
                    ),
                  );
                }

                /// items
                final item = ListController.to.filteredList[index - 1];
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.w),
                  child: Obx(
                    () {
                      return Slidable(
                        endActionPane: ActionPane(
                          motion: const ScrollMotion(),
                          children: [
                            SlidableAction(
                              onPressed: (context) {
                                ListController.to.deleteItem(item);
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
                            isSelected:
                                ListController.to.selectedItems.contains(item),
                            onTap: () {
                              if (ListController.to.selectedItems
                                  .contains(item)) {
                                ListController.to.selectedItems.remove(item);
                              } else {
                                ListController.to.selectedItems.add(item);
                              }
                              // edit ontap untuk nampilin detail disini
                            },
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
