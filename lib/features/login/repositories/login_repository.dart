import 'package:venturo_food/utils/services/dio_service.dart';

class LoginRepository {
  final dio = DioService().getDio();

  Future<Map<String, dynamic>> login(String email, String password) async {
    final response = await dio.post(
      'https://trainee.landa.id/javacode/auth/login',
      data: {"email": email, "password": password},
    );

    return response.data;
  }
}
