import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/asset_count/asset_count_bloc.dart';
import '../bloc/asset_count_detail/asset_count_detail_bloc.dart';
import '../../domain/entities/asset_count_detail.dart';
import '../../../asset_master/presentation/bloc/asset_master/asset_master_bloc.dart';
import '../../../../core/core.dart';

class AssetCountNonAssetIdView extends StatefulWidget {
  const AssetCountNonAssetIdView({super.key});

  @override
  State<AssetCountNonAssetIdView> createState() =>
      _AssetCountNonAssetIdViewState();
}

class _AssetCountNonAssetIdViewState extends State<AssetCountNonAssetIdView> {
  late TextEditingController locationC;
  late TextEditingController boxC;
  late TextEditingController quantityC;
  String? asset;

  @override
  void dispose() {
    locationC.dispose();
    boxC.dispose();
    quantityC.dispose();
    super.dispose();
  }

  @override
  void initState() {
    locationC = TextEditingController();
    boxC = TextEditingController();
    quantityC = TextEditingController();
    super.initState();
  }

  _onSubmit() {
    final location = locationC.value.text.trim();
    final box = boxC.value.text.trim();
    final quantity = quantityC.value.text.trim();
    final newAsset = asset?.trim();

    if (!location.isFilled()) {
      context.showSnackbar(
        'Location Nothing should be empty',
        backgroundColor: Colors.red,
      );
    } else if (!newAsset.isFilled()) {
      context.showSnackbar(
        'Asset Nothing should be empty',
        backgroundColor: Colors.red,
      );
    } else if (!quantity.isFilled() && quantity.isFilled()) {
    } else {
      context.showDialogConfirm(
        title: 'Add Asset Count ?',
        content:
            'Are you sure you want to add \nAsset ID : $newAsset\nQuantity : $quantity\nLocation : $location\nBox : $box',
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
                assetId: newAsset,
                box: box,
                location: location,
                quantity: int.parse(quantity),
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
          hintText: 'Example : LD.01.01.01',
          controller: locationC,
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.next,
          title: 'Location',
        ),
        AppSpace.vertical(16),
        AppTextField(
          hintText: 'Example : BOX-LD-01',
          controller: boxC,
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.next,
          title: 'Box',
        ),
        AppSpace.vertical(16),
        BlocBuilder<AssetMasterBloc, AssetMasterState>(
          builder: (context, state) {
            return AppDropDown(
              hintText: 'Selected Asset',
              items: state.assets?.map((e) => e.name).toList(),
              title: 'Asset',
              value: asset,
              onSelected: (value) => setState(() {
                asset = value;
              }),
            );
          },
        ),
        AppSpace.vertical(16),
        AppTextField(
          hintText: 'Example : 34',
          controller: quantityC,
          keyboardType: TextInputType.number,
          textInputAction: TextInputAction.go,
          title: 'Quantity',
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
              setState(() {
                asset = null;
                quantityC.clear();
              });
              context.showSnackbar(state.message!);
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
              width: double.maxFinite,
            );
          },
        ),
      ],
    );
  }
}
