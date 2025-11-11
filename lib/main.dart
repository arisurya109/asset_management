import 'package:asset_management/injection.dart';
import 'package:asset_management/main_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await injection();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  initializeDateFormatting('id_ID').then((_) => runApp(const MainApp()));
}
