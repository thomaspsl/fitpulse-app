import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  dynamic _user;

  dynamic get user => _user;

  Future<void> update(dynamic user) async {
    _user = user;
    notifyListeners();
  }
}