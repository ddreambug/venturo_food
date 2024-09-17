import 'package:get/get.dart';
import 'package:venturo_food/configs/routes/main_route.dart';
import 'package:venturo_food/features/counter/bindings/counter_bindings.dart';
import 'package:venturo_food/features/counter/views/ui/counter_view.dart';

abstract class MainPage {
  static final main = [
    GetPage(
      name: MainRoute.initial,
      page: () => const CounterView(),
      binding: CounterBindings(),
    )
  ];
}
