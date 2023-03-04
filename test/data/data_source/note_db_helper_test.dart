import 'package:flutter_test/flutter_test.dart';
import 'package:note/data/data_source/note_db_helper.dart';
import 'package:note/domain/model/note.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  test('db test', () async {
    //실제 db가 아닌 메모리상에 임시로 db를 작성해서 테스트 해볼수있다.
    final db = await databaseFactoryFfi.openDatabase(inMemoryDatabasePath);

    //note 테이클과 그에 대한 스키마를 명시해준다.
    await db.execute(
        'CREATE TABLE note (id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, content TEXT, color INTEGER, timestamp INTEGER)');

    //테스트할 대상인 NoteDbHelper클래스를 가져온다.
    final noteDbHelper = NoteDbHelper(db);

    await noteDbHelper.insertNote(
        Note(title: 'test', content: 'test', color: 1, timestamp: 1));

    expect((await noteDbHelper.getNotes()).length, 1);

    Note note = (await noteDbHelper.getNoteById(1))!;
    expect(note.id, 1);

    Note copyNoteResult = note.copy(title: 'change');
    await noteDbHelper.updateNote(copyNoteResult);

    note = (await noteDbHelper.getNoteById(1))!;
    expect(note.title, 'change');

    await noteDbHelper.deleteNote(note);
    expect((await noteDbHelper.getNotes()).length, 0);

    await db.close();
  });
}
