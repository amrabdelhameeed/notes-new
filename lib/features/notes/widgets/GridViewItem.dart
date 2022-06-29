import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_10_6/data/cubit/auth_cubit.dart';
import 'package:notes_10_6/features/notes/notes_screen.dart';
import 'package:notes_10_6/models/note.dart';
import 'package:notes_10_6/models/notes_provider.dart';

class GridViewItem extends StatelessWidget {
  const GridViewItem({Key? key, required this.note}) : super(key: key);
  final Note note;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        var cubit = BlocProvider.of<AuthCubit>(context);
        return InkWell(
          onLongPress: () {
            // NotesProvider.deleteNote(note);
            cubit.deleteNote(note);
            // NotesProvider.markAsDeleted(note);
          },
          onTap: () {
            // Navigator.pushNamed(context, EditScreenPage, arguments: note);
            FocusScope.of(context).unfocus();

            NotesScreen.addOrEdit(
              context: context,
              note: note,
            );
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 800),
            curve: Curves.easeIn,
            padding: const EdgeInsets.all(9),
            margin: const EdgeInsets.all(4),
            decoration: BoxDecoration(
                color: Color(note.color!),
                borderRadius: const BorderRadius.all(Radius.circular(12))),
            child: Column(
              children: [
                AutoSizeText(
                  note.text!,
                  maxFontSize: 25,
                  minFontSize: 20,
                  softWrap: true,
                  wrapWords: true,
                  textAlign: TextAlign.center,
                  maxLines: 8,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).devicePixelRatio * 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 5,
                      child: AutoSizeText(
                        note.dateTime!.substring(0, 16),
                        maxFontSize: 18,
                        minFontSize: 10,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(color: Colors.white70),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: IconButton(
                          onPressed: () {},
                          icon: Icon(!note.isSynced!
                              ? Icons.sync
                              : Icons.check_circle),
                          color: Colors.white,
                          iconSize: 18),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
