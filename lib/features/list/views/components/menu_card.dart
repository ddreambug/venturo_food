import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:venturo_food/configs/themes/main_color.dart';
import 'package:venturo_food/constants/cores/assets/image_constant.dart';
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
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10.r),
      child: Ink(
        padding: EdgeInsets.all(0.r),
        height: 89.h,
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(
            color: isSelected
                ? Theme.of(context).primaryColor
                : Colors.transparent,
            width: 2.w,
          ),
        ),
        child: Row(
          children: [
            // Menu Image
            Container(
              height: 75.w,
              width: 75.w,
              margin: EdgeInsets.only(right: 12.r, left: 5.w),
              padding: EdgeInsets.all(3.r),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                color: const Color.fromARGB(255, 223, 223, 223),
              ),
              child: CachedNetworkImage(
                imageUrl: menu['foto'] ??
                    'https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/240px-No_image_available.svg.png',
                useOldImageOnUrlChange: true,
                color: const Color.fromARGB(255, 223, 223, 223),
                colorBlendMode: BlendMode.darken,
                fit: BoxFit.contain,
              ),
            ),

            // Menu Info
            Expanded(
              child: Container(
                margin: EdgeInsets.only(top: 2.h),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      menu['name'],
                      style: Get.textTheme.titleMedium!.copyWith(
                        fontWeight: FontWeight.w500,
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
                    GestureDetector(
                      onTap: () {
                        print('tambah catatan');
                      },
                      child: SizedBox(
                        height: 20.h,
                        child: Row(
                          children: [
                            Image.asset(ImageConstant.listEdit),
                            SizedBox(width: 5.w),
                            Text('Tambahkan Catatan',
                                overflow: TextOverflow.ellipsis,
                                style: Get.textTheme.labelMedium!.copyWith(
                                  fontSize: 12.sp,
                                  color: MainColor.grey,
                                )),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),

            // Menu Quantity
            Container(
              margin: EdgeInsets.only(right: 5.w),
              width: 73.w,
              child: Obx(() {
                final items = ListController.to.items;
                final matchedItem = items
                    .firstWhere((item) => item['id_menu'] == menu['id_menu']);
                return Row(
                  mainAxisAlignment: matchedItem['jumlah'] == 0
                      ? MainAxisAlignment.end
                      : MainAxisAlignment.spaceBetween,
                  children: [
                    if (matchedItem['jumlah'] != 0) ...{
                      CustomQuantityButton(
                        idMenu: menu['id_menu'],
                        isAdd: false,
                      ),
                      Text(
                        '${matchedItem['jumlah']}',
                        style: Get.textTheme.labelMedium!.copyWith(
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      CustomQuantityButton(
                        idMenu: menu['id_menu'],
                      ),
                    } else
                      CustomQuantityButton(
                        idMenu: menu['id_menu'],
                      ),
                  ],
                );
              }),
            )
          ],
        ),
      ),
    );
  }
}
