import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:venturo_food/configs/themes/main_color.dart';
import 'package:venturo_food/features/main_menu/sub_features/checkout/controllers/checkout_controller.dart';
import 'package:venturo_food/features/main_menu/sub_features/checkout/views/components/checkout_bottom_navbar.dart';
import 'package:venturo_food/features/main_menu/views/components/custom_appbar.dart';
import 'package:venturo_food/constants/cores/assets/image_constant.dart';
import 'package:venturo_food/features/main_menu/sub_features/checkout/views/components/voucher_card.dart';
import 'package:get/get.dart';

class VoucherView extends StatelessWidget {
  const VoucherView({super.key});

  @override
  Widget build(BuildContext context) {
    final voucherList = CheckoutController.to.voucher;

    return SafeArea(
      child: Scaffold(
        bottomNavigationBar:
            const CheckoutBottomNavbar(checkoutNavbarType: 'voucher'),
        backgroundColor: MainColor.white,
        appBar: CustomAppbar(
          appBarTitle: 'Choose Voucher'.tr,
          icon: ImageConstant.voucherIcon,
        ),
        body: ListView.builder(
          padding: EdgeInsets.symmetric(horizontal: 25.w),
          itemCount: voucherList.length,
          itemBuilder: (context, index) {
            final voucher = voucherList[index];

            return Padding(
              padding: EdgeInsets.symmetric(vertical: 10.w),
              child: Material(
                borderRadius: BorderRadius.circular(20.r),
                elevation: 2,
                child: VoucherCard(voucher: voucher),
              ),
            );
          },
        ),
      ),
    );
  }
}
