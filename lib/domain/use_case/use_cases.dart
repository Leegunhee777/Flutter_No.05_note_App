import 'package:note/domain/use_case/add_note.dart';
import 'package:note/domain/use_case/delete_note.dart';
import 'package:note/domain/use_case/get_note.dart';
import 'package:note/domain/use_case/get_notes.dart';
import 'package:note/domain/use_case/update_note.dart';

class UseCases {
  final AddNoteUseCase addNoteUseCase;
  final DeleteNoteUseCase deleteNoteUseCase;
  final GetNoteUseCase getNoteUseCase;
  final GetNotesUseCase getNotesUseCase;
  final UpdateNoteUseCase updateNoteUseCase;

  UseCases({
    required this.addNoteUseCase,
    required this.deleteNoteUseCase,
    required this.getNoteUseCase,
    required this.getNotesUseCase,
    required this.updateNoteUseCase,
  });
}
