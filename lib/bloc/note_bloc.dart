import 'package:bloc/bloc.dart';
import '../model/note_model.dart';
import '../service/note_service.dart';
import 'note_event.dart';
import 'note_state.dart';

class NoteBloc extends Bloc<NoteEvent, NoteState> {
  final NoteService noteService;

  NoteBloc({required this.noteService}) : super(NoteLoadingState()) {
    on<FetchNotes>(_onFetchNotes);
    on<AddNote>(_onAddNote);
    on<UpdateNote>(_onUpdateNote);
    on<DeleteNote>(_onDeleteNote);

  }


  void _onFetchNotes(FetchNotes event, Emitter<NoteState> emit) async {
    emit(NoteLoadingState());
    try {
      List<Note> notes = await noteService.getNotes();
      emit(NoteLoadedState(notes));
    } catch (error) {
      emit(NoteErrorState('Failed to fetch notes.'));
    }
  }

  void _onAddNote(AddNote event, Emitter<NoteState> emit) async {
    try {
      await noteService.insertNote(event.note);
      List<Note> notes = await noteService.getNotes();
      emit(NoteLoadedState(notes));
    } catch (error) {
      emit(NoteErrorState('Failed to add note.'));
    }
  }

  void _onUpdateNote(UpdateNote event, Emitter<NoteState> emit) async {
    try {
      await noteService.updateNote(event.note);
      List<Note> notes = await noteService.getNotes();
      emit(NoteLoadedState(notes));
    } catch (error) {
      emit(NoteErrorState('Failed to update note.'));
    }
  }

  void _onDeleteNote(DeleteNote event, Emitter<NoteState> emit) async {
    try {
      await noteService.deleteNote(event.id);
      List<Note> notes = await noteService.getNotes();
      emit(NoteLoadedState(notes));
    } catch (error) {
      emit(NoteErrorState('Failed to delete note.'));
    }
  }
}
