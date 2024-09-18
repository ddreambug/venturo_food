import 'package:get/get.dart';
import 'package:venturo_food/configs/routes/main_route.dart';
import 'package:venturo_food/features/counter/bindings/counter_bindings.dart';
import 'package:venturo_food/features/counter/views/ui/counter_view.dart';
import 'package:venturo_food/features/sign_in/bindings/login_binding.dart';
import 'package:venturo_food/features/sign_in/views/ui/login_screen.dart';
import 'package:venturo_food/features/sign_in/views/ui/splash_screen.dart';
import 'package:venturo_food/features/no_connection/bindings/no_internet_binding.dart';
import 'package:venturo_food/features/no_connection/views/ui/no_internet.dart';

abstract class MainPage {
  static final main = [
    GetPage(
      name: MainRoute.splashScreen,
      page: () => const SplashScreen(),
    ),
    GetPage(
      name: MainRoute.noInternet,
      page: () => const NoInternet(),
      binding: NoInternetBinding(),
    ),
    GetPage(
      name: MainRoute.login,
      page: () => const LoginScreen(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(seconds: 2),
      binding: LoginBinding(),
    ),
    GetPage(
      name: MainRoute.counter,
      page: () => const CounterView(),
      binding: CounterBindings(),
    ),
  ];
}
