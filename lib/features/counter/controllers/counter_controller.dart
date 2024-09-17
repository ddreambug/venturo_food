import 'package:get/get.dart';

class CounterController extends GetxController {
  static CounterController get to => Get.find();

  var count = 0.obs;
  increment() => count++;
  decrement() => count--;
}
