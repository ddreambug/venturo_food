import 'package:get/get.dart';
import 'package:venturo_food/modules/global_controllers/analytics_controller.dart';

class AnalyticsBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(
      AnalyticsController(),
    );
  }
}
