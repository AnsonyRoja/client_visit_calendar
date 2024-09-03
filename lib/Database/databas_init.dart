import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('patients.db');
    return _database!;
  }

  Future<void> deleteDatabases() async {
    String databasesPath = await getDatabasesPath();
    String dbPath = path.join(databasesPath, 'patients.db');

    // Elimina la base de datos si existe
    await deleteDatabase(dbPath);

    print('Base de datos eliminada');

    // Llama al método _initDatabase para crear la base de datos con la nueva estructura
    await database;
    print('Base de datos creada nuevamente');
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final paths = path.join(dbPath, filePath);

    return await openDatabase(
      paths,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
    CREATE TABLE patients (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT NOT NULL,
      consultation_date TEXT NOT NULL
    )
    ''');
    return _database;
  }
}
