import 'package:get/get.dart';
import 'package:venturo_food/modules/global_controllers/global_controller.dart';

class GlobalBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(GlobalController());
  }
}
