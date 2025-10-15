import 'package:asset_management/core/core.dart';
import 'package:asset_management/features/asset_registration/domain/entities/asset_registration.dart';
import 'package:asset_management/features/locations/domain/entities/location.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/widgets/app_searchable_dropdown.dart';
import '../../../../asset_master_new/asset_master_export.dart';
import '../../../../locations/presentation/bloc/bloc/location_bloc.dart';
import '../../bloc/asset_registration/asset_registration_bloc.dart';

class AssetRegistrationConsumableView extends StatefulWidget {
  const AssetRegistrationConsumableView({super.key});

  @override
  State<AssetRegistrationConsumableView> createState() =>
      _AssetRegistrationConsumableViewState();
}

class _AssetRegistrationConsumableViewState
    extends State<AssetRegistrationConsumableView> {
  AssetModel? model;
  Location? location;
  late TextEditingController quantity;

  @override
  void initState() {
    quantity = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocBuilder<LocationBloc, LocationState>(
          builder: (context, state) {
            return AppSearchableDropdown<Location>(
              items: state.locations!,
              hintTextField: 'Find by name or code',
              onChanged: (value) => setState(() {
                location = value;
              }),
              hintText: 'Location',
              value: location,
              displayFn: (item) => '${item.name} - ${item.code ?? ''}',
              filterFn: (item, query) =>
                  item.name!.toUpperCase().contains(query.toUpperCase()) ||
                  item.code!.toUpperCase().contains(query.toUpperCase()),
            );
          },
        ),
        AppSpace.vertical(16),
        BlocBuilder<AssetModelBloc, AssetModelState>(
          builder: (context, state) {
            return AppSearchableDropdown<AssetModel>(
              items: state.assetModels!
                  .where((element) => element.isConsumable == 1)
                  .toList(),
              hintTextField: 'Find by name or code',
              onChanged: (value) => setState(() {
                model = value;
              }),
              hintText: 'Model',
              value: model,
              displayFn: (item) => '${item.name} - ${item.categoryName ?? ''}',
              filterFn: (item, query) =>
                  item.name!.toUpperCase().contains(query.toUpperCase()) ||
                  item.categoryName!.toUpperCase().contains(
                    query.toUpperCase(),
                  ),
            );
          },
        ),
        AppSpace.vertical(16),
        AppTextField(
          controller: quantity,
          hintText: 'Example : 34',
          title: 'Quantity',
          keyboardType: TextInputType.number,
          textInputAction: TextInputAction.go,
          onSubmitted: (_) => _onSubmit(),
        ),
        AppSpace.vertical(32),
        BlocConsumer<AssetRegistrationBloc, AssetRegistrationState>(
          listener: (context, state) {
            quantity.clear();
            if (state.status == StatusAssetRegistration.failed) {
              context.showSnackbar(
                state.message!,
                backgroundColor: AppColors.kRed,
              );
            }

            if (state.status == StatusAssetRegistration.success) {
              context.showSnackbar('Successfully add asset');
            }
          },
          builder: (context, state) {
            return AppButton(
              title: state.status == StatusAssetRegistration.loading
                  ? 'Loading...'
                  : 'Add',
              width: double.maxFinite,
              onPressed: state.status == StatusAssetRegistration.loading
                  ? null
                  : _onSubmit,
            );
          },
        ),
        AppSpace.vertical(12),
      ],
    );
  }

  _onSubmit() {
    final qty = quantity.value.text.trim();

    if (model != null && qty.isNumber()) {
      context.showDialogConfirm(
        title: 'Are you sure add asset ?',
        content: 'Model : ${model?.name}\nQuantity : $qty',
        onCancelText: 'No',
        onConfirmText: 'Yes',
        onCancel: () => Navigator.pop(context),
        onConfirm: () {
          context.read<AssetRegistrationBloc>().add(
            OnCreateAssetConsumable(
              AssetRegistration(
                assetModelId: model!.id,
                locationDetailId: location?.id,
                isConsumable: 1,
                quantity: int.parse(qty),
                uom: 0,
              ),
            ),
          );
          Navigator.pop(context);
        },
      );
    } else {
      context.showSnackbar(
        'Failed, please check field is empty',
        backgroundColor: AppColors.kRed,
      );
    }
  }
}
