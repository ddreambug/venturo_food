import 'package:flutter/material.dart';
import 'package:venturo_food/features/main_menu/sub_features/order/views/components/custom_datepicker_button.dart';
import 'package:venturo_food/features/main_menu/sub_features/order/views/components/custom_dropdown_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrderFilter extends StatelessWidget {
  const OrderFilter({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 20.w,
        top: 15.w,
        right: 20.w,
        bottom: 10.w,
      ),
      child: const Row(
        children: [
          CustomDropdownButton(),
          Spacer(),
          CustomDatepickerButton(),
        ],
      ),
    );
  }
}
