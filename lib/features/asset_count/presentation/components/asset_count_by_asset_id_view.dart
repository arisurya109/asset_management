import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/asset_count/asset_count_bloc.dart';
import '../bloc/asset_count_detail/asset_count_detail_bloc.dart';
import '../../domain/entities/asset_count_detail.dart';
import '../../../../core/core.dart';

class AssetCountByAssetIdView extends StatefulWidget {
  const AssetCountByAssetIdView({super.key});

  @override
  State<AssetCountByAssetIdView> createState() =>
      _AssetCountByAssetIdViewState();
}

class _AssetCountByAssetIdViewState extends State<AssetCountByAssetIdView> {
  late TextEditingController locationC;
  late TextEditingController boxC;
  late TextEditingController assetIdC;

  @override
  void dispose() {
    assetIdC.dispose();
    locationC.dispose();
    boxC.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    locationC = TextEditingController();
    boxC = TextEditingController();
    assetIdC = TextEditingController();
  }

  _onSubmit() {
    final location = locationC.value.text.trim();
    final box = boxC.value.text.trim();
    final assetId = assetIdC.value.text.trim();

    if (!assetId.isFilled()) {
      context.showSnackbar(
        'Asset ID Nothing should be empty',
        backgroundColor: Colors.red,
      );
    } else if (!location.isFilled()) {
      context.showSnackbar(
        'Location Nothing should be empty',
        backgroundColor: Colors.red,
      );
    } else {
      context.showDialogConfirm(
        title: 'Add Asset Count ?',
        content:
            'Are you sure you want to add \nAsset ID : $assetId\nQuantity : 1\nLocation : $location\nBox : $box',
        onCancel: () => Navigator.pop(context),
        onCancelText: 'Cancel',
        onConfirmText: 'Add',
        onConfirm: () {
          context.read<AssetCountDetailBloc>().add(
            OnCreateAssetCountDetail(
              AssetCountDetail(
                countId: context
                    .read<AssetCountBloc>()
                    .state
                    .assetCountDetail!
                    .id,
                assetId: assetId,
                box: box,
                location: location,
                quantity: 1,
              ),
            ),
          );
          Navigator.pop(context);
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppTextField(
          title: 'Location',
          controller: locationC,
          hintText: 'Example : LD.01.01.01',
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.next,
        ),
        AppSpace.vertical(16),
        AppTextField(
          title: 'Box',
          controller: boxC,
          hintText: 'Example : BOX-LD-01',
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.next,
        ),
        AppSpace.vertical(16),
        AppTextField(
          title: 'Asset ID',
          controller: assetIdC,
          hintText: 'Example : AST-PRN-2501010001',
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.go,
          onSubmitted: (_) => _onSubmit(),
        ),
        AppSpace.vertical(24),
        BlocConsumer<AssetCountDetailBloc, AssetCountDetailState>(
          listener: (context, state) {
            if (state.status == StatusAssetCountDetail.failed &&
                state.message != null) {
              context.showSnackbar(state.message!, backgroundColor: Colors.red);
            }

            if (state.status == StatusAssetCountDetail.created &&
                state.message != null) {
              assetIdC.clear();
              context.showSnackbar(
                state.message!,
                backgroundColor: AppColors.kBase,
              );
            }
          },
          builder: (context, state) {
            final statusDoc = context
                .watch<AssetCountBloc>()
                .state
                .assetCountDetail
                ?.status;
            return AppButton(
              title: state.status == StatusAssetCountDetail.loading
                  ? 'Loading...'
                  : 'Submit',
              onPressed: statusDoc != StatusCount.ONPROCESS
                  ? null
                  : state.status == StatusAssetCountDetail.loading
                  ? null
                  : _onSubmit,
            );
          },
        ),
      ],
    );
  }
}
