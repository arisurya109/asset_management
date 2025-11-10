import 'package:asset_management/presentation/components/app_card_item.dart';
import 'package:asset_management/domain/entities/asset/asset_entity.dart';
import 'package:asset_management/domain/entities/master/location.dart';
import 'package:asset_management/main_export.dart';
import 'package:asset_management/presentation/bloc/asset/asset_bloc.dart';
import 'package:asset_management/presentation/bloc/master/master_bloc.dart';
import 'package:asset_management/presentation/view/inventory/inventory_asset_box_view.dart';
import 'package:asset_management/presentation/view/inventory/inventory_detail_view.dart';
import 'package:asset_management/responsive_layout.dart';

import '../../../core/core.dart';

class InventoryView extends StatefulWidget {
  const InventoryView({super.key});

  @override
  State<InventoryView> createState() => _InventoryViewState();
}

class _InventoryViewState extends State<InventoryView> {
  String query = '';

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobileLScaffold: _mobileInventory(),
      mobileMScaffold: _mobileInventory(isLarge: false),
    );
  }

  Widget _mobileInventory({bool isLarge = true}) {
    return Scaffold(
      appBar: AppBar(title: Text('Inventory')),
      body: BlocBuilder<MasterBloc, MasterState>(
        builder: (context, state) {
          final location = state.locations;
          final assets = context.read<AssetBloc>().state.assets;

          List<Location> filteredLocation = [];
          List<AssetEntity> filteredAsset = [];

          if (query.isNotEmpty || query != '') {
            filteredLocation = location!.where((element) {
              final parentName = element.parentName?.toLowerCase() ?? '';
              return parentName.contains(query.toLowerCase());
            }).toList();
            filteredAsset = assets!.where((element) {
              final location = element.location?.toLowerCase() ?? '';
              return location.contains(query.toLowerCase());
            }).toList();
          }

          final totalQuantity = filteredAsset.fold<int>(
            0,
            (previousValue, asset) => previousValue + (asset.quantity ?? 0),
          );

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                AppSpace.vertical(12),
                AppTextField(
                  noTitle: true,
                  hintText: 'Search...',
                  fontSize: isLarge ? 14 : 12,
                  keyboardType: TextInputType.text,
                  onChanged: (value) => setState(() {
                    query = value;
                  }),
                ),
                AppSpace.vertical(12),
                if (query.isEmpty && query == '')
                  Expanded(
                    flex: 5,
                    child: Center(
                      child: Text(
                        'Please input location rack or box',
                        style: TextStyle(
                          color: AppColors.kGrey,
                          fontSize: isLarge ? 14 : 12,
                        ),
                      ),
                    ),
                  ),
                Expanded(
                  child: ListView(
                    children: [
                      if (filteredLocation.isNotEmpty)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppSpace.vertical(8),
                            Text(
                              'Total Box : ${filteredLocation.length.toString()}',
                              style: TextStyle(
                                fontSize: isLarge ? 14 : 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            AppSpace.vertical(12),
                          ],
                        ),
                      ...filteredLocation.map((e) {
                        return AppCardItem(
                          title: e.name,
                          leading: e.locationType,
                          noDescription: true,
                          fontSize: isLarge ? 14 : 12,
                          onTap: () =>
                              context.push(InventoryAssetBoxView(location: e)),
                          subtitle:
                              'Asset : ${assets?.where((element) {
                                return element.location == e.name;
                              }).length} | Quantity : ${assets?.where((element) {
                                return element.location == e.name;
                              }).fold<int>(0, (total, asset) => total + (asset.quantity ?? 0))}',
                        );
                      }),
                      if (filteredAsset.isNotEmpty)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppSpace.vertical(8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Total Asset : ${filteredAsset.length.toString()}',
                                  style: TextStyle(
                                    fontSize: isLarge ? 14 : 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  'Total Quantity : $totalQuantity',
                                  style: TextStyle(
                                    fontSize: isLarge ? 14 : 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            AppSpace.vertical(12),
                          ],
                        ),
                      ...filteredAsset.map((e) {
                        return AppCardItem(
                          title: e.assetCode ?? e.model,
                          leading: e.location,
                          noDescription: false,
                          fontSize: isLarge ? 14 : 12,
                          onTap: () =>
                              context.push(InventoryDetailView(params: e)),
                          subtitle: e.serialNumber ?? e.quantity.toString(),
                          descriptionLeft: e.status ?? '',
                          descriptionRight: e.conditions ?? '',
                        );
                      }),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
