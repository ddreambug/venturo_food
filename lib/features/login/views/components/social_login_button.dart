import 'dart:io';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:venturo_food/configs/themes/main_color.dart';
import 'package:venturo_food/constants/cores/assets/image_constant.dart';

class SocialLoginButton extends StatelessWidget {
  const SocialLoginButton({
    super.key,
    required this.onPress,
  });

  final void Function() onPress;

  @override
  Widget build(BuildContext context) {
    String platformName;
    String platformIcon;
    Color platformTextColor;
    Color platformBackgroundColor;

    if (Platform.isIOS || Platform.isMacOS) {
      platformName = 'Apple';
      platformIcon = ImageConstant.appleLogoSvg;
      platformTextColor = MainColor.white;
      platformBackgroundColor = MainColor.black;
    } else {
      platformName = 'Google';
      platformIcon = ImageConstant.googleLogoSvg;
      platformTextColor = MainColor.black;
      platformBackgroundColor = MainColor.white;
    }

    return SizedBox(
      height: 44.w,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(platformBackgroundColor),
          elevation: const WidgetStatePropertyAll(3),
        ),
        onPressed: onPress,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SvgPicture.asset(
              platformIcon,
              height: 22.w,
              width: 24.w,
            ),
            Text.rich(
              TextSpan(
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    color: platformTextColor,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500),
                text: 'Login With '.tr,
                children: <TextSpan>[
                  TextSpan(
                    text: platformName,
                    style: Theme.of(context).textTheme.labelSmall!.copyWith(
                          fontWeight: FontWeight.w900,
                        ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
