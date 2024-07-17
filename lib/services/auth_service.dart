import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:tez_front/controller/db_manager.dart';
import 'package:tez_front/models/post_model.dart';
import '../models/user_model.dart';
import '../models/general_response.dart';

class AuthService {
  final String baseUrl = 'http://93.190.8.108:3000/';
  final String secondaryUrl = 'http://93.190.8.108:5000/classify';
  final String urlLogin = 'auth/login';
  final String urlRegister = 'auth/register';
  final String urlMe = 'auth/me';
  final String urlLogout = 'auth/logout';
  final String urlSetProfileImage = 'user/profile-image';
  final String urlPosts = 'post';
  final String urlDrafts = 'draft';

  Future<GeneralResponse> register(
      String name, String userName, String email, String password) async {
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
      throw Exception(
          'Kayıt başarısız: ${errorMessage.toString().split("Exception:").last}');
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
        body: jsonEncode({'email': email, 'password': password}),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        final authResponse =
            GeneralResponse.fromJson(json.decode(response.body));
        return authResponse;
      } else {
        final errorResponse = json.decode(response.body);
        final errorMessage =
            errorResponse['message'] ?? 'Unknown error occurred';
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
      final authResponse =
          GeneralResponse.fromJson(json.decode(responseString));
      return authResponse;
    } else {
      final errorResponse = json.decode(responseString);
      final errorMessage = errorResponse['message'] ?? 'Unknown error occurred';
      throw Exception('Profil resmi güncellenemedi: $errorMessage');
    }
  }

  Future<GeneralResponse> getPost({bool getUsers = false}) async {
    final url =
        Uri.parse('$baseUrl$urlPosts${getUsers ? '?relations=user' : ''}');
    final token = Database().tokenBox.get('token');
    final response =
        await http.get(url, headers: {'Authorization': 'Bearer $token'});

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print('Raw response data: $data');
      return GeneralResponse.fromJson(data);
    } else {
      throw Exception('Failed to load user profile');
    }
  }

  Future<GeneralResponse> getMyPost() async {
    final url = Uri.parse('$baseUrl$urlPosts/myPost');
    final token = Database().tokenBox.get('token');
    final response =
        await http.get(url, headers: {'Authorization': 'Bearer $token'});

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return GeneralResponse.fromJson(data);
    } else {
      throw Exception('Failed to load user posts');
    }
  }

  Future<GeneralResponse> getDraft() async {
    final url = Uri.parse('$baseUrl$urlDrafts');
    final token = Database().tokenBox.get('token');
    final response =
        await http.get(url, headers: {'Authorization': 'Bearer $token'});

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
      final authResponse =
          GeneralResponse.fromJson(json.decode(responseString));
      return authResponse;
    } else {
      final errorResponse = json.decode(responseString);
      final errorMessage = errorResponse['message'] ?? 'Unknown error occurred';
      throw Exception('Post Yüklenirken hata: $errorMessage');
    }
  }

  Future<GeneralResponse> createDraft(
      PostRequestModel model, File image) async {
    final url = Uri.parse('$baseUrl$urlDrafts'); // Taslak kaydetme endpointi
    final token = Database().tokenBox.get('token'); // Yetkilendirme token'ı

    // HTTP POST isteği hazırlama
    final request = http.MultipartRequest('POST', url)
      ..headers['Authorization'] =
          'Bearer $token' // Yetkilendirme token'ı ekleniyor
      ..fields['description'] = model.description // Gönderinin açıklaması
      ..fields['specie'] = model.specie // Gönderinin türü
      ..fields['place'] = model.place // Gönderinin yeri
      ..fields['latitude'] =
          model.latitude.toString() // Gönderinin enlem bilgisi
      ..fields['longitude'] =
          model.longitude.toString() // Gönderinin boylam bilgisi
      ..files.add(await http.MultipartFile.fromPath(
          'file', image.path)); // Gönderinin dosyası

    // İsteği gerçekleştirme ve cevabı alma
    final response = await request.send();
    final responseString = await response.stream.bytesToString();

    if (response.statusCode == 200 || response.statusCode == 201) {
      final authResponse =
          GeneralResponse.fromJson(json.decode(responseString));
      return authResponse;
    } else {
      final errorResponse = json.decode(responseString);
      final errorMessage = errorResponse['message'] ?? 'Unknown error occurred';
      throw Exception('Taslak kaydedilirken hata: $errorMessage');
    }
  }

  Future<Map<dynamic, dynamic>> classifyImage(File image) async {
    final url = Uri.parse(secondaryUrl);
    final request = http.MultipartRequest('POST', url)
      ..files.add(await http.MultipartFile.fromPath('photo', image.path));

    final response = await request.send();
    final responseString = await response.stream.bytesToString();

    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = json.decode(responseString);
      return data;
    } else {
      final errorResponse = json.decode(responseString);
      final errorMessage = errorResponse['message'] ?? 'Unknown error occurred';
      throw Exception('Resim sınıflandırılırken hata: $errorMessage');
    }
  }

  Future<void> deletePost(String postId) async {
    final token = Database().tokenBox.get('token');

    try {
      final response = await http.delete(
        Uri.parse('$baseUrl$urlPosts/$postId'),
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        return;
      } else {
        throw Exception('Failed to delete post');
      }
    } catch (e) {
      throw Exception('Failed to delete post: $e');
    }
  }
}
