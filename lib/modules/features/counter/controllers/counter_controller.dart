import 'package:get/get.dart';
import 'package:venturo_food/modules/global_controllers/global_controller.dart';

class CounterController extends GetxController {
  static CounterController get to => Get.find();

  @override
  void onInit() async {
    super.onInit();

    await GlobalController.to.checkConnection();
  }

  var count = 0.obs;
  increment() => count++;
  decrement() => count--;
}
