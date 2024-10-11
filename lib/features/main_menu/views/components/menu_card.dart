import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:venturo_food/configs/themes/main_color.dart';
import 'package:venturo_food/constants/cores/assets/image_constant.dart';
import 'package:venturo_food/shared/widgets/styles/google_text_style.dart';
import 'package:venturo_food/utils/enums/enum.dart';
import 'package:venturo_food/features/main_menu/controllers/list_controller.dart';
import 'package:venturo_food/features/main_menu/sub_features/checkout/controllers/checkout_controller.dart';
import 'package:venturo_food/features/main_menu/sub_features/checkout/views/components/custom_quantity_button.dart';

/// Used in list_item.dart
class MenuCard extends StatelessWidget {
  const MenuCard({
    super.key,
    required this.menu,
    this.onTap,
    this.isSelected = false,
    this.isCart = false,
  });

  final Map<String, dynamic> menu;
  final bool isSelected;
  final void Function()? onTap;
  final bool isCart;

  @override
  Widget build(BuildContext context) {
    final items = ListController.to.items;
    final cart = CheckoutController.to.cart;
    final dataSource = isCart ? cart : items;
    final matchedItem =
        dataSource.firstWhere((item) => item['id_menu'] == menu['id_menu']);

    return InkWell(
      onTap: menu['stok'] == true ? onTap : null,
      borderRadius: BorderRadius.circular(10.r),
      child: Ink(
        padding: EdgeInsets.all(0.r),
        height: 89.h,
        decoration: BoxDecoration(
          backgroundBlendMode: BlendMode.darken,
          color: const Color.fromARGB(67, 219, 219, 219),
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(
            color: isSelected ? Get.theme.primaryColor : Colors.transparent,
            width: 2.w,
          ),
        ),
        child: Stack(
          children: [
            Row(
              children: [
                _buildMenuImage(),
                Expanded(child: _buildMenuInfo(matchedItem)),
                _buildQuantityControl(matchedItem),
              ],
            ),
            if (menu['stok'] == false) _buildNoStockEffect(),
          ],
        ),
      ),
    );
  }

  /// Gambar
  Widget _buildMenuImage() {
    return Container(
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
    );
  }

  /// Info
  Widget _buildMenuInfo(Map<String, dynamic> matchedItem) {
    return Container(
      margin: (matchedItem['stok'] == true && matchedItem['jumlah'] > 0)
          ? EdgeInsets.only(top: 6.h)
          : EdgeInsets.only(top: 17.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            menu['name'],
            style: GoogleTextStyle.w500.copyWith(fontSize: 23.sp),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            softWrap: true,
          ),
          Text(
            'Rp ${NumberFormat('#,###', 'id_ID').format(menu['harga'])}',
            style: GoogleTextStyle.w800.copyWith(
              fontSize: 18.sp,
              color: MainColor.primary,
            ),
          ),
          SizedBox(height: 4.w),
          if (matchedItem['stok'] == true && matchedItem['jumlah'] > 0)
            _buildCatatan(),
        ],
      ),
    );
  }

  /// Catatan
  Widget _buildCatatan() {
    return SizedBox(
      height: 20.h,
      child: GestureDetector(
        onTap: () {
          CheckoutController.to.showMenuProperty(
            menu,
            DetailType.catatan,
            isCart ? EditType.cart : EditType.list,
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
                style: GoogleTextStyle.w500.copyWith(
                  fontSize: 12.sp,
                  color: MainColor.grey,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Jumlah
  Widget _buildQuantityControl(Map<String, dynamic> matchedItem) {
    return Container(
      margin: EdgeInsets.only(right: 10.w),
      width: menu['stok'] == true ? 73.w : 105.w,
      child: Row(
        mainAxisAlignment: matchedItem['jumlah'] == 0
            ? MainAxisAlignment.end
            : MainAxisAlignment.spaceBetween,
        children: [
          if (matchedItem['jumlah'] != 0) ...[
            CustomQuantityButton(
              menu: menu,
              isAdd: false,
              editType: isCart ? EditType.cart : EditType.list,
            ),
            Text(
              '${matchedItem['jumlah']}',
              style: GoogleTextStyle.w500.copyWith(fontSize: 18.sp),
            ),
            CustomQuantityButton(
              menu: menu,
              editType: isCart ? EditType.cart : EditType.list,
            ),
          ] else
            CustomQuantityButton(
              menu: menu,
              editType: isCart ? EditType.cart : EditType.list,
            ),
        ],
      ),
    );
  }

  /// Efek no Stock
  Widget _buildNoStockEffect() {
    return Positioned.fill(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.5),
          borderRadius: BorderRadius.circular(10.r),
        ),
      ),
    );
  }
}
