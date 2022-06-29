import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:notes_10_6/core/constants.dart';

class UserProvider {
  static final box = Hive.box<bool>(AppStrings.userKey);
  static Future<void> skip() async => await box.add(true);
  static ValueListenable<Box<bool>> listenable() => box.listenable();
}
