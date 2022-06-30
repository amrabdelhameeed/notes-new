import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_10_6/app_router.dart';
import 'package:notes_10_6/core/random.dart';
import 'package:notes_10_6/data/cubit/auth_cubit.dart';
import 'package:notes_10_6/features/notes/add_or_edit_note_screen/widgets/colors_widget.dart';
import 'package:notes_10_6/models/note.dart';
import 'package:notes_10_6/models/notes_provider.dart';

class AddOrEditNoteScreen extends StatefulWidget {
  AddOrEditNoteScreen({Key? key, required this.note}) : super(key: key);
  final Note? note;

  @override
  State<AddOrEditNoteScreen> createState() => _AddOrEditNoteScreenState();
}

class _AddOrEditNoteScreenState extends State<AddOrEditNoteScreen> {
  final TextEditingController controller = TextEditingController();
  bool isRTL = false;
  Color color =
      Color(Note.colors[MyRandom.myRand().nextInt(Note.colors.length)].value);
  List<int> colors = [];
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    widget.note!.text != null ? colors.add(widget.note!.color!) : null;
    return WillPopScope(
      onWillPop: () async {
        widget.note!.text != null
            ? NotesProvider.changeColor(widget.note!, colors[0])
            : null;
        return true;
      },
      child: Scaffold(
        backgroundColor:
            widget.note!.text == null ? color : Color(widget.note!.color!),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          actions: [
            BlocBuilder<AuthCubit, AuthState>(
              builder: (context, state) {
                var cubit = BlocProvider.of<AuthCubit>(context);
                return TextButton(
                    onPressed: () {
                      // print(note!.text != null ? note!.text : '');
                      if (controller.text.isNotEmpty) {
                        widget.note!.text == null
                            ? cubit.uplaodNote(Note(
                                text: controller.text,
                                dateTime: DateTime.now().toString(),
                                color: color.value))
                            : cubit.updateNote(controller.text, widget.note!);
                        Navigator.pop(context);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Empty Value!')));
                      }
                    },
                    child: const AutoSizeText(
                      'Save',
                      style: TextStyle(color: Colors.white),
                      maxFontSize: 25,
                      minFontSize: 21,
                    ));
              },
            )
          ],
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.01),
          child: Column(
            children: [
              TextFormField(
                  decoration: const InputDecoration(border: InputBorder.none),
                  textAlign: TextAlign.center,
                  autofocus: true,
                  minLines: 8,
                  maxLines: 8,
                  style: const TextStyle(color: Colors.white),
                  controller: controller
                    ..text = widget.note!.text == null
                        ? (controller.text.isEmpty ? '' : controller.text)
                        : (controller.text.isEmpty
                            ? widget.note!.text!
                            : controller.text)),
              Wrap(
                children: Note.colors
                    .map((e) => Padding(
                          padding: EdgeInsets.all(size.width * 0.01),
                          child: InkWell(
                            onTap: () {
                              widget.note!.text != null
                                  ? NotesProvider.changeColor(
                                      widget.note!, e.value)
                                  : color = Color(e.value);
                              setState(() {});
                            },
                            child: CircleAvatar(
                              minRadius: 28,
                              maxRadius: 30,
                              backgroundColor: e.value !=
                                      (widget.note!.text == null
                                          ? color.value
                                          : widget.note!.color)
                                  ? Color(e.value)
                                  : Colors.white,
                              child: CircleAvatar(
                                maxRadius: 28,
                                minRadius: 23,
                                backgroundColor: Color(e.value),
                              ),
                            ),
                          ),
                        ))
                    .toList(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
