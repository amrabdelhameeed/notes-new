import 'package:flutter/material.dart';
import 'package:notes_10_6/models/note.dart';

class ColorsWidget extends StatefulWidget {
  ColorsWidget({Key? key, this.color}) : super(key: key);
  Color? color;
  @override
  State<ColorsWidget> createState() => _ColorsWidgetState();
}

class _ColorsWidgetState extends State<ColorsWidget> {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: Note.colors
          .map((e) => Padding(
                padding: const EdgeInsets.all(5.0),
                child: InkWell(
                  onTap: () {
                    widget.color = Color(e.value);
                    setState(() {});
                  },
                  child: CircleAvatar(
                    minRadius: 25,
                    maxRadius: 30,
                    backgroundColor: e.value != widget.color!.value
                        ? Color(e.value)
                        : Colors.white,
                    child: CircleAvatar(
                      maxRadius: 25,
                      minRadius: 20,
                      backgroundColor: Color(e.value),
                    ),
                  ),
                ),
              ))
          .toList(),
    );
  }
}
