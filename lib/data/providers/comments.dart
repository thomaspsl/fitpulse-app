import 'package:flutter/foundation.dart';
import 'package:fitpulse_app/data/repositories/comments.dart';

class CommentProvider with ChangeNotifier {
  final CommentRepository _repository = CommentRepository();

  List<Map<String, dynamic>> _comments = [];

  List<Map<String, dynamic>> get comments => _comments;

  CommentProvider() {
    index();
  }

  Future<void> index() async {
    _comments = await _repository.index();
    notifyListeners();
  }

  Future<void> store({
    required String content,
    int? userId,
    int? sessionId,
    int? exerciseId,
  }) async {
    final id = await _repository.store(
      content: content,
      userId: userId,
      sessionId: sessionId,
      exerciseId: exerciseId,
    );

    final newComment = {
      'id': id,
      'content': content,
      'user_id': userId,
      'session_id': sessionId,
      'exercise_id': exerciseId,
    };

    _comments.add(newComment);
    notifyListeners();
  }

  Future<void> update({
    required int id,
    required String content,
    int? userId,
    int? sessionId,
    int? exerciseId,
  }) async {
    await _repository.update(
      id: id,
      content: content,
      userId: userId,
      sessionId: sessionId,
      exerciseId: exerciseId,
    );

    final index = _comments.indexWhere((comment) => comment['id'] == id);
    if (index != -1) {
      _comments[index] = {
        'id': id,
        'content': content,
        'user_id': userId,
        'session_id': sessionId,
        'exercise_id': exerciseId,
      };
      notifyListeners();
    }
  }

  Future<void> destroy(int id) async {
    await _repository.destroy(id);

    _comments.removeWhere((comment) => comment['id'] == id);
    notifyListeners();
  }
}
