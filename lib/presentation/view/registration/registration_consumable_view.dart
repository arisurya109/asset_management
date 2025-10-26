import 'package:asset_management/core/core.dart';
import 'package:asset_management/core/widgets/app_dropdown_search.dart';
import 'package:asset_management/domain/entities/asset/asset_entity.dart';
import 'package:asset_management/domain/entities/master/asset_model.dart';
import 'package:asset_management/domain/entities/master/location.dart';
import 'package:asset_management/presentation/bloc/asset/asset_bloc.dart';
import 'package:asset_management/presentation/bloc/master/master_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    return BlocBuilder<MasterBloc, MasterState>(
      builder: (context, state) {
        return Column(
          children: [
            AppDropDownSearch<Location>(
              items: state.locations!
                ..sort((a, b) => a.name!.compareTo(b.name!)),
              showSearchBox: true,
              compareFn: (p0, p1) => p0 == p1,
              onChanged: (value) => setState(() {
                location = value;
              }),
              selectedItem: location,
              itemAsString: (p0) => p0.name!,
              hintText: 'Selected Location',
              title: 'Location',
            ),
            AppSpace.vertical(16),
            AppDropDownSearch<AssetModel>(
              items: state.models!
                  .where((element) => element.isConsumable == 1)
                  .toList(),
              showSearchBox: true,
              compareFn: (p0, p1) => p0 == p1,
              onChanged: (value) => setState(() {
                model = value;
              }),
              selectedItem: model,
              itemAsString: (p0) => '${p0.categoryName} ${p0.name}',
              hintText: 'Selected Model',
              title: 'Model',
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
            BlocConsumer<AssetBloc, AssetState>(
              listener: (context, state) {
                quantity.clear();
                if (state.status == StatusAsset.failed) {
                  context.showSnackbar(
                    state.message!,
                    backgroundColor: AppColors.kRed,
                  );
                }

                if (state.status == StatusAsset.success) {
                  context.showSnackbar('Successfully registration asset');
                }
              },
              builder: (context, state) {
                return AppButton(
                  title: state.status == StatusAsset.loading
                      ? 'Loading...'
                      : 'Add',
                  width: double.maxFinite,
                  onPressed: state.status == StatusAsset.loading
                      ? null
                      : _onSubmit,
                );
              },
            ),
            AppSpace.vertical(12),
          ],
        );
      },
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
          context.read<AssetBloc>().add(
            OnCreateAssetsEvent(
              AssetEntity(
                serialNumber: '',
                assetModelId: model!.id,
                locationId: location?.id,
                quantity: int.parse(qty),
                uom: 0,
                isMigration: 0,
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
