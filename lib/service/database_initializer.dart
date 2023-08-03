import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseInitializer {
  static const String dbName = 'todo_app.db';
  static const String tableName = 'notes';

  static Future<Database> initializeDatabase() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, dbName);

    final database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE $tableName (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            libelle TEXT,
            description TEXT,
            date TEXT
          )
        ''');
      },
    );
    return database;
  }
}
