import 'package:flutter/material.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import 'package:get/get.dart';
import 'package:venturo_food/configs/themes/main_color.dart';
import 'package:venturo_food/features/profile/controllers/profile_controller.dart';
import 'package:venturo_food/shared/widgets/styles/google_text_style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserAvatar extends StatelessWidget {
  const UserAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 170.r,
        height: 170.r,
        clipBehavior: Clip.antiAlias,
        decoration: const BoxDecoration(shape: BoxShape.circle),
        child: Stack(
          children: [
            Obx(
              () => GestureDetector(
                child: Conditional.single(
                  context: context,
                  conditionBuilder: (context) =>
                      ProfileController.to.imageFile != null,
                  widgetBuilder: (context) => Image.file(
                    ProfileController.to.imageFile!,
                    width: 170.r,
                    height: 170.r,
                    fit: BoxFit.cover,
                  ),
                  fallbackBuilder: (context) => Image.network(
                    ProfileController.to.user.value['foto'],
                    width: 170.r,
                    height: 170.r,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Material(
                color: MainColor.primary,
                child: InkWell(
                  onTap: ProfileController.to.pickImage,
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.only(top: 5.r, bottom: 8.r),
                    child: Text(
                      "Change".tr,
                      style: GoogleTextStyle.w400.copyWith(
                        fontSize: 12.sp,
                        color: MainColor.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
