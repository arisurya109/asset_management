import 'package:asset_management/presentation/components/app_card_item.dart';
import 'package:asset_management/core/core.dart';
import 'package:asset_management/domain/entities/asset/asset_entity.dart';
import 'package:asset_management/presentation/bloc/asset/asset_bloc.dart';
import 'package:asset_management/presentation/view/assets/asset_detail_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AssetView extends StatefulWidget {
  const AssetView({super.key});

  @override
  State<AssetView> createState() => _AssetViewState();
}

class _AssetViewState extends State<AssetView> {
  String searchQ = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Asset')),
      body: BlocBuilder<AssetBloc, AssetState>(
        builder: (context, state) {
          if (state.status == StatusAsset.loading) {
            return Center(
              child: CircularProgressIndicator(color: AppColors.kBase),
            );
          }

          if (state.assets != null || state.assets != []) {
            final assets = state.assets
              ?..sort((a, b) => a.id!.compareTo(b.id!));
            List<AssetEntity> filteredAssets = [];

            if (searchQ.isNotEmpty || searchQ != '') {
              filteredAssets = assets!.where((element) {
                final assetCode = element.assetCode?.toLowerCase() ?? '';
                final location = element.location?.toLowerCase() ?? '';
                final serialNumber = element.serialNumber?.toLowerCase() ?? '';
                final status = element.status?.toLowerCase() ?? '';
                final conditions = element.conditions?.toLowerCase() ?? '';
                final model = element.model?.toLowerCase() ?? '';
                final purchaseOrder =
                    element.purchaseOrder?.toLowerCase() ?? '';
                return assetCode.contains(searchQ.toLowerCase()) ||
                    location.contains(searchQ.toLowerCase()) ||
                    serialNumber.contains(searchQ.toLowerCase()) ||
                    status.contains(searchQ.toLowerCase()) ||
                    conditions.contains(searchQ.toLowerCase()) ||
                    model.contains(searchQ.toLowerCase()) ||
                    purchaseOrder.contains(searchQ.toLowerCase());
              }).toList();
            }
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  AppSpace.vertical(16),
                  AppTextField(
                    hintText: 'Search...',
                    keyboardType: TextInputType.text,
                    noTitle: true,
                    onChanged: (value) => setState(() {
                      searchQ = value;
                    }),
                  ),
                  AppSpace.vertical(16),
                  Expanded(
                    child: ListView.builder(
                      itemCount: filteredAssets.isEmpty
                          ? assets?.length
                          : filteredAssets.length,
                      itemBuilder: (context, index) {
                        final asset = filteredAssets.isEmpty
                            ? assets![index]
                            : filteredAssets[index];
                        return AppCardItem(
                          onTap: () {
                            context.read<AssetBloc>().add(
                              OnFindAssetDetailEvent(asset.id!),
                            );
                            context.push(AssetDetailView(params: asset));
                          },
                          title: asset.assetCode ?? asset.model,
                          subtitle: asset.assetCode != null
                              ? asset.serialNumber
                              : '${asset.quantity} Pcs',
                          noDescription: asset.uom == 0 ? true : false,
                          leading: asset.location ?? '',
                          descriptionLeft: asset.status ?? '',
                          descriptionRight: asset.conditions ?? '',
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          }

          return Container();
        },
      ),
    );
  }
}
