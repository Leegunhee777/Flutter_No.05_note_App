import 'package:note/domain/model/note.dart';
import 'package:note/domain/repository/note_repository.dart';

class UpdateNoteUseCase {
  final NoteRepository repository;

  UpdateNoteUseCase(this.repository);

  Future<void> excute(Note note) async {
    await repository.updateNote(note);
  }
}
