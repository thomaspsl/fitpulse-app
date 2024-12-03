import 'package:fitpulse_app/data/models/session.dart';

class Date {
  final DateTime date;
  final Session session;
  final bool? recurring;

  Date({
    required this.date,
    required this.session,
    this.recurring
  });
}
