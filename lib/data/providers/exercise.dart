import 'package:fitpulse_app/data/repositories/exercise.dart';
import 'package:fitpulse_app/data/models/exercise.dart';
import 'package:flutter/foundation.dart';

class ExerciseProvider with ChangeNotifier {
  final ExerciseRepository _repository = ExerciseRepository();

  List<Exercise> _exercises = [];

  List<Exercise> get exercises => _exercises;

  ExerciseProvider() { index(); }

  Future<void> index() async {
    _exercises = await _repository.index();
    notifyListeners();
  }

  Future<void> store(Exercise exercise) async {
    final id = await _repository.store(exercise);
    exercise = exercise.copyWith(id: id);
    _exercises.add(exercise);
    notifyListeners();
  }

  Future<void> update(Exercise exercise) async {
    if (exercise.id != null) {
      await _repository.update(exercise);
      final index = _exercises.indexWhere((e) => e.id == exercise.id);
      if (index != -1) {
        _exercises[index] = exercise;
        notifyListeners();
      }
    }
  }

  Future<void> destroy(int index) async {
    final exercise = _exercises[index];
    print(exercise.id);
    if (exercise.id != null) {
      await _repository.destroy(exercise.id!);
    }
    _exercises.removeAt(index);
    notifyListeners();
  }
}
