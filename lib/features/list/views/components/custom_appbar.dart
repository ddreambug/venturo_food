import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:venturo_food/configs/themes/main_color.dart';
import 'package:venturo_food/constants/cores/assets/image_constant.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppbar({
    super.key,
    required this.appBarTitle,
    this.useIcon = true,
  });

  final String appBarTitle;
  final bool useIcon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 68.w,
      padding: EdgeInsets.symmetric(
        horizontal: 5.w,
        vertical: 10.h,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(30.r),
        ),
        boxShadow: const [
          BoxShadow(
            color: Color.fromARGB(68, 24, 24, 24),
            blurRadius: 15,
            spreadRadius: -1,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(
                CupertinoIcons.back,
                color: MainColor.black,
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (useIcon) ...{
                  Image.asset(
                    ImageConstant.promoIcon,
                    width: 18.w,
                  ),
                },
                SizedBox(width: 8.w),
                Text(
                  appBarTitle,
                  style: Get.textTheme.bodyMedium!
                      .copyWith(fontWeight: FontWeight.w800, fontSize: 20.sp),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
