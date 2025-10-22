import 'package:asset_management/core/config/token_helper.dart';
import 'package:asset_management/features/asset_brand/asset_brand_export.dart';
import 'package:asset_management/features/asset_category/asset_category_export.dart';
import 'package:asset_management/features/asset_model/asset_model_export.dart';
import 'package:asset_management/features/asset_type/asset_type_export.dart';
import 'package:asset_management/features/assets/assets_export.dart';
import 'package:asset_management/features/location/location_export.dart';
import 'package:asset_management/features/migration/migration_export.dart';
import 'package:asset_management/features/printer/printer_export.dart';
import 'package:asset_management/features/registration/registration_export.dart';
import 'package:asset_management/features/transfer/transfer_export.dart';
import 'package:asset_management/features/vendor/vendor_injection.dart';
import 'package:get_it/get_it.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'core/config/database_helper.dart';
import 'features/user/user_export.dart';

final locator = GetIt.instance;

Future<void> injection() async {
  final pref = await SharedPreferences.getInstance();

  userInjector(locator);
  assetTypeInjection(locator);
  assetBrandInjection(locator);
  assetCategoryInjection(locator);
  assetModelInjection(locator);
  locationInjection(locator);
  assetsInjection(locator);
  printerInjection(locator);
  registrationInjection(locator);
  migrationInjection(locator);
  transferInjection(locator);
  vendorInjection(locator);

  // Services
  locator.registerLazySingleton(() => pref);
  locator.registerLazySingleton(() => DatabaseHelper.instance);
  locator.registerLazySingleton(() => http.Client());
  locator.registerLazySingleton<TokenHelper>(() => TokenHelperImpl(locator()));
}
