import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/gridicons.dart';
import 'package:venturo_food/configs/themes/main_color.dart';
import 'package:venturo_food/features/main_menu/sub_features/order/controllers/order_controller.dart';
import 'package:venturo_food/shared/widgets/styles/google_text_style.dart';

class CustomDropdownButton extends StatelessWidget {
  const CustomDropdownButton({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> items = [
      'All Status',
      'Done',
      'Canceled',
    ];

    return DropdownButtonHideUnderline(
      child: Obx(
        () {
          String? selectedValue = OrderController.to.filterSelectedValue.value;
          return DropdownButton2<String>(
            hint: Text(
              selectedValue,
              style: GoogleTextStyle.w700.copyWith(
                fontSize: 16.sp,
                color: Colors.black,
              ),
              overflow: TextOverflow.ellipsis,
            ),
            items: items
                .map(
                  (String item) => DropdownMenuItem<String>(
                    value: item,
                    child: Text(
                      item.tr,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                )
                .toList(),
            value: selectedValue,
            onChanged: (value) {
              if (value != null && value != selectedValue) {
                OrderController.to.filterSelectedValue.value = value;
              }
            },
            buttonStyleData: ButtonStyleData(
              height: 35.h,
              width: 180.w,
              padding: EdgeInsets.only(left: 15.w, right: 2.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.r),
                border: Border.all(
                  color: MainColor.primary,
                ),
                color: Colors.white,
              ),
            ),
            iconStyleData: const IconStyleData(
              icon: Iconify(
                Gridicons.dropdown,
                color: MainColor.grey,
              ),
            ),
            dropdownStyleData: DropdownStyleData(
              maxHeight: 200.h,
              width: 180.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.r),
              ),
              scrollbarTheme: ScrollbarThemeData(
                radius: const Radius.circular(40),
                thickness: WidgetStateProperty.all(6),
                thumbVisibility: WidgetStateProperty.all(true),
              ),
            ),
            menuItemStyleData: const MenuItemStyleData(
              height: 40,
              padding: EdgeInsets.only(left: 14, right: 14),
            ),
          );
        },
      ),
    );
  }
}
