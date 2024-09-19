import 'package:get/get.dart';
import 'dart:async';

class NoInternetController extends GetxController {
  static NoInternetController get to => Get.find();

  var animationPlay = false.obs;
  Timer? _animationTimer;

  void toggleAnimation() {
    animationPlay.value = !animationPlay.value;
  }

  void startAnimationLoop() {
    _animationTimer =
        Timer.periodic(const Duration(milliseconds: 1200), (timer) {
      toggleAnimation();
    });
  }

  @override
  void onClose() {
    _animationTimer?.cancel();
    super.onClose();
  }

  @override
  void onInit() async {
    super.onInit();
    startAnimationLoop();
  }
}
