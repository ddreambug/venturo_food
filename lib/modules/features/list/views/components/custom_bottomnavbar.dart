import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomBottomnavbar extends StatelessWidget {
  const CustomBottomnavbar({super.key});

  @override
  Widget build(BuildContext context) {
    int currentIndex = 0;
    return ClipRRect(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(30.r),
      ),
      child: Container(
        width: double.infinity,
        height: 80.h,
        padding: EdgeInsets.symmetric(
          horizontal: 25.w,
          vertical: 10.h,
        ),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(30.r),
          ),
        ),
        child: BottomNavigationBar(
          backgroundColor: Colors.transparent,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.grey,
          selectedFontSize: 10.sp,
          unselectedFontSize: 10.sp,
          currentIndex: currentIndex,
          onTap: (value) {
            currentIndex = value;
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.house_fill),
              label: 'Beranda',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_bag),
              label: 'Pesanan',
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.person_crop_circle),
              label: 'Profil',
            ),
          ],
        ),
      ),
    );
  }
}
