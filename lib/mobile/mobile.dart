import 'package:asset_management/mobile/main_app_mobile.dart';
import 'package:asset_management/mobile/presentation/bloc/bloc_injector.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/date_symbol_data_local.dart';

void mobile() {
  mobileBlocInjection();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  initializeDateFormatting('id_ID').then((_) => runApp(const MainAppMobile()));
}
