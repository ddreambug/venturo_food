import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:venturo_food/configs/themes/main_color.dart';
import 'package:venturo_food/constants/cores/assets/image_constant.dart';

class ApiLogin extends StatelessWidget {
  const ApiLogin({
    super.key,
    required this.onPress,
  });

  final void Function() onPress;

  @override
  Widget build(BuildContext context) {
    String platformName;
    String platformIcon;

    if (Platform.isIOS || Platform.isMacOS) {
      platformName = 'Apple';
      platformIcon = ImageConstant.appleLogo;
    } else {
      platformName = 'Google';
      platformIcon = ImageConstant.googleLogo;
    }

    return ElevatedButton(
      style: const ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(MainColor.black)),
      onPressed: onPress,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SvgPicture.asset(platformIcon),
          Text.rich(
            TextSpan(
              style: const TextStyle(color: MainColor.white),
              text: 'Masuk Menggunakan ',
              children: <TextSpan>[
                TextSpan(
                    text: platformName,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
