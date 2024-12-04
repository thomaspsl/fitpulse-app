import 'package:fitpulse_app/data/models/exercise.dart';

enum SessionType { AMRAP, EMOM, HIIT }

class Session {
  final int? id;
  final String name;
  final List<Exercise> exercises;
  final SessionType type;
  final String category;
  final int recovery;

  Session(
      {this.id,
      required this.name,
      required this.exercises,
      required this.type,
      required this.category,
      required this.recovery});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'type': type.index,
      'category': category,
      'recovery': recovery
    };
  }

  factory Session.fromMap(Map<String, dynamic> map, List<Exercise> exercises) {
    return Session(
      id: map['id'],
      name: map['name'],
      exercises: exercises,
      type: SessionType.values.firstWhere(
        (e) => e.toString().split('.').last == map['type'],
      ),
      category: map['category'],
      recovery: map['recovery'],
    );
  }

  Session copyWith(
      {int? id,
      String? name,
      List<Exercise>? exercises,
      SessionType? type,
      String? category,
      int? recovery}) {
    return Session(
        id: id ?? this.id,
        name: name ?? this.name,
        exercises: exercises ?? this.exercises,
        type: type ?? this.type,
        category: category ?? this.category,
        recovery: recovery ?? this.recovery);
  }
}
