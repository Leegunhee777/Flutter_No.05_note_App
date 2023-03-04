import 'package:flutter_test/flutter_test.dart';
import 'package:note/domain/model/note.dart';
import 'package:note/domain/repository/note_repository.dart';
import 'package:note/domain/use_case/get_notes.dart';
import 'package:note/domain/util/note_order.dart';
import 'package:note/domain/util/order_type.dart';

//mockito의 Fake 클래스를 extends를하면
//NoteRepostiory를 implements하는 데도 불구하고
//모든 메소드를 구현하지 않아도 에러가 뜨지않는다.
//원하는 메소드만 테스트 가능!
class FakeNoteRepositoryImpl extends Fake implements NoteRepository {
  @override
  Future<List<Note>> getNotes() async {
    return [
      Note(title: 'title', content: 'content', timestamp: 0, color: 1),
      Note(title: 'title2', content: 'content2', timestamp: 2, color: 2),
    ];
  }
}

void main() {
  test('정렬 기능이 잘 작동해야한다.', () async {
    final repository = FakeNoteRepositoryImpl();
    final getNotesUseCase = GetNotesUseCase(repository);

    //getNotesUseCase.excute는 Future 타입을 반환한다. Future타입을 반환하는 메소드는 앞에
    //무조건 await를 붙여줘야한다.
    List<Note> result =
        await getNotesUseCase.excute(NoteOrder.date(OrderType.descending()));

    //isA를 사용하면 타입검사를 할수있다.
    expect(result, isA<List<Note>>());
    expect(result[0].timestamp, 2);

    result =
        await getNotesUseCase.excute(NoteOrder.date(OrderType.ascending()));
    expect(result[0].timestamp, 0);

    result =
        await getNotesUseCase.excute(NoteOrder.title(OrderType.ascending()));
    expect(result[0].title, 'title');

    result =
        await getNotesUseCase.excute(NoteOrder.title(OrderType.descending()));
    expect(result[0].title, 'title2');

    result =
        await getNotesUseCase.excute(NoteOrder.color(OrderType.ascending()));
    expect(result[0].color, 1);

    result =
        await getNotesUseCase.excute(NoteOrder.color(OrderType.descending()));
    expect(result[0].color, 2);
  });
}
