import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:venturo_food/configs/themes/main_color.dart';
import 'package:venturo_food/modules/features/loading/controllers/loading_controller.dart';

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
            ///reactive widget untuk title loading
            Obx(() {
              Widget contentTitle;
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

            //reactive widget untuk loadingbar dan lokasi
            SizedBox(height: 20.r),
            Obx(() {
              Widget contentBody;
              if (LoadingController.to.isLoading.value) {
                contentBody = const CircularProgressIndicator();
              } else {
                contentBody = Text(LoadingController.to.address.value!);
              }
              return contentBody;
            }),
            SizedBox(height: 20.r),

            ///reactive widget untuk button
            Obx(() {
              Widget? contentButton;
              if (LoadingController.to.isLoading.value) {
                if (LoadingController.to.buttonToggled.value) {
                  contentButton = SizedBox(
                    height: 30.r,
                    child: ElevatedButton(
                        onPressed: () {
                          Get.back();
                        },
                        child: const Text('Cancel')),
                  );
                }
                return contentButton = const SizedBox(height: 1);
              } else {
                contentButton = Column(
                  children: [
                    SizedBox(
                      height: 30.r,
                      child: ElevatedButton(
                          onPressed: () {
                            Get.offAllNamed('/counter');
                          },
                          child: const Text('Okay')),
                    ),
                    SizedBox(height: 10.w),
                    Text(
                      'auto next dalam ${LoadingController.to.loadingNextPage.value}',
                      style: TextStyle(color: MainColor.grey, fontSize: 12.sp),
                    )
                  ],
                );
              }
              return contentButton;
            }),
          ],
        ),
      ),
    );
  }
}
