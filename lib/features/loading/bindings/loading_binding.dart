import 'package:get/get.dart';
import 'package:venturo_food/features/loading/controllers/loading_controller.dart';

class LoadingBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(
      LoadingController(),
    );
  }
}
