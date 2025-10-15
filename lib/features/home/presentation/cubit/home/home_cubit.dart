import 'package:asset_management/core/utils/assets.dart';
import 'package:asset_management/features/asset_master_new/presentation/view/asset_master_new_view.dart';
import 'package:asset_management/features/modules/assets/asset_module_view.dart';

import '../../../../../main_export.dart';
import '../../../../../view/view.dart';

class HomeCubit extends Cubit<List<Map<String, dynamic>>> {
  HomeCubit() : super([]);

  final List<Map<String, dynamic>> _items = [
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
      'value': 'assets_view',
      'icons': Assets.iAssetMaster,
      'name': 'Assets',
      'view': AssetModuleView(),
    },
    {
      'value': 'master_view',
      'icons': Assets.iAssetMaster,
      'name': 'Master Data',
      'view': AssetMasterNewView(),
    },
  ];

  void loadItems(List<String> modules) {
    final allowedItems = <Map<String, dynamic>>[
      _items.firstWhere((e) => e['value'] == 'reprint_asset_view'),
      _items.firstWhere((e) => e['value'] == 'reprint_location_view'),
      _items.firstWhere((e) => e['value'] == 'printer_view'),
    ];

    final userAllowed = _items
        .where((item) => modules.contains(item['value']))
        .toList();

    final all = [...allowedItems, ...userAllowed];
    final unique = {for (var item in all) item['value']: item}.values.toList();

    emit(unique);
  }
}
