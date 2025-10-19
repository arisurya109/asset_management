import 'package:asset_management/components/app_card_item.dart';
import 'package:asset_management/core/widgets/app_dropdown_search.dart';
import 'package:asset_management/features/inventory/presentation/inventory_detail_view.dart';
import 'package:asset_management/features/location/location_export.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/core.dart';
import '../../assets/assets_export.dart';

class InventoryView extends StatefulWidget {
  const InventoryView({super.key});

  @override
  State<InventoryView> createState() => _InventoryViewState();
}

class _InventoryViewState extends State<InventoryView> {
  Location? warehouse;
  Location? rack;
  Location? box;
  AssetsEntity? selectedAsset;
  String searchQuery = '';

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
      body: BlocBuilder<AssetsBloc, AssetsState>(
        builder: (context, state) {
          final assets = state.assets ?? [];
          List<AssetsEntity> filteredAsset = [];

          if (rack == null && box == null) {
            filteredAsset = assets
                .where((e) => e.location == 'GUDANG I')
                .toList();
          } else if (rack != null && box == null) {
            filteredAsset = assets
                .where((e) => e.location == rack?.name)
                .toList();
          } else if (rack != null && box != null) {
            filteredAsset = assets
                .where((e) => e.location == box?.name)
                .toList();
          }

          if (searchQuery.isNotEmpty) {
            filteredAsset = filteredAsset.where((asset) {
              final query = searchQuery.toLowerCase();
              return (asset.assetCode?.toLowerCase().contains(query) ??
                      false) ||
                  (asset.model?.toLowerCase().contains(query) ?? false) ||
                  (asset.serialNumber?.toLowerCase().contains(query) ?? false);
            }).toList();
          }

          return Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
            child: Column(
              children: [
                BlocBuilder<LocationBloc, LocationState>(
                  builder: (context, state) {
                    warehouse = state.locations
                        ?.where((element) => element.name == 'GUDANG I')
                        .first;
                    return AppDropDownSearch<Location>(
                      title: 'Warehouse',
                      items: [],
                      hintText: 'Selected Warehouse',
                      compareFn: (value, value1) => value.name == value1.name,
                      selectedItem: warehouse,
                      itemAsString: (value) => value.name ?? '',
                      enabled: false,
                    );
                  },
                ),
                AppSpace.vertical(16),
                BlocBuilder<LocationBloc, LocationState>(
                  builder: (context, state) {
                    return AppDropDownSearch<Location>(
                      title: 'Rack',
                      items:
                          state.locations
                              ?.where(
                                (element) =>
                                    element.locationType == 'RACK' &&
                                    element.parentName == 'GUDANG I',
                              )
                              .toList() ??
                          [],
                      hintText: 'Selected Rack',
                      compareFn: (value, value1) => value.name == value1.name,
                      selectedItem: rack,
                      itemAsString: (value) => value.name ?? '',
                      onChanged: (value) {
                        if (value == rack) return;

                        setState(() {
                          rack = value;
                          box = null;
                        });
                      },
                    );
                  },
                ),
                AppSpace.vertical(16),
                BlocBuilder<LocationBloc, LocationState>(
                  builder: (context, state) {
                    return AppDropDownSearch<Location>(
                      title: 'Box',
                      items:
                          state.locations
                              ?.where(
                                (element) =>
                                    element.locationType == 'BOX' &&
                                    element.parentId == rack?.id,
                              )
                              .toList() ??
                          [],
                      hintText: 'Selected Box',
                      compareFn: (value, value1) => value.name == value1.name,
                      selectedItem: box,
                      itemAsString: (value) => value.name ?? '',
                      onChanged: (value) => setState(() {
                        box = value;
                      }),
                    );
                  },
                ),
                AppSpace.vertical(32),
                AppButton(
                  title: 'Show',
                  height: 30,
                  onPressed: () async {
                    await showModalBottomSheet(
                      context: context,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      builder: (context) {
                        return StatefulBuilder(
                          builder: (context, setModalState) {
                            return Padding(
                              padding: const EdgeInsets.fromLTRB(
                                16,
                                16,
                                16,
                                16,
                              ),
                              child: Column(
                                children: [
                                  AppTextField(
                                    noTitle: true,
                                    hintText: 'Search Asset',
                                    keyboardType: TextInputType.text,
                                    onChanged: (value) {
                                      setModalState(() {
                                        searchQuery = value;
                                      });
                                    },
                                  ),
                                  AppSpace.vertical(16),
                                  Expanded(
                                    child: ListView.builder(
                                      itemCount: filteredAsset.length,
                                      itemBuilder: (context, index) {
                                        final asset = filteredAsset[index];
                                        return AppCardItem(
                                          onTap: () {
                                            context.pop();
                                            context.push(
                                              InventoryDetailView(
                                                params: asset,
                                              ),
                                            );
                                          },
                                          title: asset.assetCode ?? asset.model,
                                          subtitle: asset.assetCode != null
                                              ? asset.serialNumber
                                              : '${asset.quantity} Pcs',
                                          leading: asset.location ?? '',
                                          descriptionLeft: asset.status ?? '',
                                          descriptionRight:
                                              asset.conditions ?? '',
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
