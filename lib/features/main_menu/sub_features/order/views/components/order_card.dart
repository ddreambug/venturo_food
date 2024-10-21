import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/mdi.dart';
import 'package:venturo_food/configs/themes/main_color.dart';
import 'package:venturo_food/features/main_menu/sub_features/order/controllers/order_controller.dart';
import 'package:venturo_food/shared/widgets/styles/google_text_style.dart';
import 'package:intl/intl.dart';

class OrderCard extends StatelessWidget {
  const OrderCard({
    super.key,
    required this.orderItem,
  });

  final Map<String, dynamic> orderItem;

  @override
  Widget build(BuildContext context) {
    final formatCurrency = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    );
    final formatDate = DateFormat(
      "d MMM yyyy",
      "id_ID",
    );

    final menuTitles = OrderController.to.extractMenuTitles(orderItem);

    return Card(
      margin: EdgeInsets.only(
        left: 20.w,
        top: 15.w,
        right: 20.w,
      ),
      elevation: 2.5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: InkWell(
        onTap: () {
          OrderController.to.selectedOrder.value = orderItem;
          Get.toNamed('/detail-order');
        },
        child: Ink(
          padding: EdgeInsets.only(
            top: 7.w,
            left: 7.w,
            bottom: 7.w,
            right: 15.w,
          ),
          height: 138.w,
          decoration: BoxDecoration(
            backgroundBlendMode: BlendMode.darken,
            color: const Color.fromARGB(82, 221, 221, 221),
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Row(
            children: [
              // Image
              Container(
                height: 124.w,
                width: 124.w,
                margin: EdgeInsets.only(right: 10.w),
                padding: EdgeInsets.all(3.r),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  color: const Color.fromARGB(255, 223, 223, 223),
                ),
                child: CachedNetworkImage(
                  imageUrl: orderItem['item'][0]['foto'],
                  useOldImageOnUrlChange: true,
                  color: const Color.fromARGB(255, 223, 223, 223),
                  colorBlendMode: BlendMode.darken,
                  fit: BoxFit.contain,
                ),
              ),
              // Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        top: 5.w,
                        bottom: 15.w,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Iconify(
                            Mdi.clock_time_three_outline,
                            size: 14.w,
                            color: MainColor.warning,
                          ),
                          SizedBox(width: 2.w),
                          Text(
                            'Sedang disiapkan',
                            style: GoogleTextStyle.w600.copyWith(
                              fontSize: 12.sp,
                              color: MainColor.warning,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            formatDate.format(orderItem['date']),
                            style: GoogleTextStyle.w500.copyWith(
                              fontSize: 12.sp,
                              color: MainColor.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 45.h,
                      width: 150.w,
                      child: Text(
                        menuTitles,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleTextStyle.w500.copyWith(
                          fontSize: 20.sp,
                          height: 0,
                          letterSpacing: 0,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 150.w,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            formatCurrency.format(orderItem['harga']),
                            style: GoogleTextStyle.w600.copyWith(
                              fontSize: 14.sp,
                              color: MainColor.primary,
                              letterSpacing: 0,
                            ),
                          ),
                          SizedBox(width: 10.w),
                          Text(
                            '(${orderItem['item'].length} Menu)',
                            style: GoogleTextStyle.w600.copyWith(
                              fontSize: 12.sp,
                              color: MainColor.grey,
                              letterSpacing: 0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
