import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/ep.dart';
import 'package:iconify_flutter/icons/la.dart';
import 'package:venturo_food/configs/themes/main_color.dart';
import 'package:venturo_food/features/main_menu/sub_features/checkout/controllers/checkout_controller.dart';
import 'package:venturo_food/features/main_menu/sub_features/checkout/views/components/checkout_bottom_navbar.dart';
import 'package:venturo_food/features/main_menu/views/components/custom_appbar.dart';
import 'package:venturo_food/constants/cores/assets/image_constant.dart';
import 'package:venturo_food/features/main_menu/views/components/menu_card.dart';
import 'package:venturo_food/features/main_menu/views/components/section_header.dart';

class CheckoutView extends StatelessWidget {
  const CheckoutView({super.key});

  @override
  Widget build(BuildContext context) {
    final cartItem = CheckoutController.to.cart;

    return SafeArea(
      child: Scaffold(
          bottomNavigationBar:
              cartItem.isNotEmpty ? const CheckoutBottomNavbar() : null,
          backgroundColor: MainColor.white,
          appBar: const CustomAppbar(
            appBarTitle: 'Pesanan',
            icon: ImageConstant.pesananIcon,
          ),
          body: Obx(
            () {
              if (cartItem.isEmpty) {
                return _buildPesananKosong();
              } else {
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
                                      margin: EdgeInsets.only(
                                          top: 15.w, bottom: 4.w),
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
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(top: 20.h),
                            decoration: const BoxDecoration(
                              color: Color.fromARGB(102, 230, 230, 230),
                              borderRadius: BorderRadiusDirectional.vertical(
                                top: Radius.circular(30),
                              ),
                            ),
                            width: double.infinity,
                            child: SingleChildScrollView(
                              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Total Row
                                  _buildTotalRow(),
                                  const Divider(),

                                  // Discount Row
                                  _buildDiscountRow(),
                                  const Divider(),

                                  // Voucher Row
                                  _buildVoucherRow(),
                                  const Divider(),

                                  // Payment Row
                                  _buildPaymentRow(),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              }
            },
          )),
    );
  }

  Widget _buildPesananKosong() {
    return const Center(
      child: Text('Pesanan Kosong!'),
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

  Widget _buildTotalRow() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text.rich(
          TextSpan(
            text: 'Total Pesanan ',
            style: Get.textTheme.bodyMedium!.copyWith(
              fontWeight: FontWeight.w900,
              fontSize: 16.sp,
            ),
            children: [
              TextSpan(
                text: '(3 Menu) :',
                style: Get.textTheme.labelSmall!.copyWith(
                  fontWeight: FontWeight.w300,
                ),
              ),
            ],
          ),
        ),
        const Spacer(),
        Text(
          'Rp 30.000',
          style: Get.textTheme.bodyMedium!.copyWith(
            color: MainColor.primary,
            fontSize: 14.sp,
            fontWeight: FontWeight.w900,
          ),
          textAlign: TextAlign.end,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  Widget _buildDiscountRow() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(ImageConstant.discountIcon, width: 22.w),
        SizedBox(width: 8.w),
        Text(
          'Diskon 20%',
          style: Get.textTheme.bodyMedium!.copyWith(
            fontWeight: FontWeight.w900,
            fontSize: 16.sp,
          ),
        ),
        const Spacer(),
        Text(
          'Rp 4.000',
          style: Get.textTheme.titleSmall!.copyWith(
            color: MainColor.danger,
            fontSize: 14.sp,
            fontWeight: FontWeight.w100,
          ),
          textAlign: TextAlign.end,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        Iconify(Ep.arrow_right_bold, size: 14.w, color: MainColor.grey),
      ],
    );
  }

  Widget _buildVoucherRow() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(ImageConstant.voucherIcon, width: 22.w),
        SizedBox(width: 8.w),
        Text(
          'Voucher',
          style: Get.textTheme.bodyMedium!.copyWith(
            fontWeight: FontWeight.w900,
            fontSize: 16.sp,
          ),
        ),
        const Spacer(),
        Text(
          'harga',
          style: Get.textTheme.titleSmall!.copyWith(
            color: MainColor.black,
            fontSize: 14.sp,
            fontWeight: FontWeight.w100,
          ),
          textAlign: TextAlign.end,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        Iconify(Ep.arrow_right_bold, size: 14.w, color: MainColor.grey),
      ],
    );
  }

  Widget _buildPaymentRow() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Iconify(La.coins,
            color: const Color.fromRGBO(44, 139, 164, 1), size: 24.w),
        SizedBox(width: 8.w),
        Text(
          'Pembayaran',
          style: Get.textTheme.bodyMedium!.copyWith(
            fontWeight: FontWeight.w900,
            fontSize: 16.sp,
          ),
        ),
        const Spacer(),
        Text(
          'Pay Later',
          style: Get.textTheme.titleSmall!.copyWith(
            color: MainColor.black,
            fontSize: 14.sp,
            fontWeight: FontWeight.w100,
          ),
          textAlign: TextAlign.end,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
