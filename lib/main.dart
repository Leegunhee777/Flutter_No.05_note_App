import 'package:flutter/material.dart';
import 'package:note/di/provider_setup.dart';
import 'package:note/presentation/notes/notes_screen.dart';
import 'package:note/ui/colors.dart';
import 'package:provider/provider.dart';

void main() async {
  //플랫폼 채널의 위젯 바인딩을 보장한다.
  WidgetsFlutterBinding.ensureInitialized();
  final providers = await getProviders();
  runApp(MultiProvider(
    providers: providers,
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
            //radio버튼을 하얀색으로 바꾸기위한속성
            unselectedWidgetColor: Colors.white,

            //상단바의 백그라운드를 바꾸는 primarySwatch
            // primarySwatch: Colors.deepOrange,
            primaryColor: Colors.white,

            //appBar의 생상을 지정해줄수있는 방법
            appBarTheme: Theme.of(context).appBarTheme.copyWith(
                  backgroundColor: darkGray,
                ),
            //스크린의 백그라운드 색깔과 관련된 canvasColor
            canvasColor: darkGray,
            //플로팅버튼과 관련된 백그라운드 색깔과 관련된 floatingActionButtonTheme
            floatingActionButtonTheme:
                Theme.of(context).floatingActionButtonTheme.copyWith(
                      backgroundColor: Colors.white,
                      foregroundColor: darkGray,
                    ),

            //text의 색상을 바꾸기위한 컬러
            textTheme: Theme.of(context).textTheme.apply(
                  bodyColor: Colors.white,
                )),
        home: const NotesScreen());
  }
}
