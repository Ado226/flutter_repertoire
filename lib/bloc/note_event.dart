import 'package:equatable/equatable.dart';
import 'package:test_todo/model/note_model.dart';

abstract class NoteEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchNotes extends NoteEvent {}

class AddNote extends NoteEvent {
  final Note note;

  AddNote(this.note);

  @override
  List<Object?> get props => [note];
}

class UpdateNote extends NoteEvent {
  final Note note;

  UpdateNote(this.note);

  @override
  List<Object?> get props => [note];
}

class DeleteNote extends NoteEvent {
  final int id;

  DeleteNote(this.id);

  @override
  List<Object?> get props => [id];
}
