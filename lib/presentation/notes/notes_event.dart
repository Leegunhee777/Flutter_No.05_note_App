import 'package:note/domain/model/note.dart';
import 'package:note/domain/util/note_order.dart';

abstract class NotesEvent {
  //아래의 여러가지 이벤트 중 하나로 생성이 될수있는
  //factory 생성자를 명시해준다.
  //Sealed Class라고한다.

  //Result Class 안에서 생성이 되어서 사용되는 형태이다.!!!!!!!!!!

  // Result하고 .찍는게 팩토리의 생성자를 만드는 문법이다.
  factory NotesEvent.loadNotes() {
    return LoadNotes();
  }

  factory NotesEvent.deleteNote(Note note) {
    return DeleteNote(note);
  }

  factory NotesEvent.restoreNote() {
    return RestoreNote();
  }

  factory NotesEvent.changeOrder(NoteOrder noteOrder) {
    return ChangeOrder(noteOrder);
  }

  factory NotesEvent.toggleOrderSection() {
    return ToggleOrderSection();
  }
}

class LoadNotes implements NotesEvent {
  LoadNotes();
}

class DeleteNote implements NotesEvent {
  final Note note;
  DeleteNote(this.note);
}

class RestoreNote implements NotesEvent {
  RestoreNote();
}

class ChangeOrder implements NotesEvent {
  NoteOrder noteOrder;
  ChangeOrder(this.noteOrder);
}

class ToggleOrderSection implements NotesEvent {
  ToggleOrderSection();
}
