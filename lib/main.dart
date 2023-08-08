import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_todo/bloc/note_bloc.dart';
import 'package:test_todo/screens/note_liste_screen.dart';
import 'package:test_todo/service/note_repository.dart';
import 'package:test_todo/service/db_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final dbHelper = DbHelper();
  await dbHelper.initDb();
  final dataProvider = DataProvider(dbHelper);
  final repository = Repository(dataProvider);

  runApp(
    BlocProvider(
      create: (context) => NoteBloc(repository),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TodoApp',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: NoteListView(),
    );
  }
}
