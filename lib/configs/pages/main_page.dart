import 'package:get/get.dart';
import 'package:venturo_food/configs/routes/main_route.dart';
import 'package:venturo_food/features/counter/bindings/counter_bindings.dart';
import 'package:venturo_food/features/counter/views/ui/counter_view.dart';
import 'package:venturo_food/features/sign_in/bindings/login_binding.dart';
import 'package:venturo_food/features/sign_in/views/ui/login_screen.dart';
import 'package:venturo_food/features/sign_in/views/ui/splash_screen.dart';

abstract class MainPage {
  static final main = [
    GetPage(
      name: MainRoute.splashScreen,
      page: () => const SplashScreen(),
    ),
    GetPage(
      name: MainRoute.login,
      page: () => const LoginScreen(),
      transition: Transition.fade,
      transitionDuration: const Duration(seconds: 1),
      binding: LoginBinding(),
    ),
    GetPage(
      name: MainRoute.counter,
      page: () => const CounterView(),
      binding: CounterBindings(),
    ),
  ];
}
