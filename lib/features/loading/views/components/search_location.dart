import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:venturo_food/configs/themes/main_color.dart';
import 'package:venturo_food/features/loading/controllers/loading_controller.dart';

class SearchLocation extends StatelessWidget {
  const SearchLocation({super.key});

  @override
  Widget build(BuildContext context) {
    final loadingController = LoadingController.to;
    return Padding(
      padding: EdgeInsets.all(20.0.r),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ///reactive widget untuk title loading
            Obx(
              () {
                if (loadingController.isLoading.value) {
                  return Text(
                    'Searching your location${loadingController.loadingDots.value}'.tr,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: MainColor.grey,
                      fontWeight: FontWeight.w400,
                    ),
                  );
                } else {
                  return Text(
                    'Location Data Found'.tr,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: MainColor.primary,
                      fontWeight: FontWeight.w800,
                    ),
                  );
                }
              },
            ),

            //reactive widget untuk loadingbar dan lokasi
            SizedBox(height: 40.w),
            Obx(
              () {
                if (loadingController.isLoading.value) {
                  return const CircularProgressIndicator();
                } else {
                  return Column(
                    children: [
                      ClipOval(
                        child: Image.network(
                          loadingController.locationSnapshot,
                          fit: BoxFit.cover,
                          height: 200.w,
                          width: 200.w,
                        ),
                      ),
                      SizedBox(height: 25.w),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          loadingController.address.value!,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  );
                }
              },
            ),
            SizedBox(height: 25.w),

            ///reactive widget untuk button
            Obx(
              () {
                if (loadingController.isLoading.value) {
                  if (loadingController.buttonToggled.value) {
                    return SizedBox(
                      height: 30.r,
                      child: ElevatedButton(
                        onPressed: () {
                          Get.back();
                        },
                        child: Text('Cancel'.tr),
                      ),
                    );
                  } else {
                    return const SizedBox(height: 1);
                  }
                } else {
                  return Column(
                    children: [
                      SizedBox(
                        height: 30.r,
                        child: ElevatedButton(
                          onPressed: () {
                            loadingController.toNextScreen();
                          },
                          child: Text('Ok'.tr),
                        ),
                      ),
                      SizedBox(height: 10.w),
                      Text(
                        'Auto Next In ${loadingController.loadingNextPage.value}'
                            .tr,
                        style: TextStyle(
                          color: MainColor.grey,
                          fontSize: 12.sp,
                        ),
                      )
                    ],
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
