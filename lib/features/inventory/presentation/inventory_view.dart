import 'package:asset_management/features/assets/assets_export.dart';
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

          if (query.isNotEmpty) {
            filteredLocation = location!.where((element) {
              final parentName = element.parentName ?? '';
              return parentName.toLowerCase().contains(query.toLowerCase());
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
                    print(query);
                  }),
                ),
                AppSpace.vertical(12),
                if (filteredLocation.isEmpty)
                  Expanded(
                    flex: 5,
                    child: Center(
                      child: Text(
                        'Please search location rack',
                        style: TextStyle(color: AppColors.kGrey),
                      ),
                    ),
                  ),
                Expanded(
                  child: ListView.builder(
                    itemCount: filteredLocation.length,
                    itemBuilder: (context, index) {
                      print(index);
                      final locations = filteredLocation[index];
                      return ListTile(title: Text(locations.name ?? ''));
                    },
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
