import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'contacts.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute('''
          CREATE TABLE contacts(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL,
            phone TEXT NOT NULL
          )
        ''');
      },
    );
  }

  Future<int> insertContact(Map<String, dynamic> contact) async {
    Database db = await database;
    return await db.insert('contacts', contact);
  }

  Future<List<Map<String, dynamic>>> getContacts() async {
    Database db = await database;
    return await db.query('contacts', orderBy: 'name');
  }

  Future<int> deleteContact(int id) async {
    Database db = await database;
    return await db.delete('contacts', where: 'id = ?', whereArgs: [id]);
  }
}