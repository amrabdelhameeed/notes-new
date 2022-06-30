import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:notes_10_6/core/constants.dart';
import 'package:notes_10_6/models/note.dart';
import 'package:hive_flutter/hive_flutter.dart';

class NotesProvider {
  static final box = Hive.box<Note>(AppStrings.notesKey);
  static Future<void> addNote(Note note) async {
    if (!box.values
        .toList()
        .where((element) => element.dateTime == note.dateTime)
        .isNotEmpty) {
      await box.add(note);
    }
  }

  static Future<void> deleteNote(Note note) async => await note.delete();
  static Future<void> updateNote(String text, Note note) async {
    note.text = text;
    await note.save();
  }

  static Future<void> markAsDeleted(Note note) async {
    note.isDeletedOffline = true;
    await note.save();
  }

  static Future<void> markAsSynced(Note note) async {
    note.isSynced = true;
    await note.save();
  }

  static Future<void> markAsNotSynced(Note note) async {
    note.isSynced = false;
    await note.save();
  }

  static Future<void> changeColor(Note note, int color) async {
    note.color = color;
    await note.save();
  }

  static ValueListenable<Box<Note>> listenable() => box.listenable();
}
