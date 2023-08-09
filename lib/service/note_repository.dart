import 'package:test_todo/service/db_helper.dart';
import 'package:test_todo/model/note_model.dart';

// Initialisation de la base de données
final dbHelper = DbHelper();
final dataProvider = DataProvider(dbHelper);
final repository = Repository(dataProvider);

class DataProvider {
  final DbHelper dbHelper;

  DataProvider(this.dbHelper);

  Future<List<Map<String, dynamic>>> readData() async {
    final db = await dbHelper.initDb();
    return await db.query('notes');
  }

  Future<void> insertData(Note note) async {
    final db = await dbHelper.initDb();
    await db.insert('notes', note.toMap());
  }

  Future<void> updateData(Note note) async {
    final db = await dbHelper.initDb();
    await db.update(
      'notes',
      note.toMap(),
      where: 'id = ?',
      whereArgs: [note.id],
    );
  }

  Future<void> deleteData(int id) async {
    final db = await dbHelper.initDb();
    await db.delete(
      'notes',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}

class Repository {
  final DataProvider dataProvider;

  Repository(this.dataProvider);

  Future<List<Note>> getAllNotes() async {
    await dbHelper.initDb(); // Initialisez la base de données
    final List<Map<String, dynamic>> data = await dataProvider.readData();
    return data.map((map) => Note.fromMap(map)).toList();
  }

  Future<void> addNote(Note note) async {
    await dbHelper.initDb();
    await dataProvider.insertData(note);
  }

  Future<void> updateNote(Note note) async {
    await dbHelper.initDb();
    await dataProvider.updateData(note);
  }

  Future<void> deleteNoteById(int id) async {
    await dbHelper.initDb(); 
    await dataProvider.deleteData(id);
  }
}
