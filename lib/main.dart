import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:notes_10_6/app_router.dart';
import 'package:notes_10_6/core/app_theme.dart';
import 'package:notes_10_6/core/constants.dart';
import 'package:notes_10_6/features/authentaction/sign_up/sign_up_screen.dart';
import 'package:notes_10_6/models/user_provider.dart';
import 'package:notes_10_6/temp/sign_up.dart';
import 'package:notes_10_6/features/notes/notes_screen.dart';
import 'package:notes_10_6/models/note.dart';
import 'package:notes_10_6/models/theme_provider.dart';
import 'package:path_provider/path_provider.dart' as path;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final dirc = await path.getApplicationDocumentsDirectory();
  Hive.init(dirc.path);
  Hive.registerAdapter(NoteAdapter());
  await Hive.openBox<Note>(AppStrings.notesKey);
  await Hive.openBox<bool>(AppStrings.userKey);
  await Hive.openBox<bool>(AppStrings.themeKey).then((value) {
    if (value.isEmpty) {
      value.add(true);
    }
  });

  runApp(MyApp(
    appRouter: AppRouter(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.appRouter}) : super(key: key);
  final AppRouter appRouter;
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Box<bool>>(
        valueListenable: ThemeProvider.listenable(),
        builder: (context, Box<bool> bx, _) {
          return MaterialApp(
            title: 'Notes',
            debugShowCheckedModeBanner: false,
            themeMode: bx.getAt(0)! ? ThemeMode.dark : ThemeMode.light,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            initialRoute: UserProvider.box.isEmpty &&
                    FirebaseAuth.instance.currentUser == null
                ? AppStrings.signUpScreen
                : AppStrings.notesScreen,
            onGenerateRoute: appRouter.generateRoutes,
          );
        });
  }
}
