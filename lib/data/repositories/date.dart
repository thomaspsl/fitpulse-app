import 'package:fitpulse_app/data/models/exercise.dart';
import 'package:fitpulse_app/data/models/session.dart';
import 'package:fitpulse_app/data/services/db_helper.dart';
import 'package:fitpulse_app/data/models/date.dart';

class DateRepository {
  final DBHelper _databaseHelper = DBHelper();

  Future<List<Date>> index() async {
    final db = await _databaseHelper.database;
    final List<Map<String, dynamic>> dateMaps =
    await db.query('Date');

    List<Date> dates = [];
    for (var dateMap in dateMaps) {
      final List<Map<String, dynamic>> sessionMaps = await db.query(
        'Session',
        where: 'id = ?',
        whereArgs: [dateMap['session_id']],
      );

      if (sessionMaps.isNotEmpty) {
        final List<Map<String, dynamic>> sessionExerciseMaps = await db.query(
          'SessionExercise',
          where: 'session_id = ?',
          whereArgs: [dateMap['session_id']],
        );

        List<Exercise> exercises = [];
        for (var sessionExerciseMap in sessionExerciseMaps) {
          final List<Map<String, dynamic>> exerciseMaps = await db.query(
            'Exercise',
            where: 'id = ?',
            whereArgs: [sessionExerciseMap['exercise_id']],
          );
          if (exerciseMaps.isNotEmpty) {
            exercises.add(Exercise.fromMap(exerciseMaps.first));
          }
        }

        final session = Session.fromMap(sessionMaps.first, exercises);

        dates.add(Date(
          date: DateTime.parse(dateMap['date']),
          session: session,
          recurring: dateMap['recurring'] == 1,
        ));
      }
    }
    return dates;
  }

  Future<void> store(Date date) async {
    final db = await _databaseHelper.database;
    await db.insert(
      'Date',
      {
        'session_id': date.session.id,
        'date': date.date.toIso8601String(),
        'recurring': 0,
        'recurrence': null,
      },
    );
  }

  Future<void> storeRecurring(Date date, int weekday) async {
    final db = await _databaseHelper.database;
    for (int i = 0; i < 4; i++) {
      DateTime eventDate = date.date.add(Duration(days: i * 7));
      while (eventDate.weekday != weekday) {
        eventDate = eventDate.add(const Duration(days: 1));
      }
      eventDate = DateTime(
        eventDate.year,
        eventDate.month,
        eventDate.day,
        date.date.hour,
        date.date.minute,
      );
      await db.insert(
        'Date',
        {
          'session_id': date.session.id,
          'date': eventDate.toIso8601String(),
          'recurring': 1,
          'recurrence': weekday.toString(),
        },
      );
    }
  }

  Future<void> destroy(Date date) async {
    final db = await _databaseHelper.database;
    await db.delete(
      'Date',
      where: 'session_id = ? AND date = ?',
      whereArgs: [date.session.id, date.date.toIso8601String()],
    );
  }

  Future<void> destroyRecurring(Date date) async {
    final db = await _databaseHelper.database;
    await db.delete(
      'Date',
      where: 'session_id = ? AND date >= ?',
      whereArgs: [date.session.id, date.date.toIso8601String()],
    );
  }
}
