import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:venturo_food/configs/themes/main_color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

final ThemeData mainTheme = ThemeData(
  primaryColor: MainColor.primary,
  brightness: Brightness.light,
  colorScheme: ColorScheme.fromSwatch(
    accentColor: MainColor.primary,
    cardColor: MainColor.white,
    errorColor: MainColor.danger,
  ),
  iconTheme: IconThemeData(
    color: MainColor.primary,
    size: 24.sp,
  ),
  textTheme: GoogleFonts.montserratTextTheme().copyWith(
    bodyMedium: GoogleFonts.montserrat(
        color: MainColor.black, fontWeight: FontWeight.w600),
  ),
  elevatedButtonTheme: const ElevatedButtonThemeData(
    style: ButtonStyle(
      elevation: WidgetStatePropertyAll(5),
      foregroundColor: WidgetStatePropertyAll(MainColor.white),
      backgroundColor: WidgetStatePropertyAll(MainColor.primary),
    ),
  ),
  inputDecorationTheme: const InputDecorationTheme(
    labelStyle: TextStyle(fontSize: 14),
    hintStyle: TextStyle(color: MainColor.grey, fontSize: 12),
  ),
);
