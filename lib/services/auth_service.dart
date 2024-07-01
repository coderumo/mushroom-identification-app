import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:tez_front/controller/db_manager.dart';
import 'package:tez_front/models/post_model.dart';
import 'package:tez_front/models/register_response.dart';
import '../models/user_model.dart';
import '../models/auth_response.dart';

class AuthService {
  final String baseUrl = 'http://93.190.8.108:3000/';
  final String urlLogin = 'auth/login';
  final String urlRegister = 'auth/register';
  final String urlMe = 'auth/me';
  final String urlLogout = 'auth/logout';
  final String urlSetProfileImage = 'user/profile-image';
  final String urlPosts = 'post';
  final String urlDrafts = 'draft';

  Future<GeneralResponse> register(String name, String userName, String email, String password) async {
    final url = Uri.parse('$baseUrl$urlRegister');

    final registerData = UserModel(
      name: name,
      userName: userName,
      email: email,
      password: password,
    );

    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(registerData.toJson()),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final authResponse = GeneralResponse.fromJson(json.decode(response.body));
      return authResponse;
    } else {
      final errorResponse = json.decode(response.body);
      final errorMessage = errorResponse['message'] ?? 'Unknown error occurred';
      throw Exception('Kayıt başarısız: ${errorMessage.toString().split("Exception:").last}');
    }
  }

  Future<GeneralResponse> login(String email, String password) async {
    try {
      final url = Uri.parse('$baseUrl$urlLogin');
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          'email': email,
          'password': password
        }),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        final authResponse = GeneralResponse.fromJson(json.decode(response.body));
        return authResponse;
      } else {
        final errorResponse = json.decode(response.body);
        final errorMessage = errorResponse['message'] ?? 'Unknown error occurred';
        throw Exception('Giriş başarısız: $errorMessage');
      }
    } catch (e) {
      throw Exception('Giriş başarısız: $e');
    }
  }

  Future<UserModel?> fetchUserProfile() async {
    final url = Uri.parse('$baseUrl$urlMe');
    final token = Database().tokenBox.get('token');
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    print(response.body);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      return UserModel.fromJson(data['data']);
    } else {
      throw Exception('Failed to load user profile');
    }
  }

  Future<GeneralResponse> setProfileImage(File file) async {
    final url = Uri.parse('$baseUrl$urlSetProfileImage');
    final token = Database().tokenBox.get('token');
    final request = http.MultipartRequest('PUT', url)
      ..headers['Authorization'] = 'Bearer $token'
      ..files.add(await http.MultipartFile.fromPath('file', file.path));

    final response = await request.send();
    final responseString = await response.stream.bytesToString();

    if (response.statusCode == 200 || response.statusCode == 201) {
      final authResponse = GeneralResponse.fromJson(json.decode(responseString));
      return authResponse;
    } else {
      final errorResponse = json.decode(responseString);
      final errorMessage = errorResponse['message'] ?? 'Unknown error occurred';
      throw Exception('Profil resmi güncellenemedi: $errorMessage');
    }
  }

  Future<GeneralResponse> getPost({bool getUsers = false}) async {
    final url = Uri.parse('$baseUrl$urlPosts${getUsers ? '?relations=user' : ''}');
    final token = Database().tokenBox.get('token');
    final response = await http.get(url, headers: {
      'Authorization': 'Bearer $token'
    });

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      return GeneralResponse.fromJson(data);
    } else {
      throw Exception('Failed to load user profile');
    }
  }

  Future<GeneralResponse> getDraft() async {
    final url = Uri.parse('$baseUrl$urlDrafts');
    final token = Database().tokenBox.get('token');
    final response = await http.get(url, headers: {
      'Authorization': 'Bearer $token'
    });

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      return GeneralResponse.fromJson(data);
    } else {
      throw Exception('Failed to load user profile');
    }
  }

  Future<GeneralResponse> createPost(PostRequestModel model, File image) async {
    final url = Uri.parse('$baseUrl$urlPosts');
    final token = Database().tokenBox.get('token');
    final request = http.MultipartRequest('POST', url)
      ..headers['Authorization'] = 'Bearer $token'
      ..fields['description'] = model.description
      ..fields['specie'] = model.specie
      ..fields['place'] = model.place
      ..fields['latitude'] = model.latitude.toString()
      ..fields['longitude'] = model.longitude.toString()
      ..files.add(await http.MultipartFile.fromPath('file', image.path));

    final response = await request.send();
    final responseString = await response.stream.bytesToString();

    if (response.statusCode == 200 || response.statusCode == 201) {
      final authResponse = GeneralResponse.fromJson(json.decode(responseString));
      return authResponse;
    } else {
      final errorResponse = json.decode(responseString);
      final errorMessage = errorResponse['message'] ?? 'Unknown error occurred';
      throw Exception('Post Yüklenirken hata: $errorMessage');
    }
  }
}
