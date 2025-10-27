// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:asset_management/core/core.dart';
import 'package:asset_management/domain/entities/master/asset_model.dart';
import 'package:asset_management/domain/entities/purchase_order/purchase_order_detail.dart';
import 'package:asset_management/presentation/bloc/master/master_bloc.dart';
import 'package:flutter/material.dart';

import 'package:asset_management/domain/entities/purchase_order/purchase_order.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SelectedAssetNonConsumableView extends StatefulWidget {
  final PurchaseOrder params;

  const SelectedAssetNonConsumableView({super.key, required this.params});

  @override
  State<SelectedAssetNonConsumableView> createState() =>
      _SelectedAssetNonConsumableViewState();
}

class _SelectedAssetNonConsumableViewState
    extends State<SelectedAssetNonConsumableView> {
  AssetModel? selectedAssetModel;
  List<PurchaseOrderDetail> selectedItems = [];
  late TextEditingController quantityC;

  @override
  void initState() {
    quantityC = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    quantityC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Selected Asset')),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              AppSpace.vertical(16),
              BlocBuilder<MasterBloc, MasterState>(
                builder: (context, state) {
                  return AppDropDown<AssetModel>(
                    hintText: 'Selected Asset',
                    items: state.models,
                    title: 'Asset Model',
                    value: selectedAssetModel,
                    onSelected: (value) => setState(() {
                      selectedAssetModel = value;
                    }),
                  );
                },
              ),
              AppSpace.vertical(16),
              AppTextField(
                hintText: 'Example : 1',
                title: 'Quantity',
                controller: quantityC,
                textInputAction: TextInputAction.go,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => _add(),
              ),
              AppSpace.vertical(32),
              AppButton(
                title: 'Add',
                onPressed: _add,
                width: context.deviceWidth,
              ),
            ],
          ),
        ),
      ),
    );
  }

  _add() {
    final assetModel = selectedAssetModel;
    final quantityText = quantityC.value.text.trim();

    if (assetModel == null) {
      context.showSnackbar(
        'Asset Model not yet selected',
        backgroundColor: AppColors.kRed,
      );
    } else if (quantityText.isEmpty) {
      context.showSnackbar(
        'Quantity cannot be empty',
        backgroundColor: AppColors.kRed,
      );
    } else if (!quantityText.isNumber()) {
      context.showSnackbar(
        'Quantity not valid (must be a number)',
        backgroundColor: AppColors.kRed,
      );
    } else {
      final newQuantity = int.tryParse(quantityText);

      if (newQuantity == null || newQuantity < 1) {
        context.showSnackbar(
          'Quantity not valid (must be >= 1)',
          backgroundColor: AppColors.kRed,
        );
        return;
      }

      final existingItemIndex = selectedItems.indexWhere(
        (item) => item.modelId == assetModel.id,
      );

      setState(() {
        if (existingItemIndex != -1) {
          final existingItem = selectedItems[existingItemIndex];

          final updatedItem = existingItem.copyWith(
            quantity: existingItem.quantity! + newQuantity,
          );

          selectedItems[existingItemIndex] = updatedItem;

          context.showSnackbar(
            'Quantity added to existing asset model',
            backgroundColor: AppColors.kBase,
          );
        } else {
          selectedItems.add(
            PurchaseOrderDetail(modelId: assetModel.id, quantity: newQuantity),
          );
          context.showSnackbar(
            'New asset model added',
            backgroundColor: AppColors.kBase,
          );
        }
        quantityC.clear();
      });
    }
  }
}
