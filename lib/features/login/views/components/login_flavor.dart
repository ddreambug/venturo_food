import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:venturo_food/configs/themes/main_color.dart';
import 'package:venturo_food/constants/cores/api/api_constant.dart';
import 'package:venturo_food/global_controllers/global_controller.dart';

class LoginFlavor extends StatelessWidget {
  const LoginFlavor({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Wrap(
        children: [
          Container(
            width: double.infinity.w,
            padding: EdgeInsets.symmetric(
              horizontal: 5.w,
              vertical: 5.h,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
              color: MainColor.white,
            ),
            child: Column(
              children: <Widget>[
                ListTile(
                  onTap: () {
                    GlobalController.to.isStaging.value = false;
                    GlobalController.to.baseUrl = ApiConstant.production;
                  },
                  title: Text(
                    "Production",
                    style: TextStyle(
                      color: GlobalController.to.isStaging.value == true
                          ? MainColor.black
                          : MainColor.primary,
                      fontSize: 14.sp,
                    ),
                  ),
                  trailing: GlobalController.to.isStaging.value == true
                      ? null
                      : Icon(
                          Icons.check,
                          color: MainColor.primary,
                          size: 14.sp,
                        ),
                ),
                Divider(
                  height: 1.h,
                ),
                ListTile(
                  onTap: () {
                    GlobalController.to.isStaging.value = true;
                    GlobalController.to.baseUrl = ApiConstant.staging;
                  },
                  title: Text(
                    "Staging",
                    style: TextStyle(
                      color: GlobalController.to.isStaging.value == true
                          ? MainColor.primary
                          : MainColor.black,
                      fontSize: 14.sp,
                    ),
                  ),
                  trailing: GlobalController.to.isStaging.value == true
                      ? Icon(
                          Icons.check,
                          color: MainColor.primary,
                          size: 14.sp,
                        )
                      : null,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
