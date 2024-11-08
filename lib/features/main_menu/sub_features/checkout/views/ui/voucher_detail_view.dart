import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/uiw.dart';
import 'package:venturo_food/configs/themes/main_color.dart';
import 'package:venturo_food/features/main_menu/sub_features/checkout/views/components/checkout_bottom_navbar.dart';
import 'package:venturo_food/features/main_menu/views/components/custom_appbar.dart';
import 'package:venturo_food/shared/widgets/styles/google_text_style.dart';

class VoucherDetailView extends StatelessWidget {
  const VoucherDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    ///variable dari list item
    final voucherItem = Get.arguments;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: CustomAppbar(
          appBarTitle: 'Voucher Detail'.tr,
          useIcon: false,
        ),
        bottomNavigationBar: CheckoutBottomNavbar(
          checkoutNavbarType: 'detail_voucher',
          voucher: voucherItem,
        ),
        body: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 20.h),
            ClipRRect(
              borderRadius: BorderRadius.circular(20.r),
              child: SizedBox(
                width: 364.w,
                child: Image.network(
                  voucherItem['promo_image'],
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
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        voucherItem['promo_description'],
                        style: GoogleTextStyle.w600.copyWith(
                          fontSize: 20.sp,
                          color: MainColor.primary,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      SizedBox(
                        height: 70.h,
                        child: ListView.builder(
                          padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                          itemCount: voucherItem['promo_requirement'].length,
                          itemBuilder: (context, index) {
                            return Text(
                              '- ${voucherItem['promo_requirement'][index]}',
                              style: GoogleTextStyle.w400.copyWith(
                                fontSize: 12.sp,
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(height: 10.h),
                      const Divider(
                        color: MainColor.grey,
                        thickness: 0.5,
                      ),
                      Row(
                        children: [
                          Iconify(
                            Uiw.date,
                            size: 16.w,
                            color: MainColor.primary,
                          ),
                          SizedBox(width: 10.w),
                          Text(
                            'Valid Date',
                            style: GoogleTextStyle.w700.copyWith(
                              fontSize: 16.sp,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            voucherItem['valid_date'],
                            style: GoogleTextStyle.w500.copyWith(
                              fontSize: 14.sp,
                            ),
                          )
                        ],
                      ),
                      const Divider(
                        color: MainColor.grey,
                        thickness: 0.5,
                      ),
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
