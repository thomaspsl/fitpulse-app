import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DBHelper {
  static final DBHelper instance = DBHelper._init();
  static Database? _database;

  DBHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('fitpulse.db');
    return _database!;
  }

  Future<Database> _initDB(String fileName) async {
    // Utiliser le répertoire de documents
    final directory = await getApplicationDocumentsDirectory();
    final path = join(directory.path, fileName);

    print('Chemin de la base de données : $path'); // Affiche le chemin pour vérifier où est stockée la base

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE seances (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nom TEXT NOT NULL,
        type TEXT NOT NULL,
        date TEXT NOT NULL,
        notification INTEGER NOT NULL
      )
    ''');
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
