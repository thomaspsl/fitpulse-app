import 'package:fitpulse_app/data/db/db_helper.dart';

class CommentRepository {
  final DBHelper _DBHelper = DBHelper();

  Future<List<Map<String, dynamic>>> index() async {
    final db = await _DBHelper.database;
    return await db.query('Comments');
  }

  Future<int> store({
    required String content,
    int? userId,
    int? sessionId,
    int? exerciseId,
  }) async {
    final db = await _DBHelper.database;
    return await db.insert('Comments', {
      'content': content,
      'user_id': userId,
      'session_id': sessionId,
      'exercise_id': exerciseId,
    });
  }

  Future<int> update({
    required int id,
    required String content,
    int? userId,
    int? sessionId,
    int? exerciseId,
  }) async {
    final db = await _DBHelper.database;
    return await db.update(
      'Comments',
      {
        'content': content,
        'user_id': userId,
        'session_id': sessionId,
        'exercise_id': exerciseId,
      },
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> destroy(int id) async {
    final db = await _DBHelper.database;
    return await db.delete(
      'Comments',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<List<Map<String, dynamic>>> getCommentsByUserId(int userId) async {
    final db = await _DBHelper.database;
    return await db.query(
      'Comments',
      where: 'user_id = ?',
      whereArgs: [userId],
    );
  }

  Future<List<Map<String, dynamic>>> getCommentsBySessionId(int sessionId) async {
    final db = await _DBHelper.database;
    return await db.query(
      'Comments',
      where: 'session_id = ?',
      whereArgs: [sessionId],
    );
  }

  Future<List<Map<String, dynamic>>> getCommentsByExerciseId(int exerciseId) async {
    final db = await _DBHelper.database;
    return await db.query(
      'Comments',
      where: 'exercise_id = ?',
      whereArgs: [exerciseId],
    );
  }

  Future<void> deleteCommentsByUserId(int userId) async {
    final db = await _DBHelper.database;
    await db.delete(
      'Comments',
      where: 'user_id = ?',
      whereArgs: [userId],
    );
  }
}
