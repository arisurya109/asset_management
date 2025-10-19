import 'package:asset_management/core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/widgets/app_searchable_dropdown.dart';
import '../../../asset_model/asset_model_export.dart';
import '../../../location/location_export.dart';
import '../../registration_export.dart';

class RegistrationConsumableView extends StatefulWidget {
  const RegistrationConsumableView({super.key});

  @override
  State<RegistrationConsumableView> createState() =>
      _RegistrationConsumableViewState();
}

class _RegistrationConsumableViewState
    extends State<RegistrationConsumableView> {
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
              items: state.assets!
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
        BlocConsumer<RegistrationBloc, RegistrationState>(
          listener: (context, state) {
            quantity.clear();
            if (state.status == StatusRegistration.failed) {
              context.showSnackbar(
                state.message!,
                backgroundColor: AppColors.kRed,
              );
            }

            if (state.status == StatusRegistration.success) {
              context.showSnackbar('Successfully ${state.response}');
            }
          },
          builder: (context, state) {
            return AppButton(
              title: state.status == StatusRegistration.loading
                  ? 'Loading...'
                  : 'Add',
              width: double.maxFinite,
              onPressed: state.status == StatusRegistration.loading
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
          context.read<RegistrationBloc>().add(
            OnRegistrationAssetConsumable(
              Registration(
                serialNumber: '',
                assetModelId: model!.id,
                locationId: location?.id,
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
