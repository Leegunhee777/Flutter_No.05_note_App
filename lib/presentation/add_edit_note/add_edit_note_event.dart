abstract class AddEditNoteEvent {
  factory AddEditNoteEvent.changeColor(int color) {
    return ChangeColor(color);
  }

  factory AddEditNoteEvent.saveNote(int? id, String title, String content) {
    return SaveNote(
      id: id,
      title: title,
      content: content,
    );
  }
}

class ChangeColor implements AddEditNoteEvent {
  final int color;
  ChangeColor(this.color);
}

class SaveNote implements AddEditNoteEvent {
  final int? id;
  final String title;
  final String content;

  SaveNote({
    this.id,
    required this.title,
    required this.content,
  });

  int? get note => null;
}
