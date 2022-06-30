// ignore_for_file: must_be_immutable

import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:notes_10_6/app_router.dart';
import 'package:notes_10_6/core/components.dart';
import 'package:notes_10_6/core/constants.dart';
import 'package:notes_10_6/core/random.dart';
import 'package:notes_10_6/data/cubit/auth_cubit.dart';
import 'package:notes_10_6/features/notes/widgets/GridviewWidget.dart';
import 'package:notes_10_6/features/notes/widgets/customShape.dart';
import 'package:notes_10_6/models/note.dart';
import 'package:notes_10_6/models/notes_provider.dart';
import 'package:notes_10_6/models/theme_provider.dart';

class NotesScreen extends StatelessWidget {
  NotesScreen({Key? key}) : super(key: key);
  String ch = 'test';
  List<String> greetings = ['Hi, ', 'Have a nice day, ', 'good to see you, '];

  static void addOrEdit({required BuildContext context, Note? note}) {
    TextEditingController controller = TextEditingController();
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            actions: [
              Column(
                children: [
                  TextFormField(
                      autofocus: true,
                      maxLines: 8,
                      minLines: 1,
                      style: TextStyle(
                          color: Theme.of(context).textTheme.bodyLarge!.color),
                      controller: controller
                        ..text = note == null ? '' : note.text!),
                  BlocProvider<AuthCubit>.value(
                    value: authCubit!,
                    child: BlocBuilder<AuthCubit, AuthState>(
                      builder: (context, state) {
                        var cubit = BlocProvider.of<AuthCubit>(context);
                        return TextButton(
                            onPressed: () {
                              note == null
                                  ? cubit.uplaodNote(Note(
                                      text: controller.text,
                                      dateTime: DateTime.now().toString(),
                                      color: Note
                                          .colors[MyRandom.myRand()
                                              .nextInt(Note.colors.length)]
                                          .value))
                                  : cubit.updateNote(controller.text, note);
                              Navigator.pop(context);
                            },
                            child: const Text('save'));
                      },
                    ),
                  )
                ],
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    double topPadding = MediaQuery.of(context).viewPadding.top;
    return ValueListenableBuilder<Box<bool>>(
        valueListenable: ThemeProvider.listenable(),
        builder: (context, Box<bool> bl, _) {
          return Scaffold(
            floatingActionButton: FloatingActionButton(
              child: const Icon(Icons.add),
              onPressed: () {
                FocusScope.of(context).unfocus();
                // addOrEdit(context: context);
                Navigator.pushNamed(context, AppStrings.addOrEditScreen,
                    arguments: Note());
              },
            ),
            body: Stack(
              children: [
                ClipPath(
                  clipper: CustomShape(),
                  child: Container(
                    height: 400,
                    width: double.infinity,
                    color: Theme.of(context).textTheme.subtitle1!.color,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    FocusScope.of(context).unfocus();
                  },
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: topPadding / 2, right: topPadding / 2),
                      child: Column(
                        children: [
                          SizedBox(
                            height: topPadding,
                          ),
                          BlocConsumer<AuthCubit, AuthState>(
                            listener: (context, state) {
                              var cubit = BlocProvider.of<AuthCubit>(context);
                              if (state is LoginWithGoogleSuccess) {
                                cubit.getAllNotes();
                                cubit.uploadAllNotSyncedNotes();
                              }
                            },
                            builder: (context, state) {
                              var cubit = BlocProvider.of<AuthCubit>(context);
                              return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  AutoSizeText(
                                      FirebaseAuth.instance.currentUser != null
                                          ? greetings[0] +
                                              FirebaseAuth.instance.currentUser!
                                                  .displayName!
                                                  .substring(
                                                      0,
                                                      FirebaseAuth
                                                          .instance
                                                          .currentUser!
                                                          .displayName!
                                                          .indexOf(' '))
                                          : 'Hi, ',
                                      maxFontSize: 80,
                                      minFontSize: 40,
                                      style: Appstyles.kmidTextStyle,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis),
                                  Row(
                                    children: [
                                      FirebaseAuth.instance.currentUser == null
                                          ? IconButton(
                                              onPressed: () {
                                                // ThemeProvider.switchTheme();
                                                cubit.signInWithGoogle();
                                              },
                                              icon: Icon(
                                                  Icons.cloud_sync_rounded),
                                            )
                                          : SizedBox(),
                                      IconButton(
                                        onPressed: () {
                                          ThemeProvider.switchTheme();
                                        },
                                        icon: Icon(!bl.getAt(0)!
                                            ? Icons.dark_mode
                                            : Icons.light_mode),
                                      )
                                    ],
                                  )
                                ],
                              );
                            },
                          ),
                          VLB(),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}

class VLB extends StatefulWidget {
  VLB({
    Key? key,
  }) : super(key: key);

  @override
  State<VLB> createState() => _VLBState();
}

class _VLBState extends State<VLB> {
  String ch = '';

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Box<Note>>(
      valueListenable: NotesProvider.listenable(),
      builder: (context, Box<Note> box, _) {
        List<Note> hiveNotes = box.values
            .where((element) => element.text!.contains(ch))
            .where((element) => element.isDeletedOffline != true)
            .toList();
        hiveNotes.sort((b, a) => a.dateTime!.compareTo(b.dateTime!));
        return Column(
          children: [
            TextFormField(
              style: TextStyle(
                  fontSize: 18,
                  color: Theme.of(context).textTheme.subtitle2!.color),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Search',
                filled: true,
                fillColor: Colors.white38,
                contentPadding: const EdgeInsets.only(
                  left: 14.0,
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.teal),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: const BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              onChanged: (newValue) {
                ch = newValue;
                setState(() {});
              },
            ),
            GridviewWidget(notes: hiveNotes),
          ],
        );
      },
    );
  }
}
