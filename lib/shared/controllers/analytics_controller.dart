import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:get/get.dart';

class AnalyticsController extends GetxController {
  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  void setCurrentScreen() {
    analytics.logScreenView(screenName: 'screenName');
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
