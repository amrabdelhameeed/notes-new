import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_10_6/core/constants.dart';
import 'package:notes_10_6/data/cubit/auth_cubit.dart';
import 'package:notes_10_6/features/authentaction/sign_up/sign_up_screen.dart';
import 'package:notes_10_6/features/notes/add_or_edit_note_screen/add_or_edit_note_screen.dart';
import 'package:notes_10_6/features/notes/notes_screen.dart';
import 'package:notes_10_6/models/note.dart';

AuthCubit? authCubit;

class AppRouter {
  AppRouter() {
    authCubit = AuthCubit();
  }
  Route? generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case AppStrings.signUpScreen:
        return MaterialPageRoute(
          builder: (context) {
            return BlocProvider<AuthCubit>.value(
              value: authCubit!,
              child: const SignUpScreen(),
            );
          },
        );
      case AppStrings.notesScreen:
        return MaterialPageRoute(
          builder: (context) {
            return BlocProvider<AuthCubit>.value(
              value: authCubit!..deleteAllOfflineDeletedNotes(),
              // ..uploadAllNotSyncedNotes(),
              child: NotesScreen(),
            );
          },
        );
      case AppStrings.addOrEditScreen:
        return MaterialPageRoute(
          builder: (context) {
            final Note note = settings.arguments as Note;
            return BlocProvider<AuthCubit>.value(
              value: authCubit!,
              child: AddOrEditNoteScreen(note: note),
            );
          },
        );
    }
  }
}
