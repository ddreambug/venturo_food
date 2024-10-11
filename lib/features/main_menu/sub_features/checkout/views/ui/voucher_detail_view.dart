import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:venturo_food/configs/themes/main_color.dart';
import 'package:venturo_food/features/main_menu/sub_features/checkout/controllers/checkout_controller.dart';
import 'package:venturo_food/features/main_menu/sub_features/checkout/views/components/checkout_bottom_navbar.dart';
import 'package:venturo_food/features/main_menu/sub_features/checkout/views/components/checkout_price_detail.dart';
import 'package:venturo_food/features/main_menu/views/components/custom_appbar.dart';
import 'package:venturo_food/constants/cores/assets/image_constant.dart';
import 'package:venturo_food/features/main_menu/views/components/menu_card.dart';
import 'package:venturo_food/features/main_menu/views/components/section_header.dart';

class VoucherDetailView extends StatelessWidget {
  const VoucherDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    final cartItem = CheckoutController.to.cart;

    return SafeArea(
      child: Scaffold(
          bottomNavigationBar:
              cartItem.isNotEmpty ? const CheckoutBottomNavbar() : null,
          backgroundColor: MainColor.white,
          appBar: const CustomAppbar(
            appBarTitle: 'Pilih Voucher',
            icon: ImageConstant.voucherIcon,
          ),
          body: Obx(
            () {
              return Stack(
                children: [
                  Column(
                    children: [
                      SizedBox(
                        height: 430.h,
                        child: Obx(
                          () {
                            final makananItems =
                                CheckoutController.to.makananCart;
                            final minumanItems =
                                CheckoutController.to.minumanCart;

                            return ListView.builder(
                              padding: EdgeInsets.symmetric(horizontal: 25.w),
                              itemCount: minumanItems.isNotEmpty
                                  ? cartItem.length + 2
                                  : makananItems.length + 1,
                              itemBuilder: (context, index) {
                                if (index == 0 && makananItems.isNotEmpty) {
                                  // Makanan Section Header
                                  return Container(
                                    margin:
                                        EdgeInsets.only(top: 15.w, bottom: 4.w),
                                    child: SectionHeader(
                                      color: MainColor.primary,
                                      title: 'Makanan',
                                      icon: SvgPicture.asset(
                                        ImageConstant.makananIconSvg,
                                        height: 14.h,
                                      ),
                                    ),
                                  );
                                } else if (index > 0 &&
                                    index <= makananItems.length) {
                                  // Makanan Items
                                  final item = makananItems[index - 1];
                                  return _buildCartItem(context, item);
                                } else if (index == makananItems.length + 1 &&
                                    minumanItems.isNotEmpty) {
                                  // Minuman Section Header
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
                                } else {
                                  // Minuman Items
                                  final minumanIndex =
                                      index - (makananItems.length + 2);
                                  final item = minumanItems[minumanIndex];
                                  return _buildCartItem(context, item);
                                }
                              },
                            );
                          },
                        ),
                      ),
                      CheckoutPriceDetail(cartItem: cartItem),
                    ],
                  ),
                ],
              );
            },
          )),
    );
  }

  Widget _buildCartItem(BuildContext context, Map<String, dynamic> item) {
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
