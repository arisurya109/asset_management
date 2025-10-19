import 'package:asset_management/components/app_card_item.dart';
import 'package:asset_management/core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../assets_export.dart';

class AssetsView extends StatefulWidget {
  const AssetsView({super.key});

  @override
  State<AssetsView> createState() => _AssetsViewState();
}

class _AssetsViewState extends State<AssetsView> {
  String? searchQ;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Asset'),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(height: 1, color: AppColors.kBase),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            AppSpace.vertical(12),
            AppTextField(
              hintText: 'Search',
              keyboardType: TextInputType.text,
              noTitle: true,
              onChanged: (value) =>
                  context.read<AssetsBloc>().add(OnSearchAssets(value)),
            ),
            AppSpace.vertical(12),
            Expanded(
              child: BlocBuilder<AssetsBloc, AssetsState>(
                builder: (context, state) {
                  if (state.status == StatusAssets.loading) {
                    return Center(
                      child: CircularProgressIndicator(color: AppColors.kBase),
                    );
                  }
                  if (state.status == StatusAssets.failed) {
                    return Center(child: Text(state.message ?? ''));
                  }

                  if (state.status == StatusAssets.success) {
                    return ListView.builder(
                      itemCount: state.assets?.length,
                      itemBuilder: (context, index) {
                        final asset = state.assets?[index];
                        return AppCardItem(
                          onTap: () {
                            context.read<AssetDetailBloc>().add(
                              OnGetAssetDetailById(asset!.id!),
                            );
                            context.push(AssetsDetailView(params: asset));
                          },
                          title: asset?.assetCode ?? asset?.model,
                          subtitle: asset?.assetCode != null
                              ? asset?.serialNumber
                              : '${asset?.quantity} Pcs',
                          leading: asset?.location ?? '',
                          descriptionLeft: asset?.status ?? '',
                          descriptionRight: asset?.conditions ?? '',
                        );
                      },
                    );
                  }
                  if (state.status == StatusAssets.filtered) {
                    return ListView.builder(
                      itemCount: state.filteredAssets?.length,
                      itemBuilder: (context, index) {
                        final asset = state.filteredAssets?[index];
                        return AppCardItem(
                          onTap: () {
                            context.read<AssetDetailBloc>().add(
                              OnGetAssetDetailById(asset!.id!),
                            );
                            context.push(AssetsDetailView(params: asset));
                          },
                          title: asset?.assetCode ?? asset?.model,
                          subtitle: asset?.assetCode != null
                              ? asset?.serialNumber
                              : '${asset?.quantity} Pcs',
                          leading: asset?.location ?? '',
                          descriptionLeft: asset?.status ?? '',
                          descriptionRight: asset?.conditions ?? '',
                        );
                      },
                    );
                  }
                  return Container();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
