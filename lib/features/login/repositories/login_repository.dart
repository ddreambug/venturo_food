import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:venturo_food/utils/services/dio_service.dart';

class LoginRepository {
  final dio = DioService().getDio();

  Future<Map<String, dynamic>> login(
    String email,
    String password,
    bool isGoogle,
  ) async {
    if (isGoogle) {
      try {
        final response = await dio.post(
          'https://trainee.landa.id/javacode/auth/login',
          data: {"email": email, "nama": password, "is_google": isGoogle},
        );

        return response.data;
      } catch (error, stackTrace) {
        await Sentry.captureException(
          error,
          stackTrace: stackTrace,
        );

        rethrow;
      }
    } else {
      try {
        final response = await dio.post(
          'https://trainee.landa.id/javacode/auth/login',
          data: {"email": email, "password": password, "is_google": isGoogle},
        );

        return response.data;
      } catch (error, stackTrace) {
        await Sentry.captureException(
          error,
          stackTrace: stackTrace,
        );

        rethrow;
      }
    }
  }
}
