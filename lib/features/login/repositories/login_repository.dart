import 'package:dio/dio.dart' as http;

class LoginRepository {
  final dio = http.Dio();

  Future<Map<String, dynamic>> login(String email, String password) async {
    final response = await dio.post(
      'https://trainee.landa.id/javacode/auth/login',
      data: {"email": email, "password": password},
    );

    return response.data;
  }
}
