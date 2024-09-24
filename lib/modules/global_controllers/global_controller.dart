import 'dart:io';
import 'package:get/get.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:venturo_food/configs/routes/main_route.dart';
import 'package:venturo_food/constants/cores/api/api_constant.dart';
import 'package:venturo_food/utils/services/location_service.dart';

class GlobalController extends GetxController {
  static GlobalController get to => Get.find();

  /// API
  var baseUrl = ApiConstant.staging;
  var isStaging = false.obs;

  /// Location property
  RxString statusLocation = RxString('loading');
  RxnString messageLocation = RxnString();
  RxnDouble longitude = RxnDouble();
  RxnDouble latitude = RxnDouble();
  RxnString address = RxnString();

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

  Future<void> getLocation() async {
    /// Mendapatkan Lokasi saat ini
    try {
      statusLocation.value = 'loading';
      await LocationService.getCurrentLocation();
      statusLocation.value = 'success';
    } catch (e) {
      statusLocation.value = 'error';
      messageLocation.value = '$e';
    }
  }
}
