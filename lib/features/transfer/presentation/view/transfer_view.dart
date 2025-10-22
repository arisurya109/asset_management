import 'package:asset_management/core/widgets/app_dropdown_search.dart';
import 'package:asset_management/features/assets/assets_export.dart';
import 'package:asset_management/features/location/location_export.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/core.dart';
import '../../transfer_export.dart';

class TransferView extends StatefulWidget {
  const TransferView({super.key});

  @override
  State<TransferView> createState() => _TransferViewState();
}

class _TransferViewState extends State<TransferView> {
  AssetsEntity? asset;
  Location? fromL;
  Location? toL;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transfer'),
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
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: SingleChildScrollView(
          child: Column(
            children: [
              BlocBuilder<LocationBloc, LocationState>(
                builder: (context, state) {
                  return AppDropDownSearch<Location>(
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
                  );
                },
              ),
              AppSpace.vertical(16),
              BlocBuilder<LocationBloc, LocationState>(
                builder: (context, state) {
                  return AppDropDownSearch<Location>(
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
                  );
                },
              ),
              AppSpace.vertical(16),
              BlocBuilder<AssetsBloc, AssetsState>(
                builder: (context, state) {
                  return AppDropDownSearch<AssetsEntity>(
                    title: 'Asset',
                    items:
                        state.assets
                            ?.where(
                              (element) => element.location == fromL?.name,
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
              BlocConsumer<TransferBloc, TransferState>(
                listener: (context, state) {
                  setState(() {
                    asset = null;
                  });
                  if (state.status == StatusTransfer.initial) {
                    context.showSnackbar(
                      state.message ?? '',
                      backgroundColor: AppColors.kRed,
                    );
                  }
                  if (state.status == StatusTransfer.success) {
                    context.showSnackbar(state.response ?? '');
                  }
                },
                builder: (context, state) {
                  return AppButton(
                    title: state.status == StatusTransfer.loading
                        ? 'Loading...'
                        : 'Submit',
                    width: double.maxFinite,
                    onPressed: state.status == StatusTransfer.loading
                        ? null
                        : _onSubmit,
                  );
                },
              ),
            ],
          ),
        ),
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
          context.read<TransferBloc>().add(
            OnTransferAsset(
              Transfer(
                assetId: assetId,
                fromLocationId: from,
                toLocationId: to,
                movementType: 'TRANSFER',
                quantity: 1,
              ),
            ),
          );
          Navigator.pop(context);
        },
      );
    }
  }
}
