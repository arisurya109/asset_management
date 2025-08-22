import 'package:flutter/cupertino.dart';

class AppSpace {
  static Widget horizontal(double value) {
    return SizedBox(width: value);
  }

  static Widget vertical(double value) {
    return SizedBox(height: value);
  }
}
