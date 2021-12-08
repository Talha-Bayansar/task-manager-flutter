class Subject {
  final String id, title, color;

  Subject({required this.color, required this.title, required this.id});

  factory Subject.fromJson(Map<String, dynamic> json) {
    return Subject(
      id: json['id'],
      color: json['color'],
      title: json['title'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'color': color,
      };
}
