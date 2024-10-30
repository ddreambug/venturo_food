import 'package:flutter/material.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/uiw.dart';
import 'package:venturo_food/configs/themes/main_color.dart';
import 'package:venturo_food/features/profile/controllers/profile_controller.dart';
import 'package:venturo_food/shared/widgets/styles/google_text_style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class UserIdentity extends StatelessWidget {
  const UserIdentity({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Conditional.single(
        context: context,
        conditionBuilder: (context) =>
            ProfileController.to.isVerif.value != false,
        widgetBuilder: (context) => Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Iconify(
              Uiw.verification,
              color: MainColor.primary,
              size: 22.w,
            ),
            7.horizontalSpaceRadius,
            Text(
              'Your have verified your ID card'.tr,
              style: GoogleTextStyle.w400.copyWith(
                color: MainColor.primary,
                fontSize: 14.sp,
              ),
            ),
          ],
        ),
        fallbackBuilder: (context) => InkWell(
          onTap: ProfileController.to.pickFile,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Iconify(
                Uiw.verification,
                color: MainColor.primary,
                size: 22.w,
              ),
              7.horizontalSpaceRadius,
              Text(
                'Verify your ID card now!'.tr,
                style: GoogleTextStyle.w400.copyWith(
                  color: MainColor.primary,
                  fontSize: 14.sp,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
