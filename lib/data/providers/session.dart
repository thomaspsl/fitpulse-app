import 'package:fitpulse_app/data/models/session.dart';
import 'package:fitpulse_app/data/repositories/session.dart';
import 'package:flutter/foundation.dart';

class SessionsProvider with ChangeNotifier {
  List<Session> _sessions = [];
  final SessionRepository _repository = SessionRepository();

  List<Session> get sessions => _sessions;

  SessionsProvider() { index(); }

  Future<void> index() async {
    _sessions = await _repository.index();
    notifyListeners();
  }

  Future<void> store(Session session) async {
    final id = await _repository.store(session);
    session = session.copyWith(id: id);
    _sessions.add(session);
    notifyListeners();
  }

  Future<void> update(Session session) async {
    if (session.id != null) {
      await _repository.update(session);
      final index = _sessions.indexWhere((e) => e.id == session.id);
      if (index != -1) {
        _sessions[index] = session;
        notifyListeners();
      }
    }
  }

  Future<void> delete(int index) async {
    final session = _sessions[index];
    if (session.id != null) {
      await _repository.destroy(session.id!);
    }
    _sessions.removeAt(index);
    notifyListeners();
  }
}
