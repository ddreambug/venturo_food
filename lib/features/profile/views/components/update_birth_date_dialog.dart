import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:venturo_food/features/profile/controllers/profile_controller.dart';
import 'package:venturo_food/shared/widgets/styles/google_text_style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class UpdateBirthDateDialog extends StatelessWidget {
  const UpdateBirthDateDialog({super.key});

  @override
  Widget build(BuildContext context) {
    var user = ProfileController.to.user;

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.r),
      ),
      child: Container(
        height: 300.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.r),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15.r),
          child: SfDateRangePicker(
            showNavigationArrow: true,
            maxDate: DateTime.now(),
            monthViewSettings: DateRangePickerMonthViewSettings(
              viewHeaderStyle: DateRangePickerViewHeaderStyle(
                textStyle: GoogleTextStyle.w600.copyWith(
                  fontSize: 14.sp,
                ),
              ),
            ),
            monthCellStyle: DateRangePickerMonthCellStyle(
              textStyle: GoogleTextStyle.w400.copyWith(
                fontSize: 14.sp,
              ),
            ),
            backgroundColor: Colors.white,
            onSelectionChanged: (dateRangePickerSelectionChangedArgs) {
              var value = dateRangePickerSelectionChangedArgs.value;

              if (value != null) {
                user.value = {
                  ...user.value,
                  'tanggalLahir': DateFormat('dd/MM/yyy').format(value),
                };
              }
              Get.back();
            },
          ),
        ),
      ),
    );
  }
}
