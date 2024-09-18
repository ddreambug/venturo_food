import 'package:get/get.dart';
import 'package:venturo_food/features/no_connection/controllers/no_internet_controller.dart';

class NoInternetBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(
      NoInternetController(),
    );
  }
}
