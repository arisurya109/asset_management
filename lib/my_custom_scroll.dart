// Source - https://stackoverflow.com/questions/71051133/how-to-add-horizontal-scroll-in-paginated-data-table-in-flutter-web
// Posted by Dr_Usman
// Retrieved 11/5/2025, License - CC-BY-SA 4.0

import 'dart:ui';

import 'package:flutter/material.dart';

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
    PointerDeviceKind.touch,
    PointerDeviceKind.mouse,
  };
}
