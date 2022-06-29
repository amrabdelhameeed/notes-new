import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_10_6/core/app_images.dart';
import 'package:notes_10_6/core/components.dart';
import 'package:notes_10_6/core/constants.dart';
import 'package:notes_10_6/core/texts.dart';
import 'package:notes_10_6/data/cubit/auth_cubit.dart';
import 'package:notes_10_6/models/user_provider.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                AppImages.cloud,
                fit: BoxFit.fill,
                height: 350,
              ),
              const AutoSizeText(
                AppTexts.signUpSubtitle,
                maxLines: 2,
                style: Appstyles.kBigTextStyle,
              ),
              const SizedBox(
                height: 30,
              ),
              BlocConsumer<AuthCubit, AuthState>(
                listener: (context, state) {
                  var cubit = BlocProvider.of<AuthCubit>(context);

                  if (state is LoginWithGoogleSuccess) {
                    cubit.getAllNotes();
                  }
                  if (state is GetNoteSuccess) {
                    Navigator.pushReplacementNamed(
                        context, AppStrings.notesScreen);
                  }
                },
                builder: (context, state) {
                  var cubit = BlocProvider.of<AuthCubit>(context);

                  return InkWell(
                    onTap: () {
                      cubit.signInWithGoogle();
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Colors.black),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Image.asset(
                            AppImages.google,
                            fit: BoxFit.contain,
                            height: 45,
                            width: 45,
                          ),
                          const AutoSizeText(
                            AppTexts.continueWithGoogle,
                            maxFontSize: 25,
                            style: Appstyles.kmidTextStyle,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(
                height: 60,
              ),
              InkWell(
                onTap: () {
                  UserProvider.skip().then((value) {
                    Navigator.pushReplacementNamed(
                        context, AppStrings.notesScreen);
                  });
                },
                child: const AutoSizeText(
                  AppTexts.skipForNow,
                  maxLines: 2,
                  maxFontSize: 25,
                  style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.w700,
                    decoration: TextDecoration.underline,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
