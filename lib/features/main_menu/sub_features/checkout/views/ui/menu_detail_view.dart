import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:venturo_food/configs/themes/main_color.dart';
import 'package:venturo_food/features/main_menu/constants/enum.dart';
import 'package:venturo_food/features/main_menu/controllers/list_controller.dart';
import 'package:venturo_food/features/main_menu/views/components/custom_appbar.dart';
import 'package:venturo_food/features/main_menu/views/components/custom_bottomnavbar.dart';
import 'package:venturo_food/features/main_menu/sub_features/checkout/views/components/custom_quantity_button.dart';
import 'package:venturo_food/features/main_menu/sub_features/checkout/views/components/menu_detail_list.dart';

class MenuDetailView extends StatelessWidget {
  const MenuDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    final items = ListController.to.items;
    final menuItem = Get.arguments as Map<String, dynamic>;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: const CustomAppbar(
          appBarTitle: 'Detail Menu',
          useIcon: false,
        ),
        bottomNavigationBar: Obx(
          () => CustomBottomnavbar(
            currentIndex: ListController.to.currentNavBarIndex.value,
          ),
        ),
        body: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 20.h),
            SizedBox(
              height: 181.h,
              width: 378.w,
              child: Hero(
                tag: menuItem['id_menu'],
                child: CachedNetworkImage(
                  imageUrl: menuItem['foto'],
                  useOldImageOnUrlChange: true,
                  color: Colors.grey[100],
                  colorBlendMode: BlendMode.darken,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(top: 20.h),
                decoration: const BoxDecoration(
                  color: MainColor.white,
                  borderRadius: BorderRadiusDirectional.vertical(
                    top: Radius.circular(30),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromARGB(21, 24, 24, 24),
                      blurRadius: 15,
                      spreadRadius: -1,
                      offset: Offset(0, 1),
                    ),
                  ],
                ),
                width: double.infinity,
                height: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            menuItem['name'],
                            style: Get.textTheme.displayMedium!.copyWith(
                                color: MainColor.primary,
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w900),
                          ),
                          const Spacer(),
                          Container(
                            margin: EdgeInsets.only(right: 10.w),
                            width: menuItem['stok'] == true ? 73.w : 105.w,
                            child: Obx(
                              () {
                                final matchedItem = items.firstWhere((item) =>
                                    item['id_menu'] == menuItem['id_menu']);
                                return Row(
                                  mainAxisAlignment: matchedItem['jumlah'] == 0
                                      ? MainAxisAlignment.end
                                      : MainAxisAlignment.spaceBetween,
                                  children: [
                                    if (matchedItem['jumlah'] != 0) ...{
                                      CustomQuantityButton(
                                        menu: menuItem,
                                        isAdd: false,
                                      ),
                                      Text(
                                        '${matchedItem['jumlah']}',
                                        style:
                                            Get.textTheme.labelMedium!.copyWith(
                                          fontWeight: FontWeight.w900,
                                        ),
                                      ),
                                      CustomQuantityButton(
                                        menu: menuItem,
                                      ),
                                    } else
                                      CustomQuantityButton(
                                        menu: menuItem,
                                      ),
                                  ],
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 8.h, bottom: 18.h),
                        child: Text(
                          menuItem['deskripsi'],
                          style: Get.textTheme.labelSmall!.copyWith(
                            fontSize: 12.sp,
                          ),
                        ),
                      ),
                      const Divider(),

                      /// Menu Property
                      MenuDetailList(
                        menuItem: menuItem,
                        detailType: DetailType.harga,
                      ),
                      const Divider(),
                      MenuDetailList(
                        menuItem: menuItem,
                        detailType: DetailType.level,
                      ),
                      const Divider(),
                      MenuDetailList(
                        menuItem: menuItem,
                        detailType: DetailType.toping,
                      ),
                      const Divider(),
                      MenuDetailList(
                        menuItem: menuItem,
                        detailType: DetailType.catatan,
                      ),
                      const Divider(),
                      SizedBox(height: 20.h),

                      ///reactive button
                      Obx(
                        () {
                          final matchedItem = items.firstWhere(
                              (item) => item['id_menu'] == menuItem['id_menu']);
                          if (matchedItem['jumlah'] > 0) {
                            return SizedBox(
                              width: double.infinity,
                              height: 42.w,
                              child: ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  side: const BorderSide(
                                    color: Color(0xFF00717F),
                                    width: 1,
                                  ),
                                ),
                                child: Text(
                                  'Tambahkan Ke Pesanan',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                          color: MainColor.white,
                                          fontWeight: FontWeight.w800,
                                          fontSize: 14.sp),
                                ),
                              ),
                            );
                          } else {
                            return const SizedBox.shrink();
                          }
                        },
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
