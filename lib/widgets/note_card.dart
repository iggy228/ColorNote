import 'package:flutter/material.dart';

class NoteCard extends StatelessWidget {
  final String title;
  final String details;
  final Function onPressed;
  final Function onDelete;
  final Color color;

  const NoteCard({
    this.title,
    this.details,
    this.onPressed,
    this.onDelete,
    this.color,
  });


  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      color: color,
      elevation: 2.0,
      child: InkWell(
        onTap: onPressed,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: [
                  Expanded(
                    child: Text(title, style: Theme.of(context).textTheme.headline5)
                  ),
                  IconButton(
                    icon: Icon(Icons.delete),
                    color: color.value == Colors.red.value ? Colors.black : Colors.red,
                    onPressed: onDelete,
                  ),
                ],
              ),
              const SizedBox(height: 10.0),
              Text(details, style: Theme.of(context).textTheme.bodyText1),
            ],
          ),
        ),
      ),
    );
  }
}
