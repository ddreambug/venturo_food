import 'package:get/get.dart';
import 'package:venturo_food/configs/routes/main_route.dart';
import 'package:venturo_food/modules/features/counter/bindings/counter_bindings.dart';
import 'package:venturo_food/modules/features/counter/views/ui/counter_view.dart';
import 'package:venturo_food/modules/features/forgot_password/bindings/forgot_password_binding.dart';
import 'package:venturo_food/modules/features/forgot_password/views/ui/forgot_password_view.dart';
import 'package:venturo_food/modules/features/sign_in/bindings/login_binding.dart';
import 'package:venturo_food/modules/features/sign_in/bindings/splash_binding.dart';
import 'package:venturo_food/modules/features/sign_in/views/ui/login_screen.dart';
import 'package:venturo_food/modules/features/sign_in/views/ui/splash_screen.dart';
import 'package:venturo_food/modules/features/loading/bindings/loading_binding.dart';
import 'package:venturo_food/modules/features/loading/views/ui/loading_view.dart';

abstract class MainPage {
  static final main = [
    GetPage(
      name: MainRoute.splashScreen,
      page: () => const SplashScreen(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: MainRoute.noConnection,
      page: () => const LoadingView(),
      transition: Transition.noTransition,
      binding: LoadingBinding(),
    ),
    GetPage(
      name: MainRoute.searchLocation,
      page: () => const LoadingView(searchLocation: true),
      transition: Transition.noTransition,
      binding: LoadingBinding(),
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
    GetPage(
      name: MainRoute.forgotPassword,
      page: () => const ForgotPasswordView(),
      binding: ForgotPasswordBinding(),
    ),
  ];
}
