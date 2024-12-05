import 'package:fitpulse_app/data/models/exercise.dart';
import 'package:fitpulse_app/data/models/session.dart';
import 'package:fitpulse_app/data/db/db_helper.dart';

class SessionRepository {
  final DBHelper _DBHelper = DBHelper();

  Future<List<Session>> index() async {
    final db = await _DBHelper.database;
    final sessionsData = await db.query('Session');
    List<Session> sessions = [];

    for (var sessionData in sessionsData) {
      final sessionId = sessionData['id'] as int;
      final exercisesData = await db.rawQuery(
        'SELECT * FROM Exercise e '
            'INNER JOIN SessionExercise se ON e.id = se.exercise_id '
            'WHERE se.session_id = ?',
        [sessionId],
      );
      final exercises = exercisesData.map((e) => Exercise.fromMap(e)).toList();
      sessions.add(Session.fromMap(sessionData, exercises));
    }
    return sessions;
  }

  Future<int> store(Session session) async {
    final db = await _DBHelper.database;
    final id = await db.insert('Session', session.toMap());
    for (var exercise in session.exercises) {
      await db.insert('SessionExercise', {
        'session_id': id,
        'exercise_id': exercise.id,
      });
    }
    return id;
  }

  Future<void> update(Session session) async {
    final db = await _DBHelper.database;

    if (session.id != null) {
      await db.update(
        'Session',
        session.toMap(),
        where: 'id = ?',
        whereArgs: [session.id],
      );
      await db.delete(
        'SessionExercise',
        where: 'session_id = ?',
        whereArgs: [session.id],
      );
      for (var exercise in session.exercises) {
        await db.insert('SessionExercise', {
          'session_id': session.id,
          'exercise_id': exercise.id,
        });
      }
    }
  }

  Future<void> destroy(int id) async {
    final db = await _DBHelper.database;
    await db.delete('Session', where: 'id = ?', whereArgs: [id]);
    await db.delete('SessionExercise', where: 'session_id = ?', whereArgs: [id]);
  }
}
