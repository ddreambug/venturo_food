import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/la.dart';
import 'package:panara_dialogs/panara_dialogs.dart';
import 'package:venturo_food/configs/themes/main_color.dart';
import 'package:venturo_food/constants/cores/assets/image_constant.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:venturo_food/features/main_menu/sub_features/order/controllers/order_controller.dart';
import 'package:venturo_food/features/main_menu/sub_features/order/views/components/order_status.dart';
import 'package:venturo_food/shared/widgets/styles/google_text_style.dart';

class OrderPriceDetail extends StatelessWidget {
  const OrderPriceDetail({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final orderItem = OrderController.to.selectedOrder;
    var voucher = orderItem['voucher'] as Map;
    final num totalPrice = OrderController.to.totalOrderPrice;
    final num finalPrice = orderItem['harga'];
    final formatCurrency = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    );
    final double discount = (20 / 100) * totalPrice;

    return Expanded(
      child: Container(
        decoration: const BoxDecoration(
          color: Color.fromARGB(112, 231, 231, 231),
          borderRadius: BorderRadiusDirectional.vertical(
            top: Radius.circular(30),
          ),
        ),
        height: 500.w,
        width: double.infinity,
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Total Row
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text.rich(
                    TextSpan(
                      text: 'Total Pesanan ',
                      style: GoogleTextStyle.w700.copyWith(
                        fontSize: 16.sp,
                      ),
                      children: [
                        TextSpan(
                          text: '(${orderItem['item'].length} Menu) :',
                          style: GoogleTextStyle.w400.copyWith(
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  Text(
                    formatCurrency.format(totalPrice),
                    style: GoogleTextStyle.w600.copyWith(
                      color: MainColor.primary,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w900,
                    ),
                    textAlign: TextAlign.end,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
              const Divider(),

              // Discount Row
              if (voucher.isEmpty) ...{
                Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(ImageConstant.discountIcon, width: 22.w),
                        SizedBox(width: 8.w),
                        SizedBox(
                          width: 220.w,
                          child: Text(
                            'Diskon 20%',
                            style: GoogleTextStyle.w700.copyWith(
                              fontSize: 16.sp,
                            ),
                          ),
                        ),
                        const Spacer(),
                        Text(
                          formatCurrency.format(discount),
                          style: GoogleTextStyle.w400.copyWith(
                            color: MainColor.danger,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w100,
                          ),
                          textAlign: TextAlign.end,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                    const Divider(),
                  ],
                ),
              },

              // Voucher Row
              if (voucher.isNotEmpty) ...{
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      ImageConstant.voucherIcon,
                      width: 22.w,
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      'Voucher',
                      style: GoogleTextStyle.w700.copyWith(fontSize: 16.sp),
                    ),
                    const Spacer(),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          formatCurrency.format(voucher.values.first),
                          style: GoogleTextStyle.w400.copyWith(
                            color: MainColor.danger,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w100,
                          ),
                          textAlign: TextAlign.end,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          voucher.keys.first,
                          style: GoogleTextStyle.w400.copyWith(fontSize: 10.sp),
                        ),
                      ],
                    )
                  ],
                ),
                const Divider(),
              },

              // Payment Row
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Iconify(
                    La.coins,
                    color: const Color.fromRGBO(44, 139, 164, 1),
                    size: 24.w,
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    'Pembayaran',
                    style: GoogleTextStyle.w700.copyWith(
                      fontSize: 16.sp,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    'Pay Later',
                    style: GoogleTextStyle.w400.copyWith(
                      color: MainColor.black,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w100,
                    ),
                    textAlign: TextAlign.end,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
              const Divider(),

              //Total Payment Row
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Total Pembayaran',
                    style: GoogleTextStyle.w700.copyWith(
                      fontSize: 16.sp,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    formatCurrency.format(finalPrice),
                    style: GoogleTextStyle.w600.copyWith(
                      color: MainColor.primary,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w900,
                    ),
                    textAlign: TextAlign.end,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
              const Divider(),

              //button
              Obx(
                () {
                  var orderStatus = OrderController.to.selectedOrder['status'];
                  if (orderStatus != 2 && orderStatus != 3) {
                    return Row(
                      children: [
                        const Spacer(),
                        SizedBox(
                          height: 20.w,
                          child: ElevatedButton(
                            onPressed: () {
                              PanaraConfirmDialog.show(
                                context,
                                panaraDialogType: PanaraDialogType.error,
                                message:
                                    'Apakah anda ingin membatalkan pesanan?',
                                confirmButtonText: 'Ya',
                                cancelButtonText: 'Tidak',
                                onTapConfirm: () {
                                  OrderController.to
                                      .updateOrderStatus(isCancelOrder: true);
                                  Get.until(
                                    (route) => route.settings.name == '/order',
                                  );
                                },
                                onTapCancel: () {
                                  Get.back();
                                },
                              );
                            },
                            style: const ButtonStyle(
                              backgroundColor:
                                  WidgetStatePropertyAll(MainColor.danger),
                            ),
                            child: Text(
                              'batal',
                              style: GoogleTextStyle.w500
                                  .copyWith(fontSize: 12.sp),
                            ),
                          ),
                        ),
                      ],
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              ),
              SizedBox(height: 20.w),

              //status bar
              const OrderStatus(),
            ],
          ),
        ),
      ),
    );
  }
}
