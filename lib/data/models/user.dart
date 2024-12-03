// Object color
import 'dart:ui';

class User {
  final int? id;
  final String name;
  final String email;
  final String password;
  final Color color;

  User({
    this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.color,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email' : email,
      'password' : password,
      'color': color.value,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      password: map['password'],
      color: Color(map['color']),
    );
  }

  User copyWith({
    int? id,
    String? name,
    String? email,
    String? password,
    Color? color,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      color: color ?? this.color,
    );
  }
}
