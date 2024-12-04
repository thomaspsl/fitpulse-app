import 'package:flutter/foundation.dart';
import 'package:fitpulse_app/data/repositories/user.dart';
import 'package:fitpulse_app/data/models/user.dart';
import 'package:fitpulse_app/data/repositories/comments.dart';

class UserProvider with ChangeNotifier {
  final CommentRepository _commentRepository = CommentRepository();
  final UserRepository _repository = UserRepository();

  List<User> _users = [];

  List<User> get users => _users;

  UserProvider() {
    index();
  }

  Future<void> index() async {
    _users = await _repository.index();
    notifyListeners();
  }

  Future<void> store(User user) async {
    final id = await _repository.store(user);
    user = user.copyWith(id: id);
    _users.add(user);
    notifyListeners();
  }

  Future<void> update(User user) async {
    if (user.id != null) {
      await _repository.update(user);
      final index = _users.indexWhere((u) => u.id == user.id);
      if (index != -1) {
        _users[index] = user;
        notifyListeners();
      }
    }
  }

  Future<void> delete(int id) async {
    await _commentRepository.deleteCommentsByUserId(id);
    await _repository.destroy(id);
    _users.removeWhere((user) => user.id == id);
    notifyListeners();
  }

  Future<void> addCommentForUser({
    required int userId,
    required String content,
    int? sessionId,
    int? exerciseId,
  }) async {
    await _commentRepository.store(
      content: content,
      userId: userId,
      sessionId: sessionId,
      exerciseId: exerciseId,
    );
    notifyListeners();
  }

  Future<List<Map<String, dynamic>>> getCommentsForUser(int userId) async {
    return await _commentRepository.getCommentsByUserId(userId);
  }
}
