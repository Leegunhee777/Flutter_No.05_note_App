import 'package:note/domain/model/note.dart';
import 'package:note/domain/repository/note_repository.dart';
import 'package:note/domain/util/note_order.dart';
import 'package:note/domain/util/order_type.dart';

class GetNotesUseCase {
  final NoteRepository repository;

  GetNotesUseCase(this.repository);

  //GetNotesUseCase 사용되는 viewModel에서 excute호출될때 필터값에 해당되는 noteOrder, orderType을
  //인자로 받게처리한다.
  Future<List<Note>> excute(NoteOrder noteOrder) async {
    List<Note> notes = await repository.getNotes();

    if (noteOrder is NoteOrderTitle) {
      if (noteOrder.orderType is Ascending) {
        notes.sort(((a, b) => a.title.compareTo(b.title)));
      } else if (noteOrder.orderType is Descending) {
        notes.sort(((a, b) => -a.title.compareTo(b.title)));
      }
    } else if (noteOrder is NoteOrderDate) {
      if (noteOrder.orderType is Ascending) {
        notes.sort(((a, b) => a.timestamp.compareTo(b.timestamp)));
      } else if (noteOrder.orderType is Descending) {
        notes.sort(((a, b) => -a.timestamp.compareTo(b.timestamp)));
      }
    } else if (noteOrder is NoteOrderColor) {
      if (noteOrder.orderType is Ascending) {
        notes.sort(((a, b) => a.color.compareTo(b.color)));
      } else if (noteOrder.orderType is Descending) {
        notes.sort(((a, b) => -a.color.compareTo(b.color)));
      }
    }

    return notes;
  }
}
