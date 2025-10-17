import 'package:asset_management/components/app_card_item.dart';
import 'package:asset_management/features/modules/inventories/presentation/view/inventory_detail_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/core.dart';
import '../../inventory_export.dart';

class InventoryView extends StatefulWidget {
  const InventoryView({super.key});

  @override
  State<InventoryView> createState() => _InventoryViewState();
}

class _InventoryViewState extends State<InventoryView> {
  // late TextEditingController queryC;

  @override
  void initState() {
    // queryC = TextEditingController();
    context.read<InventoryBloc>().add(OnGetAllInventory());
    super.initState();
  }

  @override
  void dispose() {
    // queryC.dispose();
    super.dispose();
  }

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
      body: Padding(
        padding: EdgeInsets.fromLTRB(16, 12, 16, 0),
        child: Column(
          children: [
            AppTextField(
              hintText: 'Search',
              keyboardType: TextInputType.text,
              noTitle: true,
              onChanged: (value) =>
                  context.read<InventoryBloc>().add(OnSearchInventory(value)),
            ),
            AppSpace.vertical(16),
            Expanded(
              child: BlocBuilder<InventoryBloc, InventoryState>(
                builder: (context, state) {
                  if (state.status == StatusInventory.loading) {
                    return Center(child: CircularProgressIndicator());
                  }

                  if (state.status == StatusInventory.failed) {
                    return Center(
                      child: Text(state.message ?? 'Gagal memuat inventaris.'),
                    );
                  }

                  if (state.status == StatusInventory.loaded) {
                    return ListView.builder(
                      itemCount: state.assets?.length,
                      itemBuilder: (context, index) {
                        final asset = state.assets?[index];
                        return AppCardItem(
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  InventoryDetailView(params: asset!),
                            ),
                          ),
                          title: asset?.assetCode ?? '',
                          subtitle: asset?.serialNumber,
                          leading: asset?.location,
                          descriptionLeft: asset?.status,
                          descriptionRight: asset?.conditions,
                        );
                      },
                    );
                  }
                  if (state.status == StatusInventory.filtered) {
                    return ListView.builder(
                      itemCount: state.filteredAssets?.length,
                      itemBuilder: (context, index) {
                        final asset = state.filteredAssets?[index];
                        return AppCardItem(
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  InventoryDetailView(params: asset!),
                            ),
                          ),
                          title: asset?.assetCode ?? '',
                          subtitle: asset?.serialNumber,
                          leading: asset?.location,
                          descriptionLeft: asset?.status,
                          descriptionRight: asset?.conditions,
                        );
                      },
                    );
                  }

                  return SizedBox();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
