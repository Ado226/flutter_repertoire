import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_todo/bloc/note_bloc.dart';
import 'package:test_todo/bloc/note_event.dart';
import 'package:test_todo/bloc/note_state.dart';
import 'package:test_todo/model/note_model.dart';

class NoteListView extends StatefulWidget {
  @override
  _NoteListViewState createState() => _NoteListViewState();
}

class _NoteListViewState extends State<NoteListView> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<NoteBloc>().add(FetchNotes());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Liste des Notes'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Ajouter une note'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: _titleController,
                    decoration: InputDecoration(labelText: 'Titre'),
                  ),
                  TextField(
                    controller: _descriptionController,
                    decoration: InputDecoration(labelText: 'Description'),
                  ),
                ],
              ),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    String title = _titleController.text.trim();
                    String description = _descriptionController.text.trim();
                    if (title.isNotEmpty && description.isNotEmpty) {
                      NoteBloc noteBloc = context.read<NoteBloc>();
                      noteBloc.add(
                        AddNote(
                          Note(

                            libelle: title, // Update this line
                            description: description,
                            date: DateTime.now().toString(),
                          ),
                        ),
                      );
                      Navigator.pop(context);
                      _titleController.clear();
                      _descriptionController.clear();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.lightBlueAccent,
                  ),
                  child: Text('Ajouter'),
                ),
              ],
            ),
          );
        },
        backgroundColor: Colors.lightBlueAccent,
        child: Icon(Icons.add),
      ),
      body: BlocBuilder<NoteBloc, NoteState>(
        builder: (context, state) {
          if (state is NoteLoadingState) {
            return Center(child: CircularProgressIndicator());
          } else if (state is NoteLoadedState) {
            final notes = state.notes;
            return ListView.builder(
              itemCount: notes.length,
              itemBuilder: (context, index) {
                final note = notes[index];
                return ListTile(
                  title: Text(note.libelle),
                  subtitle: Text(note.description),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          context.read<NoteBloc>().add(DeleteNote(note.id!));
                        },
                        color: Color(0xFFE57373),
                      ),
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text('Modifier la note'),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  TextField(
                                    controller: _titleController,
                                    decoration: InputDecoration(labelText: 'Titre'),
                                  ),
                                  TextField(
                                    controller: _descriptionController,
                                    decoration: InputDecoration(labelText: 'Description'),
                                  ),
                                ],
                              ),
                              actions: [
                                ElevatedButton(
                                  onPressed: () {
                                    String newTitle = _titleController.text.trim();
                                    String newDescription = _descriptionController.text.trim();
                                    if (newTitle.isNotEmpty && newDescription.isNotEmpty) {
                                      Note updatedNote = Note(
                                        id: note.id,
                                        libelle: newTitle,
                                        description: newDescription,
                                        date: DateTime.now().toString(),
                                      );
                                      context.read<NoteBloc>().add(UpdateNote(updatedNote));
                                      Navigator.pop(context);
                                      _titleController.clear();
                                      _descriptionController.clear();
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.lightBlueAccent,
                                  ),
                                  child: Text('Modifier'),
                                ),
                              ],
                            ),
                          );
                        },
                        color: Colors.black45,
                      ),
                    ],
                  ),
                );
              },
            );
          } else if (state is NoteErrorState) {
            return Center(child: Text(state.error));
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
