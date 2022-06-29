import 'dart:math';

class MyRandom {
  static Random? _rand;
  static Random myRand() {
    if (_rand == null) {
      _rand = Random();
      return _rand!;
    } else {
      return _rand!;
    }
  }
}
