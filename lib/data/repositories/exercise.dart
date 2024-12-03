import 'package:fitpulse_app/data/models/exercise.dart';
import 'package:fitpulse_app/data/db/db_helper.dart';

class ExerciseRepository {
  final DBHelper _databaseHelper = DBHelper();

  Future<List<Exercise>> index() async {
    final db = await _databaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.query('Exercise');
    return List.generate(maps.length, (i) {
      return Exercise.fromMap(maps[i]);
    });
  }

  Future<int> store(Exercise exercise) async {
    final db = await _databaseHelper.database;
    return await db.insert('Exercise', exercise.toMap());
  }

  Future<int> update(Exercise exercise) async {
    final db = await _databaseHelper.database;
    return await db.update(
      'Exercise',
      exercise.toMap(),
      where: 'id = ?',
      whereArgs: [exercise.id],
    );
  }

  Future<int> destroy(int id) async {
    final db = await _databaseHelper.database;
    return await db.delete(
      'Exercise',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
