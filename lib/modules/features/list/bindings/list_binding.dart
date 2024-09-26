import 'package:get/get.dart';
import 'package:venturo_food/modules/features/list/controllers/list_controller.dart';

class ListBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ListController());
  }
}
