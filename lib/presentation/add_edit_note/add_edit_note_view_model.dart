import 'dart:async';

import 'package:flutter/material.dart';
import 'package:note/domain/model/note.dart';
import 'package:note/domain/repository/note_repository.dart';
import 'package:note/presentation/add_edit_note/add_edit_note_ui_event.dart';
import 'package:note/presentation/add_edit_note/add_edit_note_event.dart';

import 'package:note/ui/colors.dart';

class AddEditNoteViewModel with ChangeNotifier {
  final NoteRepository repository;

  int _color = roseBud.value;
  int get color => _color;

  final _eventController = StreamController<AddEditNoteUiEvent>.broadcast();
  Stream<AddEditNoteUiEvent> get eventStream => _eventController.stream;

  AddEditNoteViewModel(this.repository);

  //onEvent 메소드를 통해, 분기점을 하나로 반들어 관리하기위함
  void onEvent(AddEditNoteEvent event) {
    if (event is ChangeColor) {
      _changeColor(event.color);
    } else if (event is SaveNote) {
      _saveNote(event.id, event.title, event.content);
    }
  }

  Future<void> _changeColor(int color) async {
    _color = color;
    notifyListeners();
  }

  Future<void> _saveNote(int? id, String title, String content) async {
    //id 가 null 인경우는 새로운 노트를 작성하는 경우이다.
    if (id == null) {
      await repository.insertNote(
        Note(
          title: title,
          content: content,
          color: _color,
          //현재 시간을 밀리세컨즈단위로 나타낸것
          timestamp: DateTime.now().millisecondsSinceEpoch,
        ),
      );
    } else {
      //id가 있는경우는 기존에 존재하는 노트를 수정하는 경우이다.
      await repository.updateNote(Note(
        id: id,
        title: title,
        content: content,
        color: _color,
        timestamp: DateTime.now().millisecondsSinceEpoch,
      ));
    }

    _eventController.add(AddEditNoteUiEvent.savedNote());
  }
}
