import 'dart:io';
import 'package:get/get.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:venturo_food/configs/routes/main_route.dart';
import 'package:venturo_food/constants/cores/api/api_constant.dart';

class GlobalController extends GetxController {
  static GlobalController get to => Get.find();

  /// API
  var baseUrl = ApiConstant.staging;
  var isStaging = false.obs;

  /// Check Connection Variable
  var isConnect = false.obs;

  /// Check Connection Setting
  Future<void> checkConnection() async {
    try {
      final result = await InternetAddress.lookup('space.venturo.id');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        isConnect.value = true;
      }
    } on SocketException catch (exception, stackTrace) {
      isConnect.value = false;
      await Sentry.captureException(
        exception,
        stackTrace: stackTrace,
      );

      Get.offAllNamed(MainRoute.noConnection);
    }
  }

  Future<void> checkConnectionInPage() async {
    try {
      final result = await InternetAddress.lookup('space.venturo.id');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        isConnect.value = true;
      }
    } on SocketException catch (exception, stackTrace) {
      isConnect.value = false;
      await Sentry.captureException(
        exception,
        stackTrace: stackTrace,
      );
    }
  }
}
