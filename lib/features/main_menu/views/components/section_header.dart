import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:venturo_food/shared/widgets/styles/google_text_style.dart';

/// Used in list_item.dart
/// Used in main_menu_view.dart
class SectionHeader extends StatelessWidget {
  const SectionHeader(
      {super.key,
      this.color,
      required this.title,
      this.icon,
      this.isHeader = false});

  final String title;
  final Color? color;
  final Widget? icon;
  final bool isHeader;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: isHeader
          ? EdgeInsets.symmetric(horizontal: 25.w)
          : EdgeInsets.symmetric(horizontal: 0.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          icon!,
          10.horizontalSpace,
          Text(title,
              style:
                  GoogleTextStyle.w700.copyWith(fontSize: 20.sp, color: color)),
        ],
      ),
    );
  }
}
