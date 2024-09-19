import 'package:get/get.dart';
import 'package:venturo_food/configs/routes/main_route.dart';
import 'package:venturo_food/modules/features/counter/bindings/counter_bindings.dart';
import 'package:venturo_food/modules/features/counter/views/ui/counter_view.dart';
import 'package:venturo_food/modules/features/sign_in/bindings/login_binding.dart';
import 'package:venturo_food/modules/features/sign_in/bindings/splash_binding.dart';
import 'package:venturo_food/modules/features/sign_in/views/ui/login_screen.dart';
import 'package:venturo_food/modules/features/sign_in/views/ui/splash_screen.dart';
import 'package:venturo_food/modules/features/no_connection/bindings/no_internet_binding.dart';
import 'package:venturo_food/modules/features/no_connection/views/ui/no_connection_screen.dart';

abstract class MainPage {
  static final main = [
    GetPage(
      name: MainRoute.splashScreen,
      page: () => const SplashScreen(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: MainRoute.noConnection,
      page: () => const NoConnectionScreen(),
      transition: Transition.noTransition,
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
