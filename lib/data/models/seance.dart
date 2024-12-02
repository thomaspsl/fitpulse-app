class Seance {
  final int? id;
  final String nom;
  final String type;
  final String date;
  final int notification;

  Seance({
    this.id,
    required this.nom,
    required this.type,
    required this.date,
    required this.notification,
  });

  // Convertir une séance en Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nom': nom,
      'type': type,
      'date': date,
      'notification': notification,
    };
  }

  // Convertir un Map en séance
  factory Seance.fromMap(Map<String, dynamic> map) {
    return Seance(
      id: map['id'] as int?,
      nom: map['nom'] as String,
      type: map['type'] as String,
      date: map['date'] as String,
      notification: map['notification'] as int,
    );
  }

  @override
  String toString() {
    return 'Seance{id: $id, nom: $nom, type: $type, date: $date, notification: $notification}';
  }
}
