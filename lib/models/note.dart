import 'package:flutter/material.dart';

class Note {
  int _id;
  String title;
  String details;
  Color color;

  Note();

  int get id {
    return _id;
  }

  Note.fromMap(Map<String, dynamic> map) {
    _id = map['id'];
    title = map['title'];
    details = map['details'];
    List<String> strColor = map['color'].split(',');
    color = Color.fromRGBO(int.parse(strColor[0]), int.parse(strColor[1]), int.parse(strColor[2]), 1);
  }

  Map<String, dynamic> toMap() {

    return {
      'id': _id,
      'title': title,
      'details': details,
      'color': '${color.red},${color.green},${color.blue}',
    };
  }
}