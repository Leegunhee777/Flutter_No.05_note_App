import 'package:note/domain/model/note.dart';
import 'package:sqflite/sqlite_api.dart';

class NoteDbHelper {
  Database db;

  NoteDbHelper(this.db);

//Note? 라고하면 null이 반환될수있음을 명시
// whereArgs: [id]로 하고 where: 'id = ?'라고 해주면 우리가 getNoteById로 받은 id 인자를
// ?에 맵핑 시켜줄수있게된다.
//'note'는 테이블명을 의미
  Future<Note?> getNoteById(int id) async {
    final List<Map<String, dynamic>> maps = await db.query(
      'note',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return Note.fromJson(maps.first);
    }

    return null;
  }

  Future<List<Note>> getNotes() async {
    final maps = await db.query('note');
    return maps.map((e) => Note.fromJson(e)).toList();
  }

  //로컬 db에 insert할때는 json형태로 넣어줘야함
  // db.insert메소드는 response로 insert된 데이터의 id를 반환해주는데 나중에 필요하면 사용해도된다.
  Future<void> insertNote(Note note) async {
    await db.insert('note', note.toJson());
  }

  //로컬 db를 update할때는 json형태로 넣어줘야함
  //where: 'id = ?' 해주고 whereArgs:[note.id] 해주면
  //note.id가 ?에 맵핑되서 들어가게됨
  //db.update는 업데이트된 데이터의 총 갯수를 반환해주는데 필요하면 사용해도됨
  Future<void> updateNote(Note note) async {
    await db.update(
      'note',
      note.toJson(),
      where: 'id = ?',
      whereArgs: [note.id],
    );
  }

  //db.delete는 삭제된 데이터의 총 갯수를 반환해주는데 필요하면 사용해도됨
  Future<void> deleteNote(Note note) async {
    await db.delete(
      'note',
      where: 'id = ?',
      whereArgs: [note.id],
    );
  }
}
