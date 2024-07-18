import 'package:get/get.dart';
import 'package:tez_front/controller/db_manager.dart';
import 'package:tez_front/models/user_model.dart';
import 'package:tez_front/services/auth_service.dart';

class Comments {
  final String description;
  final String username;
  final String? userImage;
  final DateTime date;

  Comments({required this.description, required this.username, required this.userImage, required this.date});
}

class CommentController extends GetxController {
  var comments = <Comments>[].obs;

  final AuthService _authService = AuthService();

  Future<void> addComment(String comment, String postId) async {
    final user = Database().getUser();

    comments.add(Comments(description: comment, username: user?.userName ?? 'Ben', userImage: user?.profileImage, date: DateTime.now()));
    await _authService.comment(comment, postId);
    update();
  }

  Future<void> getPostComments(String postId) async {
    final res = await _authService.getPostComments(postId);
    if (res.success) {
      final data = res.data['data'] as List;
      print('Response data: $data');
      final items = data.map((e) {
        UserModel user = UserModel.fromJson(e['user']);
        // createdAt: 2024-07-18T11:52:35.716Z
        final date = DateTime.parse(e['createdAt']);
        return Comments(
          description: e['description'],
          username: user.userName ?? '',
          userImage: user.profileImage,
          date: date,
        );
      });

      comments.assignAll(items);
    }
  }
}

extension DateTimeExtension on DateTime {
  bool isToday() {
    final now = DateTime.now();
    return now.day == day && now.month == month && now.year == year;
  }

  bool isYesterday() {
    final now = DateTime.now();
    return now.day - 1 == day && now.month == month && now.year == year;
  }

  String forCommentDateString() {
    if (isToday()) {
      return 'Bugün $hour:$minute';
    } else if (isYesterday()) {
      return 'Dün $hour:$minute';
    } else {
      return '$day/$month/$year $hour:$minute';
    }
  }
}
