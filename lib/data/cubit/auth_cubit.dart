import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meta/meta.dart';
import 'package:notes_10_6/models/note.dart';
import 'package:notes_10_6/models/notes_provider.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  final googleSignIn = GoogleSignIn();
  final FirebaseAuth instance = FirebaseAuth.instance;
  final FirebaseFirestore firestoreInstance = FirebaseFirestore.instance;
  GoogleSignInAccount? _user;
  GoogleSignInAccount? get currentUser => _user;
  Future signInWithGoogle() async {
    final googleUser = await googleSignIn.signIn();
    if (googleUser == null) return;
    _user = googleUser;
    final googleAuth = await googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
    await instance.signInWithCredential(credential).then((value) {
      if (value.user == null) {
        emit(LoginWithGoogleFailed());
      } else {
        emit(LoginWithGoogleSuccess());
      }
    });
  }

  getAllNotes() async {
    await firestoreInstance
        .collection('users')
        .doc(instance.currentUser!.uid)
        .collection('notes')
        .get()
        .then((value) {
      value.docs.forEach((element) {
        NotesProvider.addNote(Note.fromMap(element.data()));
      });
      emit(GetNoteSuccess());
    });
  }

  uplaodNote(Note note) async {
    NotesProvider.addNote(note);
    await firestoreInstance
        .collection('users')
        .doc(instance.currentUser!.uid)
        .collection('notes')
        .doc(note.dateTime!)
        .set(note.toMap())
        .then((value) {
      emit(UploadNoteSuccess());
      NotesProvider.markAsSynced(note);
    });
  }

  deleteAllOfflineDeletedNotes() {
    NotesProvider.box.values
        .where((element) => element.isDeletedOffline == true)
        .toList()
        .forEach((element) async {
      await deleteNote(element);
    });
  }

  uploadAllNotSyncedNotes() {
    NotesProvider.box.values
        .where((element) => element.isSynced == false)
        .toList()
        .forEach((element) async {
      await uplaodNote(element);
    });
  }

  updateNote(String text, Note note) async {
    NotesProvider.updateNote(text, note);
    await firestoreInstance
        .collection('users')
        .doc(instance.currentUser!.uid)
        .collection('notes')
        .doc(note.dateTime!)
        .update(note.toMap())
        .then((value) {
      emit(UpdateNoteSuccess());
      NotesProvider.markAsSynced(note);
    });
  }

  deleteNote(Note note) async {
    NotesProvider.markAsDeleted(note);
    await firestoreInstance
        .collection('users')
        .doc(instance.currentUser!.uid)
        .collection('notes')
        .doc(note.dateTime)
        .delete()
        .then((value) {
      NotesProvider.deleteNote(note);
      emit(DeletedNoteSuccess());
    }).catchError((onError) {
      emit(UploadNoteFailed());
    });
  }
}
