import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:venturo_food/configs/routes/main_route.dart';
import 'package:venturo_food/configs/themes/main_color.dart';
import 'package:venturo_food/modules/global_controllers/global_controller.dart';

class NoConnection extends StatelessWidget {
  const NoConnection({super.key});

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
              'OOPS!\nTidak ada koneksi Internet',
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
                    Get.closeAllSnackbars();
                    GlobalController.to.checkConnectionInPage();
                    if (GlobalController.to.isConnect.value == true) {
                      Get.offNamed(MainRoute.login);
                    } else {
                      Get.snackbar(
                        duration: const Duration(milliseconds: 1500),
                        'Terjadi Kesalahan',
                        'Koneksi masih belum tersambung',
                      );
                    }
                  },
                  child: const Text('Coba Lagi')),
            ),
          ],
        ),
      ),
    );
  }
}
