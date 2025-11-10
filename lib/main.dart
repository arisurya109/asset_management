import 'package:asset_management/injection.dart';
import 'package:asset_management/main_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:device_preview/device_preview.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await injection();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  initializeDateFormatting(
    'id_ID',
  ).then((_) => runApp(DevicePreview(builder: (context) => const MainApp())));
}
