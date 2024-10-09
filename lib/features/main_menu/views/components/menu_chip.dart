import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:venturo_food/configs/themes/main_color.dart';

/// Used in list_category.dart
class MenuChip extends StatelessWidget {
  final bool isSelected;
  final String text;
  final Function()? onTap;
  final String? icon;

  const MenuChip({
    super.key,
    this.isSelected = false,
    required this.text,
    this.onTap,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(30.r),
      child: Ink(
        padding: EdgeInsets.symmetric(horizontal: 14.r),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.r),
          color: isSelected ? MainColor.black : MainColor.primary,
        ),
        child: SizedBox(
          height: 35.h,
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  icon!,
                  color: MainColor.white,
                  height: 14.w,
                ),
                SizedBox(width: 5.w),
                Text(
                  text,
                  style: Get.textTheme.bodyMedium!.copyWith(
                      color: Colors.white,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
