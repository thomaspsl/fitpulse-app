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
      onCreate: (db, version) async {
        await _createDB(db, version);
        await _populateDatabase(db);
      },
    );
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE Session (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        type TEXT NOT NULL,
        category TEXT NOT NULL,
        recovery INTEGER
    )''');

    await db.execute('''
      CREATE TABLE Exercise (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        is_time INTEGER NOT NULL,
        category TEXT NOT NULL,
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

  Future<void> _populateDatabase(Database db) async {
    // Insertion dans la table Session
    List<Map<String, dynamic>> sessions = [
      {
        'name': 'Morning Yoga',
        'type': 'AMRAP',
        'category': 'PERSO',
        'recovery': 15,
      },
      {
        'name': 'Strength Circuit',
        'type': 'HIIT',
        'category': 'MUSCU',
        'recovery': 30,
      },
      {
        'name': 'Evening Cardio',
        'type': 'HIIT',
        'category': 'CARDIO',
        'recovery': 10,
      },
      {
        'name': 'Full Body Burn',
        'type': 'EMOM',
        'category': 'MUSCU',
        'recovery': 20,
      },
      {
        'name': 'Fat Blaster',
        'type': 'HIIT',
        'category': 'CARDIO',
        'recovery': 15,
      },
      {
        'name': 'Beach Ready',
        'type': 'HIIT',
        'category': 'PERSO',
        'recovery': 25,
      },
      {
        'name': 'Plage Cardio',
        'type': 'AMRAP',
        'category': 'CARDIO',
        'recovery': 10,
      },
      {
        'name': 'Core Crusher',
        'type': 'EMOM',
        'category': 'PERSO',
        'recovery': 20,
      },
    ];
    for (var session in sessions) {
      await db.insert('Session', session);
    }

    // Insertion dans la table Exercise
    List<Map<String, dynamic>> exercises = [
      {
        'name': 'Jumping Jacks',
        'is_time': 1,
        'time': 45,
        'category': 'PERSO',
        'nb': 0,
        'sessions': 2,
        'recovery': 15,
      },
      {
        'name': 'Burpees',
        'is_time': 0,
        'time': 0,
        'category': 'PERSO',
        'nb': 12,
        'sessions': 3,
        'recovery': 20,
      },
      {
        'name': 'Bench Press',
        'is_time': 0,
        'time': 0,
        'category': 'MUSCU',
        'nb': 10,
        'sessions': 4,
        'recovery': 60,
      },
      {
        'name': 'Deadlifts',
        'is_time': 0,
        'time': 0,
        'category': 'MUSCU',
        'nb': 8,
        'sessions': 4,
        'recovery': 90,
      },
      {
        'name': 'Pull-ups',
        'is_time': 0,
        'time': 0,
        'category': 'MUSCU',
        'nb': 10,
        'sessions': 3,
        'recovery': 30,
      },
      {
        'name': 'Running',
        'is_time': 1,
        'time': 300,
        'category': 'CARDIO',
        'nb': 0,
        'sessions': 1,
        'recovery': 120,
      },
      {
        'name': 'Cycling',
        'is_time': 1,
        'time': 600,
        'category': 'CARDIO',
        'nb': 0,
        'sessions': 2,
        'recovery': 180,
      },
      {
        'name': 'High Knees',
        'is_time': 1,
        'time': 30,
        'category': 'CARDIO',
        'nb': 0,
        'sessions': 3,
        'recovery': 10,
      },
    ];
    for (var exercise in exercises) {
      await db.insert('Exercise', exercise);
    }

    // Insertion dans la table User
    await db.insert('User', {
      'name': 'John Doe',
      'email': 'johndoe@example.com',
      'password': 'password123',
      'color': 0xFF42A5F5,
    });
    await db.insert('User', {
      'name': 'Jane Smith',
      'email': 'janesmith@example.com',
      'password': 'mypassword',
      'color': 0xFFFF7043,
    });

    // Insertion dans la table SessionExercise
    await db.insert('SessionExercise', {
      'exercise_id': 1,
      'session_id': 1,
    });
    await db.insert('SessionExercise', {
      'exercise_id': 2,
      'session_id': 2,
    });

    // Insertion dans la table Comments
    await db.insert('Comments', {
      'content': 'Great session!',
      'session_id': 1,
      'exercise_id': 1,
      'user_id': 1,
    });

    // Insertion dans la table Date
    await db.insert('Date', {
      'session_id': 1,
      'date': '2024-12-01',
      'recurring': 1,
      'recurrence': 'daily',
    });
    await db.insert('Date', {
      'session_id': 2,
      'date': '2024-12-02',
      'recurring': 0,
    });
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
