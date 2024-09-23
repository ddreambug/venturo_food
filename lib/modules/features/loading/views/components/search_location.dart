import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:venturo_food/configs/themes/main_color.dart';

class SearchLocation extends StatelessWidget {
  const SearchLocation({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20.0.r),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.wifi_off_sharp,
              size: 100.r,
            ),
            SizedBox(height: 20.r),
            const Text(
              'searching location',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: MainColor.primary, fontWeight: FontWeight.w800),
            ),
            SizedBox(height: 20.r),
            SizedBox(
              width: double.infinity,
              height: 30.r,
              child: ElevatedButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: const Text('exit')),
            ),
          ],
        ),
      ),
    );
  }
}
