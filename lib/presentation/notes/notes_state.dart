import 'package:note/domain/model/note.dart';
import 'package:note/domain/util/note_order.dart';

class NotesState {
  final List<Note> _notes;
  final NoteOrder _noteOrder;
  //상단 필터 위젯의 노출여부
  final bool _isOrderSectionVisible;
  const NotesState(this._notes, this._noteOrder, this._isOrderSectionVisible);

//객체 복사를 통해서 상태를 바꿔준다.
  NotesState copy(
      {List<Note>? notes, NoteOrder? noteOrder, bool? isOrderSectionVisible}) {
    //photos or isLoading값이 없다면 기존값을 넣어준다!
    return NotesState(
      notes ??= _notes,
      noteOrder ??= _noteOrder,
      isOrderSectionVisible ??= _isOrderSectionVisible,
    );
  }

  //getter의 List<Note> 반환타입을 명시해주지 않으면!!! .notes는 dynamic type으로 인식됨
  //그래서 다른곳에서 notes.map도 못쓰게됨 dynamic type으로 인식되어서
  List<Note> get notes => _notes;

  NoteOrder get noteOrder => _noteOrder;

  bool get isOrderSectionVisible => _isOrderSectionVisible;
}
