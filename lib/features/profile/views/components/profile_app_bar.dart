import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:venturo_food/configs/themes/main_color.dart';
import 'package:venturo_food/shared/widgets/styles/google_text_style.dart';

class ProfileAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ProfileAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: 68.w,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30.r),
          ),
          boxShadow: const [
            BoxShadow(
              color: Colors.black54,
              blurRadius: 10,
              spreadRadius: -2,
              offset: Offset(0, -1),
            ),
          ],
        ),
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              top: 40.w,
              child: SizedBox(
                width: 60.w,
                child: Divider(
                  color: MainColor.primary,
                  thickness: 1.5.h,
                ),
              ),
            ),
            Align(
              alignment: Alignment.center, // Center the text horizontally
              child: Text(
                'Profil',
                style: GoogleTextStyle.w600.copyWith(
                  fontSize: 20.sp,
                  color: MainColor.primary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize =>
      Size.fromHeight(68.w); // Custom height of the AppBar
}
