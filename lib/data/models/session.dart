import 'package:fitpulse_app/data/models/exercise.dart';

enum SessionType { AMRAP, EMOM, HIIT }

class Session {
  final int? id;
  final String name;
  final List<Exercise> exercises;
  final SessionType type;
  final int recovery;

  Session({
    this.id,
    required this.name,
    required this.exercises,
    required this.type,
    required this.recovery
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'type': type.index,
      'recovery': recovery
    };
  }

  factory Session.fromMap(Map<String, dynamic> map, List<Exercise> exercises) {
    return Session(
        id: map['id'],
        name: map['name'],
        exercises: exercises,
        type: SessionType.values[int.parse(map['type'].toString())],
        recovery: map['recovery']
    );
  }

  Session copyWith({
    int? id,
    String? name,
    List<Exercise>? exercises,
    SessionType? type,
    int? recovery
  }) {
    return Session(
        id: id ?? this.id,
        name: name ?? this.name,
        exercises: exercises ?? this.exercises,
        type: type ?? this.type,
        recovery: recovery ?? this.recovery
    );
  }
}
