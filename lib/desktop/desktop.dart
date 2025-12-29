import 'package:asset_management/desktop/main_app_desktop.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:window_manager/window_manager.dart';

import 'presentation/bloc/desktop_bloc_injection.dart';

void desktop() async {
  desktopBlocInjection();
  await windowManager.ensureInitialized();

  WindowOptions windowOptions = WindowOptions(
    minimumSize: Size(1366, 768),
    center: true,
    backgroundColor: Colors.transparent,
  );
  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });
  initializeDateFormatting('id_ID').then((_) => runApp(const MainAppDesktop()));
}
