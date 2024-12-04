import 'package:fitpulse_app/data/models/date.dart';
import 'package:fitpulse_app/data/repositories/date.dart';
import 'package:flutter/material.dart';

class DateProvider with ChangeNotifier {
  final DateRepository _repository = DateRepository();

  final List<Date> _dates = [];

  List<Date> get dates => _dates;

  Future<void> index() async {
    _dates.clear();
    final dates = await _repository.index();
    _dates.addAll(dates);
    notifyListeners();
  }

  Future<void> store(Date date) async {
    await _repository.store(date);
    _dates.add(date);
    notifyListeners();
  }

  Future<void> storeRecurring(Date date, int weekday) async {
    await _repository.storeRecurring(date, weekday);
    await index();
  }

  Future<void> destroy(Date date) async {
    await _repository.destroy(date);
    _dates.removeWhere(
            (e) => e.session.id == date.session.id && e.date == date.date);
    notifyListeners();
  }

  Future<void> destroyRecurring(Date date) async {
    await _repository.destroyRecurring(date);
    _dates.removeWhere((e) =>
    e.session.id == date.session.id &&
        (e.date.isAfter(date.date) || isSameDay(e.date, date.date)));
    notifyListeners();
  }

  List<Date> findByDay(DateTime day) {
    return _dates.where((date) => isSameDay(date.date, day)).toList();
  }

  bool isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }
}
