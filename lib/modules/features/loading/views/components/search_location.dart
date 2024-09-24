import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:venturo_food/configs/themes/main_color.dart';
import 'package:venturo_food/modules/features/loading/controllers/loading_controller.dart';

class SearchLocation extends StatelessWidget {
  const SearchLocation({super.key});

  @override
  Widget build(BuildContext context) {
    Widget contentTitle;
    Widget contentBody;

    return Padding(
      padding: EdgeInsets.all(20.0.r),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(() {
              if (LoadingController.to.isLoading.value) {
                contentTitle = Text(
                  'searching location${LoadingController.to.loadingDots.value}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      color: MainColor.primary, fontWeight: FontWeight.w800),
                );
              } else {
                contentTitle = const Text(
                  'Data Lokasi Ditemukan!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: MainColor.primary, fontWeight: FontWeight.w800),
                );
              }
              return contentTitle;
            }),
            SizedBox(height: 20.r),
            Obx(() {
              if (LoadingController.to.isLoading.value) {
                contentBody = const CircularProgressIndicator();
              } else {
                contentBody = Text(LoadingController.to.address.value!);
              }
              return contentBody;
            }),
            SizedBox(height: 20.r),
            SizedBox(
              height: 30.r,
              child: ElevatedButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: const Text('Cancel')),
            ),
          ],
        ),
      ),
    );
  }
}
