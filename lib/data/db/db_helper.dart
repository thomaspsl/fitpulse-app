import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:async';

class DBHelper {
  static final DBHelper instance = DBHelper._init();
  static Database? _database;

  factory DBHelper() {
    return instance;
  }

  DBHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    String path = join(await getDatabasesPath(), 'fitpulse.db');

    print('Chemin de la base de données : $path');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE Session (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        type TEXT NOT NULL,
        recovery INTEGER
    )''');

    await db.execute('''
      CREATE TABLE Exercise (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT NOT NULL,
      is_time INTEGER NOT NULL,
      time INTEGER,
      nb INTEGER,
      sessions INTEGER NOT NULL,
      recovery INTEGER NOT NULL
    )''');

    await db.execute('''
      CREATE TABLE SessionExercise (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        exercise_id INTEGER NOT NULL,
        session_id INTEGER NOT NULL,
        FOREIGN KEY (exercise_id) REFERENCES Exercise(id),
        FOREIGN KEY (session_id) REFERENCES Session(id)
    )''');

    await db.execute('''
      CREATE TABLE Comments (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        content TEXT NOT NULL,
        session_id INTEGER,
        exercise_id INTEGER,
        user_id INTEGER,
        FOREIGN KEY (session_id) REFERENCES Session(id),
        FOREIGN KEY (exercise_id) REFERENCES Exercise(id),
        FOREIGN KEY (user_id) REFERENCES User(id)
    )''');

    await db.execute('''
      CREATE TABLE Date (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        session_id INTEGER NOT NULL,
        date TEXT NOT NULL,
        recurring INTEGER NOT NULL,
        recurrence TEXT,
        FOREIGN KEY (session_id) REFERENCES Session(id)
    )''');

    await db.execute('''
      CREATE TABLE User (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        email TEXT NOT NULL,
        password TEXT NOT NULL,
        color INTEGER NOT NULL,
        session_id INTEGER,
        exercise_id INTEGER,
        comments_id INTEGER,
        FOREIGN KEY (session_id) REFERENCES Session(id),
        FOREIGN KEY (exercise_id) REFERENCES Exercise(id),
        FOREIGN KEY (comments_id) REFERENCES Comments(id)
    )''');
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }

  Future<void> deleteDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'fitpulse.db');
    await databaseFactory.deleteDatabase(path);
  }

}