import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
part 'note.g.dart';

@HiveType(typeId: 0)
class Note extends HiveObject {
  @HiveField(0)
  bool? isSynced;
  @HiveField(1)
  String? text;
  @HiveField(2)
  String? dateTime;
  @HiveField(3)
  int? color;
  @HiveField(4)
  bool? isDeletedOffline;
  Note(
      {this.text,
      this.color = 0xff36878f,
      this.dateTime,
      this.isSynced = false,
      this.isDeletedOffline = false});
  Map<String, dynamic> toMap() {
    return {
      'text': text,
      'dateTime': dateTime,
      'color': color,
      'isSynced': true,
      'isDeletedOffline': isDeletedOffline
    };
  }

  static List<Color> colors = const [
    Color(0xff34856c),
    Color(0xff456ae6),
    Colors.pink,
    Color(0xffa234c9),
    Color(0xffc93481),
    Color(0xff36878f),
    Color(0xffd4b04c),
    Colors.blue,
    Colors.pink,
    Colors.deepOrange,
    Colors.cyan,
  ];
  Note.fromMap(Map<String, dynamic> map) {
    isSynced = map['isSynced'];
    isDeletedOffline = map['isDeletedOffline'];
    text = map['text'];
    dateTime = map['dateTime'];
    color = map['color'];
  }
}
