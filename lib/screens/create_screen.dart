import 'package:color_note/models/note.dart';
import 'package:color_note/widgets/round_checkbox.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class CreateScreen extends StatefulWidget {
  @override
  _CreateScreenState createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  final _formKey = GlobalKey<FormState>();
  Note note = Note();

  Color _noteColor = Colors.grey[300];

  void addData() async {
    Database db = await openDatabase(
      'notes.db',
      onCreate: (db, version) {
        db.execute('CREATE TABLE notes(id INTEGER PRIMARY KEY AUTOINCREMENT, title VARCHAR(50), details TEXT, color VARCHAR(11))');
      },
      version: 2,
    );
    await db.insert('notes', note.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
    Navigator.pushReplacementNamed(context, '/');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Color Notes')),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please, enter some text';
                    }
                    return null;
                  },
                  onSaved: (value) => note.title = value,
                  maxLength: 50,
                  decoration: const InputDecoration(
                    labelText: 'Enter title',
                    border: const OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please, enter some text';
                    }
                    return null;
                  },
                  onSaved: (value) => note.details = value,
                  maxLines: 5,
                  decoration: const InputDecoration(
                    alignLabelWithHint: true,
                    labelText: 'Enter details text',
                    border: const OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    RoundCheckBox(
                      groupValue: _noteColor,
                      color: Colors.grey[300],
                      value: Colors.grey[300],
                      onChange: (value) => setState(() => _noteColor = value),
                    ),
                    RoundCheckBox(
                      groupValue: _noteColor,
                      color: Colors.blue,
                      value: Colors.blue,
                      onChange: (value) => setState(() => _noteColor = value),
                    ),
                    RoundCheckBox(
                      groupValue: _noteColor,
                      color: Colors.green,
                      value: Colors.green,
                      onChange: (value) => setState(() => _noteColor = value),
                    ),
                    RoundCheckBox(
                      groupValue: _noteColor,
                      color: Colors.red,
                      value: Colors.red,
                      onChange: (value) => setState(() => _noteColor = value),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      _formKey.currentState.save();
                      note.color = _noteColor;
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: const Text('Saving data'),
                      ));
                      addData();
                    }
                  },
                  child: const Text('CREATE'),
                ),
              ],
            ),
          ),
        ),
      )
    );
  }
}