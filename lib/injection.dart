import 'package:asset_management/injection/asset_injection.dart';
import 'package:asset_management/injection/printer_injection.dart';
import 'package:asset_management/injection/purchase_order_injection.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:asset_management/core/config/token_helper.dart';
import 'package:asset_management/injection/authentication_injection.dart';
import 'package:asset_management/injection/master_injection.dart';
import 'package:asset_management/injection/permissions_injection.dart';

import 'core/config/database_helper.dart';
import 'injection/user_injection.dart';

final locator = GetIt.instance;

Future<void> injection() async {
  final pref = await SharedPreferences.getInstance();

  authenticationInjection(locator);
  userInjection(locator);
  permissionsInjection(locator);
  masterInjection(locator);
  assetInjection(locator);
  printerInjection(locator);
  purchaseOrderInjection(locator);

  // Services
  locator.registerLazySingleton(() => pref);
  locator.registerLazySingleton(() => DatabaseHelper.instance);
  locator.registerLazySingleton(() => http.Client());
  locator.registerLazySingleton<TokenHelper>(() => TokenHelperImpl(locator()));
}
