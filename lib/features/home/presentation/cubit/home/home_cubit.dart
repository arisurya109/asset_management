import 'package:asset_management/core/utils/assets.dart';
import 'package:asset_management/features/asset_master_new/presentation/view/asset_master_new_view.dart';
import 'package:asset_management/features/asset_registration/presentation/view/asset_migration_view.dart';
import 'package:asset_management/features/asset_registration/presentation/view/asset_registration/asset_registration_view.dart';
import 'package:asset_management/features/asset_registration/presentation/view/product_management_view.dart';

import '../../../../../main_export.dart';
import '../../../../../view/view.dart';
import '../../../../asset_count/asset_count.dart';
import '../../../../asset_master/asset_master.dart';

class HomeCubit extends Cubit<List<Map<String, dynamic>>> {
  HomeCubit() : super([]);

  final List<Map<String, dynamic>> _items = [
    {
      'value': 'asset_master_view',
      'icons': Assets.iAssetMaster,
      'name': 'Asset Master',
      'view': AssetMasterView(),
    },
    {
      'value': 'asset_preparation_view',
      'icons': Assets.iPreparation,
      'name': 'Asset Preparation',
      'view': AssetPreparationView(),
    },
    {
      'value': 'asset_count_view',
      'icons': Assets.iCount,
      'name': 'Asset Count',
      'view': AssetCountView(),
    },
    {
      'value': 'reprint_asset_view',
      'icons': Assets.iReprint,
      'name': 'Reprint Asset',
      'view': ReprintAssetIdView(),
    },
    {
      'value': 'reprint_location_view',
      'icons': Assets.iReprint,
      'name': 'Reprint Location',
      'view': ReprintLocationView(),
    },
    {
      'value': 'printer_view',
      'icons': Assets.iPrinter,
      'name': 'Printer',
      'view': PrinterView(),
    },
    {
      'value': 'master_view',
      'icons': Assets.iAssetMaster,
      'name': 'Master Data',
      'view': AssetMasterNewView(),
    },
    {
      'value': 'product_management_view',
      'icons': Assets.iAssetManagement,
      'name': 'Asset Management',
      'view': ProductManagementView(),
    },
    {
      'value': 'asset_registration_view',
      'icons': Assets.iAssetRegistration,
      'name': 'Asset Registration',
      'view': AssetRegistrationView(),
    },
    {
      'value': 'asset_migration_view',
      'icons': Assets.iAssetMigration,
      'name': 'Asset Migration',
      'view': AssetMigrationView(),
    },
  ];

  void loadItems(List<String> modules) {
    final allowedItems = <Map<String, dynamic>>[
      _items.firstWhere((e) => e['value'] == 'asset_master_view'),
      _items.firstWhere((e) => e['value'] == 'asset_preparation_view'),
      _items.firstWhere((e) => e['value'] == 'asset_count_view'),
      _items.firstWhere((e) => e['value'] == 'reprint_asset_view'),
      _items.firstWhere((e) => e['value'] == 'reprint_location_view'),
      _items.firstWhere((e) => e['value'] == 'printer_view'),
      _items.firstWhere((e) => e['value'] == 'product_management_view'),
      _items.firstWhere((e) => e['value'] == 'asset_registration_view'),
      _items.firstWhere((e) => e['value'] == 'asset_migration_view'),
    ];

    final userAllowed = _items
        .where((item) => modules.contains(item['value']))
        .toList();

    final all = [...allowedItems, ...userAllowed];
    final unique = {for (var item in all) item['value']: item}.values.toList();

    emit(unique);
  }
}
