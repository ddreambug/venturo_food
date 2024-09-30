import 'dart:io';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:get/get.dart';

class AnalyticsController extends GetxController {
  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  static AnalyticsController get to => Get.find();

  void logCurrentScreen() {
    if (Platform.isAndroid) {
      analytics.logScreenView(
        screenName: 'Sign In Screen',
        screenClass: 'Android',
      );
    } else if (Platform.isIOS) {
      analytics.logScreenView(
        screenName: 'Sign In Screen',
        screenClass: 'IOS',
      );
    } else if (Platform.isMacOS) {
      analytics.logScreenView(
        screenName: 'Sign In Screen',
        screenClass: 'MacOS',
      );
    }
  }

  void logPageView(String page) {
    analytics.logEvent(
      name: 'page_view',
      parameters: {'page_name': page},
    );
  }

  void logButtonClick(String buttonName) {
    analytics.logEvent(
      name: 'button_click',
      parameters: {'button_click': buttonName},
    );
  }
}
