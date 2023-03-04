//viewModel에서 어떤 이벤트를 UI쪽으로 알려주고자 할때 사용
abstract class AddEditNoteUiEvent {
  factory AddEditNoteUiEvent.savedNote() {
    return SavedNote();
  }
}

class SavedNote implements AddEditNoteUiEvent {
  SavedNote();
}
