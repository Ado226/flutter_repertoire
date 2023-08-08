import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_todo/bloc/note_event.dart';
import 'package:test_todo/bloc/note_state.dart';
import 'package:test_todo/model/note_model.dart';
import 'package:test_todo/service/note_repository.dart';
import 'package:test_todo/service/db_helper.dart';

class NoteBloc extends Bloc<NoteEvent, NoteState> {
  final DbHelper dbHelper = DbHelper();
  final Repository repository = Repository(DataProvider(DbHelper()));

  NoteBloc(Repository repository) : super(NoteInitialState()) {
    on<FetchNotes>(_onFetchNotes);
    on<AddNote>(_onAddNote);
    on<UpdateNote>(_onUpdateNote);
    on<DeleteNote>(_onDeleteNote);
  }

  void _onFetchNotes(FetchNotes event, Emitter<NoteState> emit) async {
    emit(NoteLoadingState());
    try {
      final List<Note> notes = await repository.getAllNotes();
      emit(NoteLoadedState(notes));
    } catch (error) {
      emit(NoteErrorState(error.toString()));
    }
  }

  void _onAddNote(AddNote event, Emitter<NoteState> emit) async {
    try {
      await repository.addNote(event.note);
      final List<Note> updatedNotes = await repository.getAllNotes();
      emit(NoteLoadedState(updatedNotes));
    } catch (error) {
      emit(NoteErrorState(error.toString()));
    }
  }

  void _onUpdateNote(UpdateNote event, Emitter<NoteState> emit) async {
    try {
      await repository.updateNote(event.note);
      final List<Note> updatedNotes = await repository.getAllNotes();
      emit(NoteLoadedState(updatedNotes));
    } catch (error) {
      emit(NoteErrorState(error.toString()));
    }
  }

  void _onDeleteNote(DeleteNote event, Emitter<NoteState> emit) async {
    try {
      await repository.deleteNoteById(event.noteId);
      final List<Note> updatedNotes = await repository.getAllNotes();
      emit(NoteLoadedState(updatedNotes));
    } catch (error) {
      emit(NoteErrorState(error.toString()));
    }
  }
}
