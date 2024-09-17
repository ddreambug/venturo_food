import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:venturo_food/configs/themes/main_color.dart';
import 'package:venturo_food/features/sign_in/controllers/login_controller.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                  'lib/assets/images/ic_splash.png',
                  width: 150, // Set consistent width
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
                decoration: const InputDecoration(
                  labelText: 'Alamat Email',
                  hintText: 'Lorem.ipsum@gmail.com',
                  hintStyle: TextStyle(color: MainColor.grey, fontSize: 12),
                ),
              ),
              Obx(
                () => TextFormField(
                  obscureText: controller.obscureText.value,
                  onChanged: (value) {},
                  decoration: InputDecoration(
                    labelText: 'Kata Sandi',
                    hintText: '***************',
                    hintStyle:
                        const TextStyle(color: MainColor.grey, fontSize: 12),
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
                      Get.toNamed('/counter');
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
                    SvgPicture.asset('lib/assets/svg/ic_google.svg'),
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
                    SvgPicture.asset('lib/assets/svg/ic_apple.svg'),
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
