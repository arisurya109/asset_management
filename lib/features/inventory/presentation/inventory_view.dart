import 'package:asset_management/components/app_card_item.dart';
import 'package:asset_management/features/assets/assets_export.dart';
import 'package:asset_management/features/inventory/presentation/inventory_detail_view.dart';
import 'package:asset_management/features/location/location_export.dart';
import 'package:asset_management/main_export.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: Text('Inventory'),
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(height: 1, color: AppColors.kBase),
          ),
        ),
      ),
      body: BlocBuilder<LocationBloc, LocationState>(
        builder: (context, state) {
          final location = state.locations;
          final assets = context.read<AssetsBloc>().state.assets;

          List<Location> filteredLocation = [];
          List<AssetsEntity> filteredAsset = [];

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

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                AppSpace.vertical(12),
                AppTextField(
                  noTitle: true,
                  hintText: 'Search...',
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
                        style: TextStyle(color: AppColors.kGrey),
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
                              'Total Rack or Box : ${filteredLocation.length.toString()}',
                              style: TextStyle(
                                fontSize: 16,
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
                          subtitle:
                              'Total Asset : ${assets?.where((element) {
                                return element.location == e.name;
                              }).length}',
                        );
                      }),
                      if (filteredAsset.isNotEmpty)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppSpace.vertical(8),
                            Text(
                              'Total Asset : ${filteredAsset.length.toString()}',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            AppSpace.vertical(12),
                          ],
                        ),
                      ...filteredAsset.map((e) {
                        return AppCardItem(
                          title: e.assetCode ?? e.model,
                          leading: e.location,
                          noDescription: true,
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
