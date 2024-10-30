import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:venturo_food/configs/themes/main_color.dart';
import 'package:venturo_food/constants/cores/assets/image_constant.dart';
import 'package:venturo_food/features/main_menu/controllers/list_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:venturo_food/features/main_menu/views/components/menu_card.dart';
import 'package:venturo_food/features/main_menu/views/components/section_header.dart';

/// Used in main_menu_view.dart
class ListItem extends StatelessWidget {
  const ListItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Obx(
        () {
          final String listType = ListController.to.selectedCategory.value;
          final itemCount = ListController.to.filteredList.length;

          print('itemcount $itemCount');

          if (itemCount == 0) {
            return const Center(
              child: Text('Item Tidak Ditemukan'),
            );
          } else {
            return SmartRefresher(
              controller: ListController.to.refreshController,
              enablePullDown: true,
              onRefresh: ListController.to.onRefresh,
              enablePullUp: ListController.to.canLoadMore.isTrue,
              onLoading: ListController.to.getListOfData,
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 25.w),
                itemCount: ListController.to.filteredList.length + 1,
                itemBuilder: (context, index) {
                  /// Category Header
                  if (index == 0) {
                    final currentCategory =
                        ListController.to.selectedCategory.value;

                    if (itemCount < 5) {
                      return Container(
                        margin: EdgeInsets.only(top: 15.w, bottom: 4.w),
                        child: SectionHeader(
                          color: MainColor.primary,
                          title: ListController.to.filteredList[0]
                                      ["category"] ==
                                  'makanan'
                              ? 'Food'.tr
                              : ListController.to.filteredList[0]["category"] ==
                                      'snack'
                                  ? 'Snack'.tr
                                  : 'Beverages'.tr,
                          icon: SvgPicture.asset(
                            ListController.to.filteredList[0]["category"] ==
                                    'makanan'
                                ? ImageConstant.makananIconSvg
                                : ImageConstant.minumanIconSvg,
                            height: 14.h,
                          ),
                        ),
                      );
                    } else {
                      return Container(
                        margin: EdgeInsets.only(top: 15.w, bottom: 4.w),
                        child: SectionHeader(
                          color: MainColor.primary,
                          title: currentCategory == 'semua menu'
                              ? 'Food'.tr
                              : currentCategory == 'makanan'
                                  ? 'Food'.tr
                                  : currentCategory == 'snack'
                                      ? 'Snack'.tr
                                      : 'Beverages'.tr,
                          icon: SvgPicture.asset(
                            currentCategory == 'semua menu' ||
                                    currentCategory == 'makanan'
                                ? ImageConstant.makananIconSvg
                                : currentCategory == 'snack'
                                    ? ImageConstant.makananIconSvg
                                    : ImageConstant.minumanIconSvg,
                            height: 14.h,
                          ),
                        ),
                      );
                    }
                  } else if (listType == 'semua menu' &&
                      index == ListController.to.makananList.length &&
                      ListController.to.minumanList.isNotEmpty) {
                    return Container(
                      margin: EdgeInsets.only(top: 15.w),
                      child: SectionHeader(
                        color: MainColor.primary,
                        title: 'Beverages'.tr,
                        icon: SvgPicture.asset(
                          ImageConstant.minumanIconSvg,
                          height: 14.h,
                        ),
                      ),
                    );
                  } else if (listType == 'semua menu' &&
                      index ==
                          ListController.to.minumanList.length +
                              ListController.to.makananList.length &&
                      ListController.to.snackList.isNotEmpty) {
                    return Container(
                      margin: EdgeInsets.only(top: 15.w),
                      child: SectionHeader(
                        color: MainColor.primary,
                        title: 'Snack'.tr,
                        icon: SvgPicture.asset(
                          ImageConstant.makananIconSvg,
                          height: 14.h,
                        ),
                      ),
                    );
                  }

                  /// Menu Items
                  final item = ListController.to.filteredList[index - 1];
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.w),
                    child: Slidable(
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
                            Get.toNamed(
                              '/detail-menu',
                              arguments: {'item': item},
                            );
                          },
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}
