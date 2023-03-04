import 'package:note/data/data_source/note_db_helper.dart';
import 'package:note/data/repository/note_repository.impl.dart';
import 'package:note/domain/repository/note_repository.dart';
import 'package:note/domain/use_case/add_note.dart';
import 'package:note/domain/use_case/delete_note.dart';
import 'package:note/domain/use_case/get_note.dart';
import 'package:note/domain/use_case/get_notes.dart';
import 'package:note/domain/use_case/update_note.dart';
import 'package:note/domain/use_case/use_cases.dart';
import 'package:note/presentation/add_edit_note/add_edit_note_view_model.dart';
import 'package:note/presentation/notes/notes_view_model.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:sqflite/sqflite.dart';

Future<List<SingleChildWidget>> getProviders() async {
  //Database를 await로 끌고들어와야하고, 그러려면 async를 써야하고 그러면
  //어쩔수 없이 getProviders함수는 Future<..>를 리턴하게된다.
  //Database를 위한 await가 필요없었다면, async도 필요없고 그렇게 되면 Future타입도 반환될 필요도 없다.
  Database database = await openDatabase('notes_db', version: 1,
      onCreate: ((db, version) async {
    await db.execute(
        'CREATE TABLE note (id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, content TEXT, color INTEGER, timestamp INTEGER)');
  }));

  NoteDbHelper noteDbHelper = NoteDbHelper(database);
  NoteRepository noteRepository = NoteRepositoryImpl(noteDbHelper);

  UseCases useCases = UseCases(
      addNoteUseCase: AddNoteUseCase(noteRepository),
      deleteNoteUseCase: DeleteNoteUseCase(noteRepository),
      getNoteUseCase: GetNoteUseCase(noteRepository),
      getNotesUseCase: GetNotesUseCase(noteRepository),
      updateNoteUseCase: UpdateNoteUseCase(noteRepository));

  NotesViewModel notesViewModel = NotesViewModel(useCases);

  AddEditNoteViewModel addEditNoteViewModel =
      AddEditNoteViewModel(noteRepository);
  return [
    ChangeNotifierProvider(create: (_) => notesViewModel),
    ChangeNotifierProvider(
      create: (_) => addEditNoteViewModel,
    ),
  ];
}
