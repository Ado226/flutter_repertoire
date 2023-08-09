import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_todo/bloc/note_bloc.dart';
import 'package:test_todo/screens/note_liste_screen.dart';
import 'package:test_todo/service/note_repository.dart';

void main() {
  runApp(
    BlocProvider(
      create: (context) {
        return NoteBloc(repository);
      },
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
