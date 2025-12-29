import 'dart:io';

import 'package:asset_management/desktop/desktop.dart';
import 'package:asset_management/injection.dart';
import 'package:asset_management/mobile/mobile.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await injection();

  if (Platform.isWindows) {
    desktop();
  } else {
    mobile();
  }
}
