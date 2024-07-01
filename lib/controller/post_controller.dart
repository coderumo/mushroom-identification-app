import 'dart:io';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:tez_front/controller/db_manager.dart';
import 'package:tez_front/models/post_model.dart';

class PostController extends GetxController {
  var isLoading = false.obs;
  final Database db = Database();

  Future<void> uploadPost(PostModel post) async {
    isLoading.value = true;
    var uri = Uri.parse('http://localhost:3000/post');
    var token = db.tokenBox.get('token') ?? '';

    var request = http.MultipartRequest('POST', uri)
      ..fields['description'] = post.description ?? ''
      ..headers['Authorization'] = 'Bearer $token';

    var response = await request.send();

    if (response.statusCode == 200) {
      print('Post uploaded successfully');
    } else {
      print('Failed to upload post');
    }

    isLoading.value = false;
  }
}
