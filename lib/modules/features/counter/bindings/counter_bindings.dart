import 'package:get/get.dart';
import 'package:venturo_food/modules/features/counter/controllers/counter_controller.dart';

class CounterBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(
      CounterController(),
    );
  }
}
