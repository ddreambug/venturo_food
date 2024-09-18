import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:venturo_food/configs/themes/main_color.dart';
import 'package:venturo_food/constants/cores/assets/image_constant.dart';
import 'package:venturo_food/features/sign_in/controllers/login_controller.dart';
import 'package:venturo_food/shared/global_controllers/analytics_controller.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final analyticsController = AnalyticsController();
    analyticsController.setCurrentScreen('Login Screen');

    final LoginController controller = LoginController.to;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(25, 100, 25, 100),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Hero(
                tag: 'splashImage',
                child: Image.asset(
                  ImageConstant.splashLogo,
                  width: 200,
                  fit: BoxFit.contain,
                ),
              ),
              const Spacer(),
              const Text(
                'Masuk untuk melanjutkan!',
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 10),
              TextFormField(
                onChanged: (value) {},
                style: const TextStyle(fontSize: 12),
                decoration: const InputDecoration(
                  labelText: 'Alamat Email',
                  hintText: 'Lorem.ipsum@gmail.com',
                ),
              ),
              Obx(
                () => TextFormField(
                  style: const TextStyle(fontSize: 12),
                  obscureText: controller.obscureText.value,
                  onChanged: (value) {},
                  decoration: InputDecoration(
                    labelText: 'Kata Sandi',
                    hintText: '***************',
                    suffixIcon: IconButton(
                      onPressed: () {
                        controller.changePasswordVisibility();
                      },
                      icon: Icon(controller.obscureText.value
                          ? Icons.visibility
                          : Icons.visibility_off),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                height: 30,
                child: ElevatedButton(
                    onPressed: () {
                      Get.toNamed('/noInternet');
                      analyticsController.logButtonClick('Button Masuk');
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
