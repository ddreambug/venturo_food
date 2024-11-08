import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/material_symbols.dart';
import 'package:iconify_flutter/icons/mdi.dart';
import 'package:venturo_food/configs/themes/main_color.dart';
import 'package:venturo_food/features/main_menu/sub_features/order/controllers/order_controller.dart';
import 'package:venturo_food/features/main_menu/sub_features/order/views/components/order_completed_button.dart';
import 'package:venturo_food/shared/widgets/styles/google_text_style.dart';
import 'package:intl/intl.dart';

class OrderCard extends StatelessWidget {
  const OrderCard({
    super.key,
    required this.orderItem,
    this.isCompleted = false,
  });

  final Map<String, dynamic> orderItem;
  final bool isCompleted;

  @override
  Widget build(BuildContext context) {
    final formatCurrency = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp. ',
      decimalDigits: 0,
    );

    final menuTitles = OrderController.to.extractMenuTitles(orderItem);

    return Card(
      margin: EdgeInsets.only(
        left: 20.w,
        top: 10.w,
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
                  errorWidget: (context, url, error) => Image.network(
                      'https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/240px-No_image_available.svg.png'),
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
                        top: 2.w,
                        bottom: isCompleted ? 0.w : 15.w,
                      ),

                      //status - date
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Iconify(
                            orderItem['status'] == 2
                                ? MaterialSymbols.check_small_rounded
                                : orderItem['status'] == 3
                                    ? MaterialSymbols.close_rounded
                                    : Mdi.clock_time_three_outline,
                            size: 14.w,
                            color: orderItem['status'] == 2
                                ? MainColor.success
                                : orderItem['status'] == 3
                                    ? MainColor.danger
                                    : MainColor.warning,
                          ),
                          SizedBox(width: 2.w),
                          Text(
                            orderItem['status'] == 2
                                ? 'Done'.tr
                                : orderItem['status'] == 3
                                    ? 'Canceled'.tr
                                    : 'Prepared'.tr,
                            style: GoogleTextStyle.w600.copyWith(
                              fontSize: 12.sp,
                              color: orderItem['status'] == 2
                                  ? MainColor.success
                                  : orderItem['status'] == 3
                                      ? MainColor.danger
                                      : MainColor.warning,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            orderItem['date'],
                            style: GoogleTextStyle.w500.copyWith(
                              fontSize: 12.sp,
                              color: MainColor.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 5.w),

                    //menu title
                    SizedBox(
                      height: isCompleted ? 40.w : 45.h,
                      width: 150.w,
                      child: Text(
                        menuTitles,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleTextStyle.w500.copyWith(
                          fontSize: 20.sp,
                          height: 0.9,
                          letterSpacing: 0,
                        ),
                      ),
                    ),

                    //price - menucount
                    SizedBox(
                      width: 160.w,
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
                    SizedBox(height: 5.w),

                    //completed
                    if (isCompleted) ...{
                      if (orderItem['status'] == 2) ...{
                        OrderCompletedButton(
                          orderItem: orderItem,
                        ),
                      } else ...{
                        OrderCompletedButton(
                          orderItem: orderItem,
                          isCanceled: true,
                        ),
                      }
                    }
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
