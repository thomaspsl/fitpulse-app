import 'package:fitpulse_app/data/services/database.dart';
import 'package:fitpulse_app/data/models/exercise.dart';

class ExerciseRepository {
  final SqliteService _sqliteService = SqliteService();

  Future<List<Exercise>> index() async {
    final db = await _sqliteService.db;
    final List<Map<String, dynamic>> maps = await db.query('Exercise');
    return List.generate(maps.length, (i) {
      return Exercise.fromMap(maps[i]);
    });
  }

  Future<int> store(Exercise exercise) async {
    final db = await _sqliteService.db;
    return await db.insert('Exercise', exercise.toMap());
  }

  Future<int> update(Exercise exercise) async {
    final db = await _sqliteService.db;
    return await db.update(
      'Exercise',
      exercise.toMap(),
      where: 'id = ?',
      whereArgs: [exercise.id],
    );
  }

  Future<int> destroy(int id) async {
    final db = await _sqliteService.db;
    return await db.delete(
      'Exercise',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
