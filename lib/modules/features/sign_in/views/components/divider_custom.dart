import 'package:flutter/material.dart';
import 'package:venturo_food/configs/themes/main_color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DividerCustom extends StatelessWidget {
  const DividerCustom({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Divider(
            color: MainColor.grey,
            indent: 5.r,
            endIndent: 10.r,
          ),
        ),
        Text(
          'atau',
          style: TextStyle(
              color: MainColor.grey,
              fontSize: 12.sp,
              fontWeight: FontWeight.w100),
        ),
        Expanded(
          child: Divider(
            color: MainColor.grey,
            indent: 10.r,
            endIndent: 5.r,
          ),
        ),
      ],
    );
  }
}
