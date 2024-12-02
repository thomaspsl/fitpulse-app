import 'package:fitpulse_app/data/db/db_helper.dart';
import 'package:fitpulse_app/data/models/seance.dart';
import 'package:sqflite/sqflite.dart';

class SeanceService {
  final dbHelper = DBHelper.instance;

  // Ajouter une nouvelle séance
  Future<int> addSeance(Seance seance) async {
    final db = await dbHelper.database;
    return await db.insert(
      'seances',
      seance.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Lire toutes les séances
  Future<List<Seance>> getSeances() async {
    final db = await dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.query('seances');

    return List.generate(maps.length, (i) {
      return Seance.fromMap(maps[i]);
    });
  }

  // Mettre à jour une séance
  Future<int> updateSeance(Seance seance) async {
    final db = await dbHelper.database;
    return await db.update(
      'seances',
      seance.toMap(),
      where: 'id = ?',
      whereArgs: [seance.id],
    );
  }

  // Supprimer une séance
  Future<int> deleteSeance(int id) async {
    final db = await dbHelper.database;
    return await db.delete(
      'seances',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
