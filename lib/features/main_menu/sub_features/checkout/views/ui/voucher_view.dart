import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:venturo_food/configs/themes/main_color.dart';
import 'package:venturo_food/features/main_menu/sub_features/checkout/controllers/checkout_controller.dart';
import 'package:venturo_food/features/main_menu/sub_features/checkout/views/components/checkout_bottom_navbar.dart';
import 'package:venturo_food/features/main_menu/views/components/custom_appbar.dart';
import 'package:venturo_food/constants/cores/assets/image_constant.dart';

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
        appBar: const CustomAppbar(
          appBarTitle: 'Pilih Voucher',
          icon: ImageConstant.voucherIcon,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height - 120.h,
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 25.w),
                  itemCount: voucherList.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.w),
                      child: Material(
                        borderRadius: BorderRadius.circular(10.r),
                        elevation: 2,
                        child: Container(
                          height: 216.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20).r,
                            color: const Color.fromARGB(77, 193, 193, 193),
                          ),
                          width: 377.w,
                          child: Stack(
                            children: [
                              Positioned(
                                top: -8.w,
                                left: 15.w,
                                right: -5.w,
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        voucherList[index]['promo_description'],
                                        style:
                                            Get.textTheme.titleMedium!.copyWith(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w900,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                      ),
                                    ),
                                    Transform.scale(
                                      scale: 14 / Checkbox.width,
                                      child: Checkbox(
                                        side: const BorderSide(width: 2),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5.r),
                                        ),
                                        value: false,
                                        onChanged: (value) {},
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10).r,
                                  child: SizedBox(
                                    width: 364.w,
                                    child: Image.asset(
                                      voucherList[index]['promo_image'],
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
