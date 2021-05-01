import 'package:color_note/database/notes_db.dart';
import 'package:color_note/models/note.dart';
import 'package:color_note/widgets/round_checkbox.dart';
import 'package:flutter/material.dart';

enum Mode {
  CREATE, UPDATE
}

class NoteFormScreen extends StatefulWidget {
  final Note _currNote;

  NoteFormScreen([this._currNote]);

  @override
  _NoteFormState createState() => _NoteFormState();
}

class _NoteFormState extends State<NoteFormScreen> {
  final _formKey = GlobalKey<FormState>();
  Mode mode = Mode.CREATE;
  NotesDb _db;

  Note note = Note();
  int _colorValue = Colors.grey[300].value;

  @override
  void initState() {
    super.initState();
    _db = NotesDb();

    if (widget._currNote != null) {
      note = Note.fromMap(widget._currNote.toMap());
      _colorValue = note.color.value;
      mode = Mode.UPDATE;
    }
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
                /// Title form field
                TextFormField(
                  initialValue: note.title,
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
                /// Details form field
                TextFormField(
                  initialValue: note.details,
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
                      groupValue: _colorValue,
                      color: Colors.grey[300],
                      value: Colors.grey[300].value,
                      onChange: (value) => setState(() => _colorValue = value),
                    ),
                    RoundCheckBox(
                      groupValue: _colorValue,
                      color: Colors.blue,
                      value: Colors.blue.value,
                      onChange: (value) => setState(() => _colorValue = value),
                    ),
                    RoundCheckBox(
                      groupValue: _colorValue,
                      color: Colors.green,
                      value: Colors.green.value,
                      onChange: (value) => setState(() => _colorValue = value),
                    ),
                    RoundCheckBox(
                      groupValue: _colorValue,
                      color: Colors.red,
                      value: Colors.red.value,
                      onChange: (value) => setState(() => _colorValue = value),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      _formKey.currentState.save();
                      note.color = Color(_colorValue);
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(mode == Mode.CREATE ? 'Saving...' : 'Updating...'),
                      ));

                      if (mode == Mode.CREATE) {
                        await _db.addNote(note.toMap());
                      }
                      else {
                        await _db.updateNote(note.toMap());
                      }
                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                      Navigator.pop(context, note);
                    }
                  },
                  child: Text(mode == Mode.CREATE ? 'CREATE' : 'UPDATE'),
                ),
              ],
            ),
          ),
        ),
      )
    );
  }
}
