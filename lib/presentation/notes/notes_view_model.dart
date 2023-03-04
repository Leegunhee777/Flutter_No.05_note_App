import 'package:flutter/material.dart';
import 'package:note/domain/model/note.dart';
import 'package:note/domain/use_case/use_cases.dart';
import 'package:note/domain/util/note_order.dart';
import 'package:note/domain/util/order_type.dart';
import 'package:note/presentation/notes/notes_event.dart';
import 'package:note/presentation/notes/notes_state.dart';

class NotesViewModel with ChangeNotifier {
  final UseCases useCases;
  NotesState _state = NotesState(
    [],
    NoteOrder.date(OrderType.descending()),
    false,
  );

  //외부에 제공해줄 목적의 geter state , getter는 읽기만가능하다.
  NotesState get state => _state;

  Note? _recentlyDeleteNote;

  //repository에 대한 초기화 진행 + 생성자호출시 로직추가가능
  NotesViewModel(
    this.useCases,
  ) {
    _loadNotes();
  }

  //state클래스를 분리하고난후 더이상 필요없다.
  // final List<Note> _notes = [];
  // UnmodifiableListView<Note> get notes => UnmodifiableListView(_notes);

  void onEvent(NotesEvent event) {
    if (event is LoadNotes) {
      _loadNotes();
    } else if (event is DeleteNote) {
      _deleteNote(event.note);
    } else if (event is RestoreNote) {
      _restoreNote();
    } else if (event is ChangeOrder) {
      _state = state.copy(
        noteOrder: event.noteOrder,
      );
      _loadNotes();
    } else if (event is ToggleOrderSection) {
      _state = state.copy(
        isOrderSectionVisible: !state.isOrderSectionVisible,
      );
      notifyListeners();
    }
  }

  Future<void> _loadNotes() async {
    //가져온 리스트를 타임 스템프기준 오름차순 정렬
    //새로등록되거나 수정되는게 맨위로 오게된다.
    //추가적인 각종필터기능이 있다면 리스트에 대한,필터에 대한 로직은 여기에 위치하게된다!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    //But useCase를 통해 로직을 분리해보자!!!!
    // notes.sort(((a, b) => -a.timestamp.compareTo(b.timestamp)));

    //state.noteOrder의 초깃값은  NoteOrder.date(OrderType.descending())으로 되어있다.
    List<Note> notes = await useCases.getNotesUseCase.excute(state.noteOrder);

    _state = state.copy(notes: notes);
    notifyListeners();
  }

  Future<void> _deleteNote(Note note) async {
    await useCases.deleteNoteUseCase.excute(note);
    _recentlyDeleteNote = note;
    await _loadNotes();
  }

  Future<void> _restoreNote() async {
    if (_recentlyDeleteNote != null) {
      await useCases.addNoteUseCase.excute(_recentlyDeleteNote!);
      _recentlyDeleteNote = null;
      _loadNotes();
    }
  }
}
