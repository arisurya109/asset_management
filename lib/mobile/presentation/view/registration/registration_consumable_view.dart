import 'package:asset_management/core/core.dart';
import 'package:asset_management/core/widgets/app_dropdown_search.dart';
import 'package:asset_management/domain/entities/asset/asset_entity.dart';
import 'package:asset_management/domain/entities/master/asset_model.dart';
import 'package:asset_management/domain/entities/master/location.dart';
import 'package:asset_management/mobile/presentation/bloc/registration/registration_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegistrationConsumableView extends StatefulWidget {
  final bool isLarge;
  const RegistrationConsumableView({super.key, required this.isLarge});

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
  void dispose() {
    quantity.dispose();
    FocusManager.instance.primaryFocus?.unfocus();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegistrationCubit, RegistrationState>(
      builder: (context, state) {
        return Column(
          children: [
            AppDropDownSearch<Location>(
              title: "Location",
              fontSize: widget.isLarge ? 14 : 12,
              hintText: "Select location",
              borderRadius: 4,
              onFind: (value) async =>
                  await context.read<RegistrationCubit>().getLocations(),
              itemAsString: (item) => item.name ?? '',
              selectedItem: location,
              compareFn: (a, b) => a.name == b.name,
              onChanged: (value) => setState(() {
                location = value;
              }),
            ),
            AppSpace.vertical(16),
            AppDropDownSearch<AssetModel>(
              title: "Model",
              hintText: "Select Model",
              fontSize: widget.isLarge ? 14 : 12,
              borderRadius: 4,
              onFind: (value) async => await context
                  .read<RegistrationCubit>()
                  .getAssetModelsConsumable(),
              itemAsString: (item) => item.name ?? '',
              selectedItem: model,
              compareFn: (a, b) => a.name == b.name,
              onChanged: (value) => setState(() {
                model = value;
              }),
            ),
            AppSpace.vertical(16),
            AppTextField(
              controller: quantity,
              hintText: 'Example : 34',
              title: 'Quantity',
              fontSize: widget.isLarge ? 14 : 12,
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.go,
              onSubmitted: (_) => _onSubmit(),
            ),
            AppSpace.vertical(32),
            BlocConsumer<RegistrationCubit, RegistrationState>(
              listener: (context, state) {
                quantity.clear();
                if (state.status == StatusRegistration.failure) {
                  context.showSnackbar(
                    state.message!,
                    fontSize: widget.isLarge ? 12 : 10,
                    backgroundColor: AppColors.kRed,
                  );
                }

                if (state.status == StatusRegistration.success) {
                  context.showSnackbar(
                    'Successfully registration asset',
                    fontSize: widget.isLarge ? 12 : 10,
                  );
                }
              },
              builder: (context, state) {
                return AppButton(
                  title: state.status == StatusRegistration.loading
                      ? 'Loading...'
                      : 'Add',
                  width: double.maxFinite,
                  fontSize: widget.isLarge ? 14 : 12,
                  onPressed: state.status == StatusRegistration.loading
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
        fontSize: widget.isLarge ? 14 : 12,
        onCancel: () => Navigator.pop(context),
        onConfirm: () {
          context.read<RegistrationCubit>().onRegistAsset(
            AssetEntity(
              assetModelId: model!.id,
              locationId: location?.id,
              quantity: int.parse(qty),
              uom: 0,
            ),
          );
          Navigator.pop(context);
        },
      );
    } else {
      context.showSnackbar(
        'Failed, please check field is empty',
        backgroundColor: AppColors.kRed,
        fontSize: widget.isLarge ? 12 : 10,
      );
    }
  }
}
