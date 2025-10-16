import 'package:asset_management/features/asset_registration/presentation/view/asset_migration_view.dart';
import 'package:bloc/bloc.dart';

import '../../../../core/core.dart';
import '../../../asset_registration/presentation/view/asset_registration/asset_registration_view.dart';
import '../../../asset_count/asset_count.dart';
import '../../../asset_preparation/asset_preparation.dart';
import '../../inventories/inventory_export.dart';
import '../../asset_transfer/presentation/view/asset_transfer_view.dart';

class ModulAssetCubit extends Cubit<List<Map<String, dynamic>>> {
  ModulAssetCubit() : super([]);

  final List<Map<String, dynamic>> _items = [
    {
      'value': 'registration_view',
      'icons': Assets.iAssetRegistration,
      'name': 'Registration',
      'view': AssetRegistrationView(),
    },
    {
      'value': 'migration_view',
      'icons': Assets.iAssetMigration,
      'name': 'Migration',
      'view': AssetMigrationView(),
    },
    {
      'value': 'asset_preparation_view',
      'icons': Assets.iPreparation,
      'name': 'Preparation',
      'view': AssetPreparationView(),
    },
    {
      'value': 'asset_count_view',
      'icons': Assets.iCount,
      'name': 'Count',
      'view': AssetCountView(),
    },
    {
      'value': 'asset_transfer_view',
      'icons': Assets.iTransfer,
      'name': 'Transfer',
      'view': AssetTransferView(),
    },
    {
      'value': 'inventory_view',
      'icons': Assets.iAssetManagement,
      'name': 'Inventory',
      'view': InventoryView(),
    },
  ];

  void loadItems(List<String> modules) {
    final userAllowed = _items
        .where((item) => modules.contains(item['value']))
        .toList();

    final allowedItems = <Map<String, dynamic>>[
      _items.firstWhere((e) => e['value'] == 'registration_view'),
      _items.firstWhere((e) => e['value'] == 'migration_view'),
      _items.firstWhere((e) => e['value'] == 'asset_preparation_view'),
      _items.firstWhere((e) => e['value'] == 'asset_count_view'),
      _items.firstWhere((e) => e['value'] == 'asset_transfer_view'),
      _items.firstWhere((e) => e['value'] == 'inventory_view'),
    ];

    final all = [...allowedItems, ...userAllowed];
    final unique = {for (var item in all) item['value']: item}.values.toList();

    emit(unique);
  }
}
