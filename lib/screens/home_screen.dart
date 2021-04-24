import 'package:color_note/models/note.dart';
import 'package:color_note/widgets/note_card.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Note> notes = [];
  Database db;

  void getNotes() async {
    db = await openDatabase(
      'notes.db',
      onCreate: (db, version) {
        db.execute('CREATE TABLE notes(id INTEGER PRIMARY KEY AUTOINCREMENT, title VARCHAR(50), details TEXT, color VARCHAR(11))');
      },
      version: 2,
    );
    List<Map> data = await db.query(
      'notes',
      columns: ['id', 'title', 'details', 'color'],
    );

    data.forEach((row) {
      setState(() {
        notes.add(Note.fromMap(row));
      });
    });
  }

  void deleteNote(int id) async {
    await db.delete('notes', where: 'id = $id');

    setState(() => notes.removeWhere((note) {
      return note.id == id;
    }));
  }

  @override
  void initState() {
    super.initState();
    getNotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Color Notes'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, '/create'),
        child: const Icon(Icons.add)
      ),
      body: ListView.builder(
        itemCount: notes.length,
        itemBuilder: (_, index) {
          return NoteCard(
            title: notes[index].title,
            details: notes[index].details,
            color: notes[index].color,
            onPressed: () => deleteNote(notes[index].id),
          );
        }
      ),
    );
  }
}
