import 'package:get/get.dart';
import 'package:venturo_food/configs/routes/main_route.dart';
import 'package:venturo_food/features/forgot_password/bindings/forgot_password_binding.dart';
import 'package:venturo_food/features/forgot_password/views/ui/forgot_password_view.dart';
import 'package:venturo_food/features/main_menu/bindings/list_binding.dart';
import 'package:venturo_food/features/main_menu/sub_features/checkout/bindings/checkout_binding.dart';
import 'package:venturo_food/features/main_menu/views/ui/main_menu_view.dart';
import 'package:venturo_food/features/main_menu/sub_features/checkout/views/ui/menu_detail_view.dart';
import 'package:venturo_food/features/main_menu/views/ui/promo_detail_view.dart';
import 'package:venturo_food/features/login/bindings/login_binding.dart';
import 'package:venturo_food/features/splash_screen/bindings/splash_binding.dart';
import 'package:venturo_food/features/login/views/ui/login_view.dart';
import 'package:venturo_food/features/splash_screen/views/ui/splash_screen.dart';
import 'package:venturo_food/features/loading/bindings/loading_binding.dart';
import 'package:venturo_food/features/loading/views/ui/loading_view.dart';

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
      page: () => const LoginView(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(seconds: 2),
      binding: LoginBinding(),
    ),
    GetPage(
      name: MainRoute.forgotPassword,
      page: () => const ForgotPasswordView(),
      binding: ForgotPasswordBinding(),
    ),
    GetPage(
      name: MainRoute.mainMenu,
      page: () => const ListItemView(),
      bindings: [
        ListBinding(),
        CheckoutBinding(),
      ],
      transition: Transition.circularReveal,
      transitionDuration: const Duration(seconds: 2),
    ),
    GetPage(
      name: MainRoute.detailPromo,
      page: () => const PromoDetailView(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: MainRoute.detailMenu,
      page: () => const MenuDetailView(),
      transition: Transition.fadeIn,
    ),
  ];
}
