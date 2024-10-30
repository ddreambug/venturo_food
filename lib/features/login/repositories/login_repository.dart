import 'package:venturo_food/utils/services/dio_service.dart';

class LoginRepository {
  final dio = DioService().getDio();

  Future<Map<String, dynamic>> login(
    String email,
    String password,
    bool isGoogle,
  ) async {
    if (isGoogle) {
      final response = await dio.post(
        'https://trainee.landa.id/javacode/auth/login',
        data: {"email": email, "nama": password, "is_google": isGoogle},
      );

      return response.data;
    } else {
      final response = await dio.post(
        'https://trainee.landa.id/javacode/auth/login',
        data: {"email": email, "password": password, "is_google": isGoogle},
      );

      return response.data;
    }
  }
}
