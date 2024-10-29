import 'package:flutter/material.dart';
import 'package:venturo_food/configs/themes/main_color.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DividerCustom extends StatelessWidget {
  const DividerCustom({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Divider(
            color: MainColor.black,
            thickness: 0.5,
            indent: 5.r,
            endIndent: 10.r,
          ),
        ),
        Text(
          'Or'.tr,
          style: Theme.of(context).textTheme.labelSmall!.copyWith(
                fontSize: 14.sp,
              ),
        ),
        Expanded(
          child: Divider(
            color: MainColor.black,
            thickness: 0.5,
            indent: 10.r,
            endIndent: 5.r,
          ),
        ),
      ],
    );
  }
}
