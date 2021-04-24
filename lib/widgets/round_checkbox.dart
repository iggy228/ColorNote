import 'package:flutter/material.dart';

class RoundCheckBox<T> extends StatefulWidget {
  final Color color;
  final T value;
  final Function(T value) onChange;
  final T groupValue;

  RoundCheckBox({
    this.color,
    this.value,
    this.groupValue,
    this.onChange
  });

  @override
  _RoundCheckBoxState createState() => _RoundCheckBoxState();
}

class _RoundCheckBoxState extends State<RoundCheckBox> {
  bool _isChecked = false;

  @override
  void initState() {
    super.initState();
    _isChecked = widget.value == widget.groupValue;
  }

  @override
  void didUpdateWidget(covariant RoundCheckBox oldWidget) {
    super.didUpdateWidget(oldWidget);
    _isChecked = widget.value == widget.groupValue;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => setState(() {
        widget.onChange(widget.value);
        _isChecked = !_isChecked;
      }),
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: widget.color,
          border: Border.all(color: Colors.black54),
        ),
        child: _isChecked ?
          Icon(
            Icons.check,
            size: 30,
            color: widget.color == Colors.white ? Colors.black54 : Colors.white,
          ) :
          const SizedBox(width: 30, height: 30),
      ),
    );
  }
}
