import 'package:asset_management/features/asset_registration/presentation/bloc/asset_registration/asset_registration_bloc.dart';
import 'package:asset_management/features/locations/presentation/bloc/bloc/location_bloc.dart';
import 'package:asset_management/features/modules/asset_transfer/domain/entities/asset_transfer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/core.dart';
import '../bloc/asset_transfer/asset_transfer_bloc.dart';

class AssetTransferView extends StatefulWidget {
  const AssetTransferView({super.key});

  @override
  State<AssetTransferView> createState() => _AssetTransferViewState();
}

class _AssetTransferViewState extends State<AssetTransferView> {
  late TextEditingController fromC;
  late TextEditingController toC;
  late TextEditingController assetCode;

  @override
  void initState() {
    fromC = TextEditingController();
    toC = TextEditingController();
    assetCode = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    fromC.dispose();
    toC.dispose();
    assetCode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ASSET TRANSFER'),
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
              AppTextField(
                title: 'From Location',
                hintText: 'Example : NW.01.01.02',
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                controller: fromC,
              ),
              AppSpace.vertical(16),
              AppTextField(
                title: 'To Location',
                hintText: 'Example : LD.01.01.01',
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                controller: toC,
              ),
              AppSpace.vertical(16),
              AppTextField(
                title: 'Asset Code',
                hintText: 'Example : OFC-CPU-0000000001',
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.go,
                controller: assetCode,
                onSubmitted: (_) => _onSubmit(),
              ),
              AppSpace.vertical(32),
              BlocConsumer<AssetTransferBloc, AssetTransferState>(
                listener: (context, state) {
                  assetCode.clear();
                  if (state.status == StatusAssetTransfer.initial) {
                    context.showSnackbar(
                      state.messageFailed ?? '',
                      backgroundColor: AppColors.kRed,
                    );
                  }
                  if (state.status == StatusAssetTransfer.success) {
                    context.showSnackbar(state.messageSuccess ?? '');
                  }
                },
                builder: (context, state) {
                  return AppButton(
                    title: state.status == StatusAssetTransfer.loading
                        ? 'Loading...'
                        : 'Submit',
                    width: double.maxFinite,
                    onPressed: state.status == StatusAssetTransfer.loading
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
    final from = fromC.value.text.trim();
    final to = toC.value.text.trim();
    final asset = assetCode.value.text.trim();

    if (from.isEmpty) {
      context.showSnackbar(
        'From location cannot be empty',
        backgroundColor: AppColors.kRed,
      );
    } else if (to.isEmpty) {
      context.showSnackbar(
        'To location cannot be emoty',
        backgroundColor: AppColors.kRed,
      );
    } else if (asset.isEmpty) {
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
      final assetId = context
          .read<AssetRegistrationBloc>()
          .state
          .assetNonConsumable
          ?.firstWhere((element) => element.assetCode == asset)
          .id;

      final fromP = context
          .read<LocationBloc>()
          .state
          .locations
          ?.firstWhere((element) => element.name == from)
          .id;
      final toP = context
          .read<LocationBloc>()
          .state
          .locations
          ?.firstWhere((element) => element.name == to)
          .id;

      context.showDialogConfirm(
        title: 'Are your sure transfer asset ?',
        content: 'From : $from\nTo : $to\nAsset Code : $asset',
        onCancelText: 'No',
        onConfirmText: 'Yes',
        onCancel: () => Navigator.pop(context),
        onConfirm: () {
          context.read<AssetTransferBloc>().add(
            OnCreateAssetTransfer(
              AssetTransfer(
                assetId: assetId,
                assetCode: asset,
                fromLocationId: fromP,
                toLocationId: toP,
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
