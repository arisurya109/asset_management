import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/core.dart';
import '../../../../core/widgets/app_dropdown_search.dart';
import '../../../assets/assets_export.dart';
import '../../../location/location_export.dart';

class SelectAssetNonConsumableView extends StatefulWidget {
  const SelectAssetNonConsumableView({super.key});

  @override
  State<SelectAssetNonConsumableView> createState() =>
      _SelectAssetNonConsumableViewState();
}

class _SelectAssetNonConsumableViewState
    extends State<SelectAssetNonConsumableView> {
  Location? rack;
  Location? box;

  final List<AssetsEntity> selectedAssets = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Asset Non Consumable'),
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
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
        child: Column(
          children: [
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
            AppSpace.vertical(16),
            BlocBuilder<AssetsBloc, AssetsState>(
              builder: (context, state) {
                var filtered =
                    state.assets
                        ?.where((element) => element.uom == 1)
                        .toList() ??
                    [];

                // Filter by location
                if (rack == null && box == null) {
                  filtered = [];
                } else if (rack != null && box == null) {
                  filtered = filtered
                      .where((e) => e.location == rack?.name)
                      .toList();
                } else if (rack != null && box != null) {
                  filtered = filtered
                      .where((e) => e.location == box?.name)
                      .toList();
                }
                return Expanded(
                  child: ListView.builder(
                    itemCount: filtered.length,
                    itemBuilder: (context, index) {
                      final asset = filtered[index];
                      final isSelected = selectedAssets.contains(asset);
                      return Container(
                        margin: EdgeInsets.only(
                          bottom: index == filtered.length - 1 ? 16 : 12,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? AppColors.kBase.withOpacity(0.15)
                              : Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: isSelected
                                ? AppColors.kBase
                                : Colors.grey.shade300,
                          ),
                        ),
                        child: ListTile(
                          title: Text(asset.assetCode ?? '-'),
                          isThreeLine: true,
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppSpace.vertical(5),
                              Text(
                                '${asset.status} | ${asset.conditions} | ${asset.color}',
                              ),
                              AppSpace.vertical(5),
                              Text(
                                '${asset.model} | ${asset.remarks} | ${asset.purchaseOrder}',
                              ),
                            ],
                          ),
                          trailing: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              isSelected
                                  ? const Icon(
                                      Icons.check_box,
                                      color: AppColors.kBase,
                                    )
                                  : const Icon(
                                      Icons.check_box_outline_blank,
                                      color: Colors.grey,
                                    ),
                            ],
                          ),
                          onTap: () {
                            setState(() {
                              if (isSelected) {
                                selectedAssets.remove(asset);
                              } else {
                                selectedAssets.add(asset);
                              }
                            });
                          },
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
