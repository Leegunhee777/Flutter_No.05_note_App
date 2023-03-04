import 'package:note/domain/model/note.dart';
import 'package:note/domain/repository/note_repository.dart';

class GetNoteUseCase {
  final NoteRepository repository;

  GetNoteUseCase(this.repository);

  Future<Note?> excute(int id) async {
    return await repository.getNoteById(id);
  }
}
