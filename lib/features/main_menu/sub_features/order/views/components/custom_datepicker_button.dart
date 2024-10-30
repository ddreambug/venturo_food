import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/material_symbols.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:venturo_food/configs/themes/main_color.dart';
import 'package:venturo_food/features/main_menu/sub_features/order/controllers/order_controller.dart';
import 'package:venturo_food/shared/widgets/styles/google_text_style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomDatepickerButton extends StatelessWidget {
  const CustomDatepickerButton({
    super.key,
    this.isProfile = false,
  });

  final bool isProfile;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        showDialog(
          context: context,
          builder: (context) {
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.r),
              ),
              child: Container(
                width: 300.w,
                height: 300.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.r),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15.r),
                  child: SfDateRangePicker(
                    monthViewSettings: DateRangePickerMonthViewSettings(
                      viewHeaderStyle: DateRangePickerViewHeaderStyle(
                        textStyle:
                            GoogleTextStyle.w600.copyWith(fontSize: 14.sp),
                      ),
                    ),
                    selectionMode: DateRangePickerSelectionMode.range,
                    backgroundColor: Colors.white,
                    onSelectionChanged: (dateRangePickerSelectionChangedArgs) {
                      var value = dateRangePickerSelectionChangedArgs.value
                          as PickerDateRange;

                      if (value.startDate != null && value.endDate != null) {
                        OrderController.to.filterStartDate.value =
                            DateFormat('dd/MM/yy').format(value.startDate!);
                        OrderController.to.filterEndDate.value =
                            DateFormat('dd/MM/yy').format(value.endDate!);
                      }
                    },
                  ),
                ),
              ),
            );
          },
        );
      },
      child: SizedBox(
        height: 35.h,
        width: 180.w,
        child: Stack(
          children: [
            Positioned(
              top: 10.w,
              left: 15.w,
              child: Obx(() {
                final startDate = OrderController.to.filterStartDate.value;
                final endDate = OrderController.to.filterEndDate.value;

                return Text(
                  '$startDate - $endDate',
                  style: GoogleTextStyle.w400.copyWith(
                    color: MainColor.grey,
                    fontSize: 14.sp,
                    letterSpacing: 0,
                  ),
                );
              }),
            ),
            Positioned(
              right: 10.w,
              top: 6.w,
              child: Iconify(
                MaterialSymbols.calendar_month_outline,
                color: MainColor.primary,
                size: 25.w,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border.all(color: MainColor.primary),
                borderRadius: BorderRadius.all(
                  Radius.circular(20.r),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
