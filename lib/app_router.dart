import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_10_6/core/constants.dart';
import 'package:notes_10_6/data/cubit/auth_cubit.dart';
import 'package:notes_10_6/features/authentaction/sign_up/sign_up_screen.dart';
import 'package:notes_10_6/features/notes/notes_screen.dart';

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
              child: SignUpScreen(),
            );
          },
        );
      case AppStrings.notesScreen:
        return MaterialPageRoute(
          builder: (context) {
            return BlocProvider<AuthCubit>.value(
              value: authCubit!
                ..deleteAllOfflineDeletedNotes()
                ..uploadAllNotSyncedNotes(),
              child: NotesScreen(),
            );
          },
        );
    }
  }
}
