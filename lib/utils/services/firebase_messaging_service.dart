import 'dart:developer';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/route_manager.dart';
import 'package:venturo_food/configs/routes/main_route.dart';

class FirebaseMessagingService {
  static final FirebaseMessaging instance = FirebaseMessaging.instance;
  static final FlutterLocalNotificationsPlugin localNotification =
      FlutterLocalNotificationsPlugin();

  Future<void> initialize() async {
    await _requestNotificationPermissions();

    // Initialize notification channel
    const channel = AndroidNotificationChannel(
      'order_notification_channel',
      'order channel',
      description: 'order data channel',
      importance: Importance.high,
    );

    // Initialize local notification settings
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings();
    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
      macOS: initializationSettingsDarwin,
    );

    await localNotification.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: onDidReceiveNotificationResponse,
    );

    // Create channel for Android notifications
    await localNotification
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    // Listen to foreground notifications
    FirebaseMessaging.onMessage.listen(
      (message) async {
        log('onMessage: $message');
        await handleNotif(message);
      },
      onError: (e) => log(e.toString()),
    );
  }

  // Handle foreground notifications
  @pragma('vm:entry-point')
  static Future<void> handleNotif(RemoteMessage message) async {
    log("Foreground ${message.data}");
    final notificationData = message.notification;

    final androidNotifDetail = AndroidNotificationDetails(
        'order_notification_channel', 'order channel',
        channelDescription: 'order data channel',
        icon: notificationData?.android?.smallIcon,
        priority: Priority.high);

    final NotificationDetails notifDetail = NotificationDetails(
      android: androidNotifDetail,
    );

    if (notificationData != null) {
      localNotification.show(
        notificationData.hashCode,
        notificationData.title,
        notificationData.body,
        notifDetail,
        payload: message.data['id_order'],
      );
    }
  }

  // Handle background notifications
  @pragma('vm:entry-point')
  static Future<void> handleBackgroundNotif(RemoteMessage message) async {
    log("Background ${message.data}");

    final notificationData = message.notification;

    final androidNotifDetail = AndroidNotificationDetails(
        'order_notification_channel', 'order channel',
        channelDescription: 'order data channel',
        icon: notificationData?.android?.smallIcon,
        priority: Priority.high);

    const darwinNotifDetail = DarwinNotificationDetails();

    final NotificationDetails notifDetail = NotificationDetails(
      android: androidNotifDetail,
      iOS: darwinNotifDetail,
    );

    if (notificationData != null) {
      localNotification.show(
        notificationData.hashCode,
        notificationData.title,
        notificationData.body,
        notifDetail,
        payload: message.data['id_order'],
      );
    }
  }

  // Request notification permissions
  Future<void> _requestNotificationPermissions() async {
    final NotificationSettings settings =
        await FirebaseMessaging.instance.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    log('User granted permission: ${settings.authorizationStatus}');
  }

  void onDidReceiveNotificationResponse(NotificationResponse response) {
    log("payload ${response.payload}");
    if (response.payload != null) {
      final idOrder = int.parse(response.payload!);
      Get.toNamed('${MainRoute.order}/$idOrder');
    }
  }

  // Local Notification
  static Future<void> showNotification({
    required String title,
    required String body,
    String? payload,
  }) async {
    const androidNotificationDetails = AndroidNotificationDetails(
      'order_notification_channel',
      'order channel',
      channelDescription: 'order data channel',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
    );
    const notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
    );

    await localNotification.show(
      DateTime.now().millisecondsSinceEpoch ~/ 1000,
      title,
      body,
      notificationDetails,
      payload: payload,
    );
  }
}
