import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_10_6/data/cubit/auth_cubit.dart';
import 'package:notes_10_6/features/notes/notes_screen.dart';

class SignUpScreen2 extends StatelessWidget {
  const SignUpScreen2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return const Center(
                child: Text('something went wrong'),
              );
            } else if (snapshot.hasData) {
              return Center(child: Text(snapshot.data!.email!));
            } else {
              return BlocProvider<AuthCubit>(
                create: (context) => AuthCubit(),
                child: Center(
                  child: Column(
                    children: [
                      BlocConsumer<AuthCubit, AuthState>(
                        listener: (context, state) {
                          if (state is LoginWithGoogleSuccess) {
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(
                              builder: (context) {
                                return NotesScreen();
                              },
                            ));
                          }
                        },
                        builder: (context, state) {
                          var cubit = BlocProvider.of<AuthCubit>(context);
                          return TextButton(
                              onPressed: () {
                                cubit.signInWithGoogle();
                              },
                              child: const Text('SignUpWithGoogle'));
                        },
                      ),
                    ],
                  ),
                ),
              );
            }
          }),
    );
  }
}
