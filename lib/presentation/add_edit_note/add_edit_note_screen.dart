import 'dart:async';

import 'package:flutter/material.dart';
import 'package:note/domain/model/note.dart';
import 'package:note/presentation/add_edit_note/add_edit_note_event.dart';
import 'package:note/presentation/add_edit_note/add_edit_note_ui_event.dart';
import 'package:note/presentation/add_edit_note/add_edit_note_view_model.dart';
import 'package:note/ui/colors.dart';
import 'package:provider/provider.dart';

class AddEditNoteScreen extends StatefulWidget {
  final Note? note;
  const AddEditNoteScreen({super.key, this.note});

  @override
  State<AddEditNoteScreen> createState() => _AddEditNoteScreenState();
}

class _AddEditNoteScreenState extends State<AddEditNoteScreen> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();

  //Stream을 사용할떄 기본적으로 _streamSubscription를 이용하여 dispose될때는 .cancel해줘야 메모리최적화가된다.
  StreamSubscription? _streamSubscription;

  final List<Color> noteColors = [
    roseBud,
    primrose,
    wisteria,
    skyBlue,
    illusion,
  ];

  @override
  void initState() {
    super.initState();

    if (widget.note != null) {
      _titleController.text = widget.note!.title;
      _contentController.text = widget.note!.content;
    }
    final viewModel = context.read<AddEditNoteViewModel>();
    _streamSubscription = viewModel.eventStream.listen((event) {
      if (event is SavedNote) {
        //이전의 화면으로 되돌리는 방법
        //두번째 인자로 true를 넣어준이유는 saved버튼을 통해서 저장작업을 마치고 뒤로가는건지,
        //그냥 모바일에서 제공하는 뒤로가기 버튼을 눌러서 뒤로가는건지 구분하기위함
        //모바일에서 제공하는 뒤로가기 버튼을 눌러서 뒤로갔다면 뒤로간화면에서 data를 reload할필요가 없기떄문이다.
        //add_edit_note_screen화면에서 Navigator.pop(context, true)해주면
        //note_screen.dart화면의 Navigator.push를 trigger해준 쪽에서 boolean으로 받아볼수있음
        Navigator.pop(context, true);
      }
    });
    //약간의 지연을 위해 microtask안에 사용해야할떄도 있었으나 지금은 아니다.
    // Future.microtask(() {
    //   final viewModel = context.read<AddEditNoteViewModel>();
    // });
  }

  @override
  void dispose() {
    //dispose될때 stream.listen을 cancel해줘야 한다!!!
    _streamSubscription?.cancel();
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<AddEditNoteViewModel>();

    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            if (_titleController.text.isEmpty ||
                _contentController.text.isEmpty) {
              //스낵바 띄우는 법
              const snackBar = SnackBar(content: Text('제목이나 내용이 비어있습니다.'));
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            } else {
              viewModel.onEvent(AddEditNoteEvent.saveNote(
                //build 내부에서 statefulWidget의 멤버변수에 접근하려면 widget.을 붙여줘야함
                widget.note == null ? null : widget.note!.id,
                _titleController.text,
                _contentController.text,
              ));
            }
          },
          child: const Icon(Icons.save),
        ),
        body: AnimatedContainer(
          duration: const Duration(
            milliseconds: 500,
          ),
          padding:
              const EdgeInsets.only(left: 16, right: 16, bottom: 16, top: 48),
          color: Color(viewModel.color),
          child: ListView(
            children: [
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: noteColors
                      .map((color) => InkWell(
                            onTap: () {
                              viewModel.onEvent(
                                  AddEditNoteEvent.changeColor(color.value));
                            },
                            child: _buildBackgroundColor(
                              color: color,
                              selected: viewModel.color == color.value,
                            ),
                          ))
                      .toList()),
              TextField(
                controller: _titleController,
                maxLines: 1,
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall!
                    .copyWith(color: darkGray),
                decoration: const InputDecoration(
                  //placeholder역할
                  hintText: '제목을 입력하세요',
                  // input textDecoration 날리는 용도
                  border: InputBorder.none,
                ),
              ),
              TextField(
                controller: _contentController,
                maxLines: null,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(color: darkGray),
                decoration: const InputDecoration(
                  //placeholder역할
                  hintText: '내용을 입력하세요',
                  // input textDecoration 날리는 용도
                  border: InputBorder.none,
                ),
              )
            ],
          ),
        ));
  }

  Widget _buildBackgroundColor({
    required Color color,
    required bool selected,
  }) {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 5,
          ),
        ],
        border: selected
            ? Border.all(
                color: Colors.black,
                width: 3.0,
              )
            : null,
      ),
    );
  }
}
