import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:get/get.dart';

class AnalyticsController extends GetxController {
  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  static AnalyticsController get to => Get.find();

  void setCurrentScreen(
      {String screenName = 'default', String screenClass = 'default'}) {
    analytics.logScreenView(screenName: screenName, screenClass: screenClass);
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