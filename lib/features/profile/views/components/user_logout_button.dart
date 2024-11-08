import 'package:flutter/material.dart';
import 'package:panara_dialogs/panara_dialogs.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserLogoutButton extends StatelessWidget {
  const UserLogoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30.w),
      child: SizedBox(
        height: 45.w,
        child: ElevatedButton(
          onPressed: () {
            PanaraConfirmDialog.show(context,
                message: 'Anda Yakin Untuk Logout?'.tr,
                confirmButtonText: 'Yes'.tr,
                cancelButtonText: 'No'.tr, onTapConfirm: () {
              Get.offAllNamed("/login");
            }, onTapCancel: () {
              Get.back();
            }, panaraDialogType: PanaraDialogType.normal);
          },
          child: const Text('Logout'),
        ),
      ),
    );
  }
}