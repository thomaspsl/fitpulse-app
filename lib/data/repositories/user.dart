import 'package:fitpulse_app/data/db/db_helper.dart';
import 'package:fitpulse_app/data/models/user.dart';

class UserRepository {
  final DBHelper _DBHelper = DBHelper();

  Future<List<User>> index() async {
    final db = await _DBHelper.database;
    final List<Map<String, dynamic>> maps = await db.query('User');
    return List.generate(maps.length, (i) {
      return User.fromMap(maps[i]);
    });
  }

  Future<int> store(User user) async {
    final db = await _DBHelper.database;
    return await db.insert('User', user.toMap());
  }

  Future<int> update(User user) async {
    final db = await _DBHelper.database;
    return await db.update(
      'User',
      user.toMap(),
      where: 'id = ?',
      whereArgs: [user.id],
    );
  }

  Future<int> destroy(int id) async {
    final db = await _DBHelper.database;
    return await db.delete(
      'User',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<User?> findById(int id) async {
    final db = await _DBHelper.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'User',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return User.fromMap(maps.first);
    }
    return null;
  }
}
