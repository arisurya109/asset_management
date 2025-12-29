import 'package:asset_management/core/core.dart';
import 'package:asset_management/core/widgets/app_dropdown_search.dart';
import 'package:asset_management/domain/entities/master/asset_model.dart';
import 'package:asset_management/domain/entities/master/preparation_template.dart';
import 'package:asset_management/domain/entities/master/preparation_template_item.dart';
import 'package:asset_management/mobile/presentation/bloc/master/master_bloc.dart';
import 'package:asset_management/mobile/presentation/view/preparation_set/create_preparation_review_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SelectedPreparationItemView extends StatefulWidget {
  final PreparationTemplate params;

  const SelectedPreparationItemView({super.key, required this.params});

  @override
  State<SelectedPreparationItemView> createState() =>
      _SelectedPreparationItemViewState();
}

class _SelectedPreparationItemViewState
    extends State<SelectedPreparationItemView> {
  late TextEditingController quantityC;
  AssetModel? asset;
  List<PreparationTemplateItem> selectedItemAssets = [];

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
      appBar: AppBar(title: Text('Selected Asset Set')),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(16),
        child: AppButton(
          title: 'Review',
          width: context.deviceWidth,
          onPressed: () {
            if (selectedItemAssets == []) {
              context.showSnackbar(
                'No assets have been selected yet',
                backgroundColor: AppColors.kRed,
              );
            } else {
              context.pushExt(
                CreatePreparationReviewView(
                  params: widget.params.copyWith(items: selectedItemAssets),
                ),
              );
            }
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              AppSpace.vertical(16),
              BlocBuilder<MasterBloc, MasterState>(
                builder: (context, state) {
                  return AppDropDownSearch<AssetModel>(
                    title: 'Asset',
                    items: state.models ?? [],
                    hintText: 'Selected Asset',
                    borderRadius: 5,
                    compareFn: (value, value1) => value.name == value1.name,
                    itemAsString: (value) => value.name ?? '',
                    selectedItem: asset,
                    onChanged: (value) => setState(() {
                      asset = value;
                    }),
                  );
                },
              ),
              AppSpace.vertical(16),
              AppTextField(
                controller: quantityC,
                hintText: 'Example : 1',
                title: 'Quantity',
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => _add(),
              ),
              AppSpace.vertical(48),
              AppButton(
                title: 'Add',
                width: context.deviceWidth,
                onPressed: _add,
              ),
            ],
          ),
        ),
      ),
    );
  }

  _add() {
    final assetModel = asset;
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

      final existingItemIndex = selectedItemAssets.indexWhere(
        (item) => item.modelId == assetModel.id,
      );

      setState(() {
        if (existingItemIndex != -1) {
          final existingItem = selectedItemAssets[existingItemIndex];

          final updatedItem = existingItem.copyWith(
            quantity: existingItem.quantity! + newQuantity,
          );

          selectedItemAssets[existingItemIndex] = updatedItem;

          context.showSnackbar(
            'Quantity added to existing asset model',
            backgroundColor: AppColors.kBase,
          );
        } else {
          selectedItemAssets.add(
            PreparationTemplateItem(
              modelId: assetModel.id,
              assetType: assetModel.typeName,
              assetBrand: assetModel.brandName,
              assetCategory: assetModel.categoryName,
              assetModel: assetModel.name,
              quantity: newQuantity,
            ),
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
