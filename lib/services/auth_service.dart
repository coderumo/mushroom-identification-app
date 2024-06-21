import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tez_front/models/register_response.dart';
import '../models/user_model.dart';
import '../models/auth_response.dart';

class AuthService {
  final String baseUrl = 'http://10.0.2.2:3000/';
  final String urlLogin = 'auth/login';
  final String urlRegister = 'auth/register';

  Future<AuthResponse> register(
      String name, String userName, String email, String password) async {
    final url = Uri.parse('$baseUrl$urlRegister');

    final registerData = UserModel(
      name: name,
      userName: userName,
      email: email,
      password: password,
    );

    print('Request URL: $url');
    print('Request Body: ${jsonEncode(registerData.toJson())}');

    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(registerData.toJson()),
    );
    print('Response status code:${response.statusCode} ');

    print('Response Status Code: ${response.statusCode}');
    print('Response Body: ${response.body}');

    if (response.statusCode == 200 || response.statusCode == 201) {
      final authResponse = AuthResponse.fromJson(json.decode(response.body));
      print('Auth Response: $authResponse');
      return authResponse;
    } else {
      final errorResponse = json.decode(response.body);
      final errorMessage = errorResponse['message'] ?? 'Unknown error occurred';
      throw Exception(
          'Kayıt başarısız: ${errorMessage.toString().split("Exception:").last}');
    }
  }

  Future<AuthResponse> login(String email, String password) async {
    try {
      final url = Uri.parse('$baseUrl$urlLogin');

      print('Request URL: $url');
      print('Request Body: ${jsonEncode({
            'email': email,
            'password': password
          })}');

      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({'email': email, 'password': password}),
      );

      print('Response Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');
      print('Response status code:${response.statusCode} ');
      if (response.statusCode == 200 || response.statusCode == 201) {
        final authResponse = AuthResponse.fromJson(json.decode(response.body));
        print('Auth Response: $authResponse');
        return authResponse;
      } else {
        final errorResponse = json.decode(response.body);
        final errorMessage =
            errorResponse['message'] ?? 'Unknown error occurred';
        throw Exception('Giriş başarısız: $errorMessage');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Giriş başarısız: $e');
    }
  }
}
