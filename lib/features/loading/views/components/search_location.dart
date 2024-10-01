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
                    'searching location${loadingController.loadingDots.value}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: MainColor.primary,
                      fontWeight: FontWeight.w800,
                    ),
                  );
                } else {
                  return const Text(
                    'Data Lokasi Ditemukan!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: MainColor.primary,
                      fontWeight: FontWeight.w800,
                    ),
                  );
                }
              },
            ),

            //reactive widget untuk loadingbar dan lokasi
            SizedBox(height: 20.r),
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
                      SizedBox(height: 15.w),
                      Text(
                        loadingController.address.value!,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  );
                }
              },
            ),
            SizedBox(height: 20.r),

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
                        child: const Text('Cancel'),
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
                          child: const Text('Okay'),
                        ),
                      ),
                      SizedBox(height: 10.w),
                      Text(
                        'auto next dalam ${loadingController.loadingNextPage.value}',
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
