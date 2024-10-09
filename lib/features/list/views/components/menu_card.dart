import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:venturo_food/configs/themes/main_color.dart';
import 'package:venturo_food/constants/cores/assets/image_constant.dart';
import 'package:venturo_food/features/list/constants/enum.dart';
import 'package:venturo_food/features/list/controllers/list_controller.dart';
import 'package:venturo_food/features/list/views/components/custom_quantity_button.dart';

class MenuCard extends StatelessWidget {
  const MenuCard({
    super.key,
    required this.menu,
    this.onTap,
    this.isSelected = false,
  });

  final Map<String, dynamic> menu;
  final bool isSelected;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final items = ListController.to.items;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10.r),
      child: Ink(
        padding: EdgeInsets.all(0.r),
        height: 89.h,
        decoration: BoxDecoration(
          backgroundBlendMode: BlendMode.darken,
          color: const Color.fromARGB(67, 219, 219, 219),
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(
            color: isSelected
                ? Theme.of(context).primaryColor
                : Colors.transparent,
            width: 2.w,
          ),
        ),
        child: Stack(
          children: [
            /// List builder per menu
            Row(
              children: [
                /// Menu Image
                Container(
                  height: 75.w,
                  width: 75.w,
                  margin: EdgeInsets.only(right: 12.r, left: 5.w),
                  padding: EdgeInsets.all(3.r),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    color: const Color.fromARGB(255, 223, 223, 223),
                  ),
                  child: Hero(
                    tag: menu['id_menu'],
                    child: CachedNetworkImage(
                      imageUrl: menu['foto'] ??
                          'https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/240px-No_image_available.svg.png',
                      useOldImageOnUrlChange: true,
                      color: const Color.fromARGB(255, 223, 223, 223),
                      colorBlendMode: BlendMode.darken,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),

                /// Menu Info
                Expanded(
                  child: Obx(
                    () {
                      final matchedItem = items.firstWhere(
                          (item) => item['id_menu'] == menu['id_menu']);
                      return Container(
                        margin: (matchedItem['stok'] == true &&
                                matchedItem['jumlah'] > 0)
                            ? EdgeInsets.only(top: 6.h)
                            : EdgeInsets.only(top: 17.h),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              menu['name'],
                              style: Get.textTheme.titleSmall!.copyWith(
                                fontWeight: FontWeight.w600,
                                fontSize: 23.sp,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              softWrap: true,
                            ),
                            Text(
                              'Rp ${NumberFormat('#,###', 'id_ID').format(menu['harga'])}',
                              style: Get.textTheme.bodyMedium!.copyWith(
                                color: Theme.of(context).primaryColor,
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            SizedBox(height: 4.w),
                            Obx(
                              () {
                                final matchedItem = items.firstWhere((item) =>
                                    item['id_menu'] == menu['id_menu']);

                                if (matchedItem['stok'] == true &&
                                    matchedItem['jumlah'] > 0) {
                                  return SizedBox(
                                    height: 20.h,
                                    child: GestureDetector(
                                      onTap: () {
                                        ListController.to.showMenuProperty(
                                          menu,
                                          DetailType.catatan,
                                        );
                                      },
                                      child: Row(
                                        children: [
                                          Image.asset(ImageConstant.listEdit),
                                          SizedBox(width: 5.w),
                                          Expanded(
                                            child: Text(
                                              menu['catatan'],
                                              overflow: TextOverflow.ellipsis,
                                              style: Get.textTheme.labelMedium!
                                                  .copyWith(
                                                fontSize: 12.sp,
                                                color: MainColor.grey,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                } else {
                                  return const SizedBox.shrink();
                                }
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),

                /// Menu Quantity
                Container(
                  margin: EdgeInsets.only(right: 10.w),
                  width: menu['stok'] == true ? 73.w : 105.w,
                  child: Obx(
                    () {
                      final matchedItem = items.firstWhere(
                          (item) => item['id_menu'] == menu['id_menu']);
                      return Row(
                        mainAxisAlignment: matchedItem['jumlah'] == 0
                            ? MainAxisAlignment.end
                            : MainAxisAlignment.spaceBetween,
                        children: [
                          if (matchedItem['jumlah'] != 0) ...{
                            CustomQuantityButton(
                              menu: menu,
                              isAdd: false,
                            ),
                            Text(
                              '${matchedItem['jumlah']}',
                              style: Get.textTheme.labelMedium!.copyWith(
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            CustomQuantityButton(
                              menu: menu,
                            ),
                          } else
                            CustomQuantityButton(
                              menu: menu,
                            ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),

            /// Out of stok efek
            if (menu['stok'] == false)
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
