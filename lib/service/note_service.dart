import 'package:sqflite/sqflite.dart';
import 'package:test_todo/model/note_model.dart';
import 'database_initializer.dart';


final NoteService noteService = NoteService();

NoteViewModel(NoteService noteService) {
  // TODO: implement NoteViewModel
  throw UnimplementedError();
}

class NoteService {
  static const String tableName = 'notes';

  Future<Database> get database async {
    return await DatabaseInitializer.initializeDatabase();
  }

  Future<List<Note>> getNotes() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(tableName);

    return List.generate(maps.length, (index) {
      return Note(
        id: maps[index]['id'],
        libelle: maps[index]['libelle'],
        description: maps[index]['description'],
        date: maps[index]['date'],
      );
    });
  }

  Future<void> insertNote(Note note) async {
    final db = await database;
    await db.insert(tableName, note.toMap());
  }

  Future<void> updateNote(Note note) async {
    final db = await database;
    await db.update(
      tableName,
      note.toMap(),
      where: 'id = ?',
      whereArgs: [note.id],
    );
  }

  Future<void> deleteNote(int id) async {
    final db = await database;
    await db.delete(
      tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
