import 'package:note/domain/model/note.dart';
import 'package:note/domain/repository/note_repository.dart';

class AddNoteUseCase {
  final NoteRepository repository;

  AddNoteUseCase(this.repository);

  Future<void> excute(Note note) async {
    await repository.insertNote(note);
  }
}
