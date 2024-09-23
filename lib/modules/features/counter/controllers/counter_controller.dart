import 'package:get/get.dart';
import 'package:venturo_food/modules/global_controllers/global_controller.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class CounterController extends GetxController {
  static CounterController get to => Get.find();

  @override
  void onInit() async {
    super.onInit();

    await GlobalController.to.checkConnection();
  }

  var count = 0.obs;
  void increment() async {
    try {
      count++;
    } catch (exception, stackTrace) {
      await Sentry.captureException(
        exception,
        stackTrace: stackTrace,
      );
    }
  }

  void decrement() async {
    try {
      count--;
    } catch (exception, stackTrace) {
      await Sentry.captureException(
        exception,
        stackTrace: stackTrace,
      );
    }
  }
}
