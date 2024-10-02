import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:venturo_food/features/list/controllers/list_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:venturo_food/features/list/views/components/menu_card.dart';

class ListItem extends StatelessWidget {
  const ListItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Obx(
        () => SmartRefresher(
          controller: ListController.to.refreshController,
          enablePullDown: true,
          onRefresh: ListController.to.onRefresh,
          enablePullUp: ListController.to.canLoadMore.isTrue ? true : false,
          onLoading: ListController.to.getListOfData,
          child: ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 25.w),
            itemBuilder: (context, index) {
              final item = ListController.to.filteredList[index];
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 8.5.h),
                child: Obx(() => Slidable(
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
                            foregroundColor: Colors.white,
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
                    )),
              );
            },
            itemCount: ListController.to.filteredList.length,
            itemExtent: 112.h,
          ),
        ),
      ),
    );
  }
}
