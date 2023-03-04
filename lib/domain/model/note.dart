class Note {
  late final String title;
  late final String content;
  late final int color;
  late final int timestamp;
  late final int? id;
  Note({
    required this.title,
    required this.content,
    required this.color,
    required this.timestamp,
    this.id,
  });

  Note.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    content = json['content'];
    color = json['color'];
    timestamp = json['timestamp'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['title'] = title;
    data['content'] = content;
    data['color'] = color;
    data['timestamp'] = timestamp;
    data['id'] = id;
    return data;
  }

  //객체 복사를 통해서 상태를 바꿔준다.
  Note copy({
    String? title,
    String? content,
    int? color,
    int? timestamp,
    int? id,
  }) {
    return Note(
      title: title ??= this.title,
      content: content ??= this.content,
      color: color ??= this.color,
      timestamp: timestamp ??= this.timestamp,
      id: id ??= this.id,
    );
  }
}
