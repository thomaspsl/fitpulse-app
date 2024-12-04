class Exercise {
  final int? id;
  final Duration? time;
  final int? nb;
  final String name;
  final String category;
  final bool isTime;
  final int sessions;
  final Duration recovery;

  Exercise({
    this.id,
    this.time,
    this.nb,
    required this.name,
    required this.category,
    required this.isTime,
    required this.sessions,
    required this.recovery,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'time': time?.inSeconds,
      'nb': nb,
      'name': name,
      'category': category,
      'is_time': isTime ? 1 : 0,
      'sessions': sessions,
      'recovery': recovery.inSeconds,
    };
  }

  factory Exercise.fromMap(Map<String, dynamic> map) {
    return Exercise(
      id: map['id'],
      name: map['name'],
      category: map['category'],
      isTime: map['is_time'] == 1,
      time: map['time'] != null ? Duration(seconds: map['time']) : null,
      nb: map['nb'],
      sessions: map['sessions'],
      recovery: Duration(seconds: map['recovery']),
    );
  }

  Exercise copyWith({
    int? id,
    String? name,
    bool? isTime,
    String? category,
    Duration? time,
    int? nb,
    int? sessions,
    Duration? recovery,
  }) {
    return Exercise(
      id: id ?? this.id,
      name: name ?? this.name,
      category: category ?? this.category,
      isTime: isTime ?? this.isTime,
      time: time ?? this.time,
      nb: nb ?? this.nb,
      sessions: sessions ?? this.sessions,
      recovery: recovery ?? this.recovery,
    );
  }
}
