import 'package:get/get.dart';
import 'package:venturo_food/features/main_menu/sub_features/order/controllers/order_controller.dart';

class OrderBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(OrderController());
  }
}
