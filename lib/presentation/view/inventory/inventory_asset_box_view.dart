import 'package:asset_management/presentation/bloc/printer/printer_bloc.dart';
import 'package:asset_management/presentation/components/app_card_item.dart';
import 'package:asset_management/core/core.dart';
import 'package:asset_management/domain/entities/master/location.dart';
import 'package:asset_management/presentation/bloc/asset/asset_bloc.dart';
import 'package:asset_management/presentation/view/inventory/inventory_detail_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InventoryAssetBoxView extends StatelessWidget {
  final Location location;
  const InventoryAssetBoxView({super.key, required this.location});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(location.name!),
        actions:
            location.locationType == 'BOX' ||
                location.locationType == 'RACK' ||
                location.locationType == 'TABLE'
            ? [
                BlocListener<PrinterBloc, PrinterState>(
                  listener: (context, state) {
                    if (state.status == PrinterStatus.success) {
                      context.showSnackbar('Success reprint location');
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: InkWell(
                      onTap: () => context.read<PrinterBloc>().add(
                        OnPrintLocation(location.name!),
                      ),
                      borderRadius: BorderRadius.circular(32),
                      child: CircleAvatar(
                        backgroundColor: Colors.transparent,
                        child: AppAssetImg(
                          Assets.iReprint,
                          color: AppColors.kBase,
                        ),
                      ),
                    ),
                  ),
                ),
              ]
            : [],
      ),
      body: BlocBuilder<AssetBloc, AssetState>(
        builder: (context, state) {
          final filteredAsset = state.assets!.where((element) {
            final locations = element.location?.toLowerCase() ?? '';
            return locations.contains(location.name!.toLowerCase());
          }).toList();

          if (filteredAsset.isEmpty) {
            return Center(child: Text('Asset is empty'));
          }
          return ListView.builder(
            padding: EdgeInsets.fromLTRB(16, 12, 16, 0),
            itemCount: filteredAsset.length,
            itemBuilder: (context, index) {
              final e = filteredAsset[index];
              return AppCardItem(
                title: e.assetCode ?? e.model,
                leading: e.location,
                onTap: () => context.push(InventoryDetailView(params: e)),
                subtitle: e.serialNumber ?? e.quantity.toString(),
                descriptionLeft: e.status ?? '',
                descriptionRight: e.conditions ?? '',
              );
            },
          );
        },
      ),
    );
  }
}
