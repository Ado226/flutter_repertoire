import 'package:equatable/equatable.dart';
import 'package:test_todo/model/note_model.dart';

abstract class NoteState extends Equatable {
  @override
  List<Object?> get props => [];
}

class NoteInitialState extends NoteState {}

class NoteLoadingState extends NoteState {}

class NoteLoadedState extends NoteState {
  final List<Note> notes;

  NoteLoadedState(this.notes);

  @override
  List<Object?> get props => [notes];
}

class NoteErrorState extends NoteState {
  final String error;

  NoteErrorState(this.error);

  @override
  List<Object?> get props => [error];
}
