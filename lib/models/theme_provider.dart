import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:notes_10_6/core/constants.dart';

class ThemeProvider {
  static final box = Hive.box<bool>(AppStrings.themeKey);
  static Future<void> switchTheme() async {
    bool val = box.getAt(0)!;
    await box.putAt(0, !val);
  }

  static ValueListenable<Box<bool>> listenable() => box.listenable();
}
