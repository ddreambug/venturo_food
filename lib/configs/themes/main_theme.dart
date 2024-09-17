import 'package:flutter/material.dart';
import 'package:venturo_food/configs/themes/main_color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

final ThemeData mainTheme = ThemeData(
  primaryColor: MainColor.primary,
  brightness: Brightness.light,
  colorScheme: ColorScheme.fromSwatch(
      accentColor: MainColor.primary,
      cardColor: MainColor.white,
      errorColor: MainColor.danger),
  iconTheme: IconThemeData(
    color: MainColor.primary,
    size: 24.sp,
  ),
);
