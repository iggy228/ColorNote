import 'package:sqflite/sqflite.dart';

class NotesDb {
  static final NotesDb _instance = NotesDb._internal();
  final tableName = 'notes';

  Database _db;

  factory NotesDb() {
    return _instance;
  }

  NotesDb._internal();


  Future<List<Map<String, dynamic>>> get notes async {
    List<Map<String, dynamic>> notes = await _db.query(tableName, columns: ['id', 'title', 'details', 'color']);
    return notes;
  }

  Future<void> connect() async {
    _db = await openDatabase(
      tableName,
      onCreate: (db, version) {
        db.execute('CREATE TABLE notes(id INTEGER PRIMARY KEY AUTOINCREMENT, title VARCHAR(50), details TEXT, color VARCHAR(11))');
      },
      version: 2,
    );
  }

  Future<void> deleteNote(int id) async {
    await _db.delete(tableName, where: 'id=$id');
  }

  Future<void> addNote(Map<String, dynamic> note) async {
    await _db.insert(tableName, note);
  }
}