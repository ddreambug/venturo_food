import 'package:dio/dio.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:venturo_food/utils/services/dio_service.dart';

class OrderRepository {
  var box = Hive.box('venturo');
  Dio get dio => DioService().getDio(token: box.get('token', defaultValue: ''));
  List<Map<String, dynamic>>? orders;

  Future<void> getOrders() async {
    try {
      final response = await dio.get(
        'https://trainee.landa.id/javacode/order/user/1001',
      ) as Map<String, dynamic>;
      await Sentry.captureMessage(
        'Order posted successfully: $response',
        level: SentryLevel.info,
      );

      orders = response['data'];
    } catch (error, stackTrace) {
      await Sentry.captureException(
        error,
        stackTrace: stackTrace,
      );
    }
  }
}
