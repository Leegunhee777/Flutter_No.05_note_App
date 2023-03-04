import 'package:flutter/material.dart';
import 'package:note/presentation/add_edit_note/add_edit_note_screen.dart';
import 'package:note/presentation/notes/components/note_item.dart';
import 'package:note/presentation/notes/components/order_section.dart';
import 'package:note/presentation/notes/notes_event.dart';
import 'package:note/presentation/notes/notes_view_model.dart';
import 'package:provider/provider.dart';

class NotesScreen extends StatelessWidget {
  const NotesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<NotesViewModel>();
    final state = viewModel.state;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Your note',
          style: TextStyle(
            fontSize: 30,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              viewModel.onEvent(NotesEvent.toggleOrderSection());
            },
            icon: const Icon(Icons.sort),
          ),
        ],
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: state.isOrderSectionVisible
                  ? OrderSection(
                      noteOrder: state.noteOrder,
                      onOrderChanged: (noteOrder) {
                        viewModel.onEvent(NotesEvent.changeOrder(noteOrder));
                      },
                    )
                  : Container(),
            ),
            ...state.notes
                .map((note) => GestureDetector(
                      onTap: () async {
                        bool? isSaved = await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AddEditNoteScreen(
                                      note: note,
                                    )));
                        if (isSaved != null && isSaved) {
                          viewModel.onEvent(NotesEvent.loadNotes());
                        }
                      },
                      child: NoteItem(
                        note: note,
                        onDeleteTap: () {
                          viewModel.onEvent(NotesEvent.deleteNote(note));

                          final snackBar = SnackBar(
                            content: const Text('노트가 삭제되었습니다'),
                            action: SnackBarAction(
                                label: '취소',
                                onPressed: () {
                                  viewModel.onEvent(NotesEvent.restoreNote());
                                }),
                          );

                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        },
                      ),
                    ))
                .toList(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (() async {
          // Navigator.pop(context, true)을통해 돌아온 값을 받아볼수가있다. true값을 받아볼수있다.
          bool? isSaved = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: ((context) => const AddEditNoteScreen()),
              ));

          if (isSaved != null && isSaved) {
            //add_edit_note_screen.dart 에서 발생한  Navigator.pop(context, true); 액션에 대한 후속처리로직
            //신가히게도 Navigator.pop을 리슨하고있던것처럼 .pop이 이벤트를 진지해서 pop될때마다 해당 로직을 실행시킬수있다.
            viewModel.onEvent(NotesEvent.loadNotes());
          }
        }),
        child: const Icon(Icons.add),
      ),
    );
  }
}
