//dataLayer의 data_source와 소통하는 interface를 정의
import 'package:note/domain/model/note.dart';

abstract class NoteRepository {
  Future<List<Note>> getNotes();
  Future<Note?> getNoteById(int id);
  Future<void> insertNote(Note note);
  Future<void> updateNote(Note note);
  Future<void> deleteNote(Note note);
}
