import 'package:color_note/database/notes_db.dart';
import 'package:color_note/models/note.dart';
import 'package:color_note/widgets/note_card.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Note> _notes = [];
  NotesDb _db;

  void setNotes() async {
    _db = NotesDb();
    await _db.connect();
    List<Map<String, dynamic>> notes = await _db.notes;

    notes.forEach((row) {
      setState(() {
        _notes.add(Note.fromMap(row));
      });
    });
  }

  @override
  void initState() {
    super.initState();
    setNotes();
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
        itemCount: _notes.length,
        itemBuilder: (_, index) {
          return NoteCard(
            title: _notes[index].title,
            details: _notes[index].details,
            color: _notes[index].color,
            onPressed: () async {
              await _db.deleteNote(_notes[index].id);
              setState(() => _notes.removeWhere((note) {
                return note.id == _notes[index].id;
              }));
            },
          );
        }
      ),
    );
  }
}
