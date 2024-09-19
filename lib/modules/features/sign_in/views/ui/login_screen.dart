import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:venturo_food/configs/themes/main_color.dart';
import 'package:venturo_food/constants/cores/assets/image_constant.dart';
import 'package:venturo_food/modules/features/sign_in/controllers/login_controller.dart';
import 'package:venturo_food/modules/global_controllers/analytics_controller.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loginController = LoginController.to;

    ///google analytic
    final analyticsController = Get.find<AnalyticsController>();
    if (Platform.isAndroid) {
      analyticsController.setCurrentScreen(
        'Sign In Screen',
        screenClass: 'Android',
      );
    } else if (Platform.isIOS) {
      analyticsController.setCurrentScreen(
        'Sign In Screen',
        screenClass: 'IOS',
      );
    } else if (Platform.isMacOS) {
      analyticsController.setCurrentScreen(
        'Sign In Screen',
        screenClass: 'MacOS',
      );
    }

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(25, 100, 25, 100),
        child: Form(
          key: loginController.formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Hero(
                tag: 'splashImage',
                child: GestureDetector(
                  onDoubleTap: () => loginController.flavorSeting(),
                  child: Image.asset(
                    ImageConstant.splashLogo,
                    width: 200,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              const Spacer(),
              const Text(
                'Masuk untuk melanjutkan!',
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: loginController.emailController,
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Isikan Email';
                  } else if (value.contains(RegExp(r'[!#$%^&*(),?":{}|<>]'))) {
                    return 'Format Email harus benar!';
                  }
                  return null;
                },
                style: const TextStyle(fontSize: 12),
                decoration: const InputDecoration(
                  labelText: 'Alamat Email',
                  hintText: 'Lorem.ipsum@gmail.com',
                ),
                onSaved: (newValue) =>
                    loginController.emailValue.value = newValue!,
              ),
              Obx(
                () => TextFormField(
                  controller: loginController.passwordController,
                  style: const TextStyle(fontSize: 12),
                  obscureText: loginController.obscureText.value,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Isikan Password';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: 'Kata Sandi',
                    hintText: '***************',
                    suffixIcon: IconButton(
                      onPressed: () {
                        loginController.changePasswordVisibility();
                      },
                      icon: Icon(loginController.obscureText.value
                          ? Icons.visibility
                          : Icons.visibility_off),
                    ),
                  ),
                  onSaved: (newValue) =>
                      loginController.passwordValue.value = newValue!,
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                height: 30,
                child: ElevatedButton(
                    onPressed: () {
                      analyticsController.logButtonClick('Button Masuk');
                      LoginController.to.validateForm(context);
                    },
                    child: const Text('Masuk')),
              ),
              const Spacer(),
              const Row(
                children: [
                  Expanded(
                    child: Divider(
                      color: MainColor.grey,
                      indent: 5,
                      endIndent: 10,
                    ),
                  ),
                  Text(
                    'atau',
                    style: TextStyle(
                        color: MainColor.grey,
                        fontSize: 12,
                        fontWeight: FontWeight.w100),
                  ),
                  Expanded(
                    child: Divider(
                      color: MainColor.grey,
                      indent: 10,
                      endIndent: 5,
                    ),
                  ),
                ],
              ),
              ElevatedButton(
                style: const ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(MainColor.white)),
                onPressed: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SvgPicture.asset(ImageConstant.googleLogo),
                    const Text.rich(
                      TextSpan(
                        style: TextStyle(color: MainColor.black),
                        text: 'Masuk Menggunakan ',
                        children: <TextSpan>[
                          TextSpan(
                              text: 'Google',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ))
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                style: const ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(MainColor.black)),
                onPressed: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SvgPicture.asset(ImageConstant.appleLogo),
                    const Text.rich(
                      TextSpan(
                        style: TextStyle(color: MainColor.white),
                        text: 'Masuk Menggunakan ',
                        children: <TextSpan>[
                          TextSpan(
                              text: 'Apple',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ))
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
