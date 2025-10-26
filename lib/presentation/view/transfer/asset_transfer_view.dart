import 'package:asset_management/core/widgets/app_dropdown_search.dart';
import 'package:asset_management/domain/entities/asset/asset_entity.dart';
import 'package:asset_management/domain/entities/master/location.dart';
import 'package:asset_management/presentation/bloc/asset/asset_bloc.dart';
import 'package:asset_management/presentation/bloc/master/master_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/core.dart';

class TransferView extends StatefulWidget {
  const TransferView({super.key});

  @override
  State<TransferView> createState() => _TransferViewState();
}

class _TransferViewState extends State<TransferView> {
  AssetEntity? asset;
  Location? fromL;
  Location? toL;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Transfer')),
      body: BlocBuilder<MasterBloc, MasterState>(
        builder: (context, state) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  AppDropDownSearch<Location>(
                    title: 'From Location',
                    items:
                        state.locations!
                            .where(
                              (element) =>
                                  element.locationType == 'BOX' ||
                                  element.locationType == 'RACK' ||
                                  element.name == 'GUDANG I',
                            )
                            .toList()
                          ..sort((a, b) => a.name!.compareTo(b.name!)),
                    hintText: 'Selected From Location',
                    compareFn: (value1, value) => value1.name == value.name,
                    selectedItem: fromL,
                    onChanged: (value) => setState(() {
                      fromL = value;
                    }),
                    itemAsString: (value) => value.name.toString(),
                  ),
                  AppSpace.vertical(16),
                  AppDropDownSearch<Location>(
                    title: 'To Location',
                    onChanged: (value) => setState(() {
                      toL = value;
                    }),
                    items:
                        state.locations!
                            .where(
                              (element) =>
                                  element.locationType == 'BOX' ||
                                  element.locationType == 'RACK' &&
                                      element != fromL,
                            )
                            .toList()
                          ..sort((a, b) => a.name!.compareTo(b.name!)),
                    hintText: 'Selected To Location',
                    compareFn: (value1, value) => value1.name == value.name,
                    selectedItem: toL,
                    itemAsString: (value) => value.name.toString(),
                  ),
                  AppSpace.vertical(16),
                  BlocBuilder<AssetBloc, AssetState>(
                    builder: (context, state) {
                      return AppDropDownSearch<AssetEntity>(
                        title: 'Asset',
                        items:
                            state.assets
                                ?.where(
                                  (element) =>
                                      element.location == fromL?.name &&
                                      element.uom == 1,
                                )
                                .toList() ??
                            [],
                        onChanged: (value) => setState(() {
                          asset = value;
                        }),
                        hintText: 'Selected Asset',
                        compareFn: (value1, value) =>
                            value1.assetCode == value.assetCode,
                        selectedItem: asset,
                        itemAsString: (value) => value.assetCode.toString(),
                      );
                    },
                  ),

                  AppSpace.vertical(32),
                  BlocConsumer<AssetBloc, AssetState>(
                    listener: (context, state) {
                      setState(() {
                        asset = null;
                      });
                      if (state.status == StatusAsset.initial) {
                        context.showSnackbar(
                          state.message ?? '',
                          backgroundColor: AppColors.kRed,
                        );
                      }
                      if (state.status == StatusAsset.success) {
                        context.showSnackbar('Successfully transfer asset');
                      }
                    },
                    builder: (context, state) {
                      return AppButton(
                        title: state.status == StatusAsset.loading
                            ? 'Loading...'
                            : 'Submit',
                        width: double.maxFinite,
                        onPressed: state.status == StatusAsset.loading
                            ? null
                            : _onSubmit,
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  _onSubmit() {
    final from = fromL?.id;
    final to = toL?.id;
    final assetId = asset?.id;

    if (from == null) {
      context.showSnackbar(
        'From location cannot be empty',
        backgroundColor: AppColors.kRed,
      );
    } else if (to == null) {
      context.showSnackbar(
        'To location cannot be emoty',
        backgroundColor: AppColors.kRed,
      );
    } else if (asset == null) {
      context.showSnackbar(
        'Asset Code cannot be emoty',
        backgroundColor: AppColors.kRed,
      );
    } else if (from == to) {
      context.showSnackbar(
        'Failed, From the same location and destination',
        backgroundColor: AppColors.kRed,
      );
    } else {
      context.showDialogConfirm(
        title: 'Are your sure transfer asset ?',
        content:
            'From : ${fromL?.name}\nTo : ${toL?.name}\nAsset Code : ${asset?.assetCode}',
        onCancelText: 'No',
        onConfirmText: 'Yes',
        onCancel: () => Navigator.pop(context),
        onConfirm: () {
          context.read<AssetBloc>().add(
            OnCreateAssetTransferEvent(
              assetId: assetId!,
              fromLocationId: from,
              toLocationId: to,
              movementType: 'TRANSFER',
              quantity: 1,
            ),
          );
          Navigator.pop(context);
        },
      );
    }
  }
}
