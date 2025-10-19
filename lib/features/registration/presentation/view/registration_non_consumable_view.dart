import 'package:asset_management/core/core.dart';
import 'package:asset_management/features/printer/presentation/bloc/printer/printer_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/widgets/app_dropdown_search.dart';
import '../../../asset_model/asset_model_export.dart';
import '../../../location/location_export.dart';
import '../../registration_export.dart';

class RegistrationNonConsumableView extends StatefulWidget {
  const RegistrationNonConsumableView({super.key});

  @override
  State<RegistrationNonConsumableView> createState() =>
      _RegistrationNonConsumableViewState();
}

class _RegistrationNonConsumableViewState
    extends State<RegistrationNonConsumableView> {
  AssetModel? model;
  Location? location;
  String? status;
  String? conditions;
  String? colors;
  int? colorId;

  late TextEditingController serialNumber;
  late TextEditingController purchaseOrderNumber;
  late TextEditingController desription;

  @override
  void initState() {
    serialNumber = TextEditingController();
    purchaseOrderNumber = TextEditingController();
    desription = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocBuilder<LocationBloc, LocationState>(
          builder: (context, state) {
            return AppDropDownSearch<Location>(
              title: "Location",
              hintText: "Select location",
              borderRadius: 5,
              items: state.locations ?? [],
              itemAsString: (item) => item.name ?? '',
              selectedItem: location,
              compareFn: (a, b) => a.name == b.name,
              onChanged: (value) {
                setState(() => location = value);
              },
            );
          },
        ),
        AppSpace.vertical(16),
        BlocBuilder<AssetModelBloc, AssetModelState>(
          builder: (context, state) {
            return AppDropDownSearch<AssetModel>(
              title: "Model",
              hintText: "Select Model",
              borderRadius: 5,
              items: state.assets ?? [],
              itemAsString: (item) => item.name ?? '',
              selectedItem: model,
              compareFn: (a, b) => a.name == b.name,
              onChanged: (value) {
                setState(() => model = value);
              },
            );
          },
        ),
        AppSpace.vertical(16),
        AppDropDown(
          hintText: 'Selected Color',
          items: AssetsHelper.colors,
          title: 'Color',
          value: colors,
          onSelected: (value) => setState(() {
            colors = value;
            switch (colors) {
              case 'BLACK':
                colorId = 1;
                break;
              case 'WHITE':
                colorId = 2;
                break;
              case 'GREY':
                colorId = 3;
                break;
              case 'RED':
                colorId = 4;
                break;
              case 'BLUE':
                colorId = 5;
                break;
              default:
            }
          }),
        ),
        AppSpace.vertical(16),
        AppDropDown(
          hintText: 'Selected Condition',
          items: AssetsHelper.conditions,
          title: 'Condition',
          value: conditions,
          onSelected: (value) => setState(() {
            conditions = value;
          }),
        ),
        AppSpace.vertical(16),
        AppDropDown(
          hintText: 'Selected Status',
          items: AssetsHelper.status,
          title: 'Status',
          value: status,
          onSelected: (value) => setState(() {
            status = value;
          }),
        ),
        AppSpace.vertical(16),
        AppTextField(
          controller: desription,
          hintText: 'Optional',
          title: 'Description',
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.next,
        ),
        AppSpace.vertical(16),
        AppTextField(
          controller: purchaseOrderNumber,
          hintText: 'Optional',
          title: 'Purchase Order Number',
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.next,
        ),
        AppSpace.vertical(16),
        AppTextField(
          controller: serialNumber,
          hintText: 'Optional',
          title: 'Serial Number',
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.go,
          onSubmitted: (_) => _onSubmit(),
        ),
        AppSpace.vertical(32),
        BlocConsumer<RegistrationBloc, RegistrationState>(
          listener: (context, state) {
            serialNumber.clear();
            if (state.status == StatusRegistration.failed) {
              context.showSnackbar(
                state.message!,
                backgroundColor: AppColors.kRed,
              );
            }

            if (state.status == StatusRegistration.success) {
              context.read<PrinterBloc>().add(OnPrintAssetId(state.response!));
              context.showSnackbar('Successfully ${state.response}');
            }
          },
          builder: (context, state) {
            return AppButton(
              title: state.status == StatusRegistration.loading
                  ? 'Loading...'
                  : 'Registration',
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
    final sn = serialNumber.value.text.trim();
    final po = purchaseOrderNumber.value.text.trim();
    final desc = desription.value.text.trim();

    if (model != null &&
        colorId != null &&
        conditions != null &&
        status != null) {
      context.showDialogConfirm(
        title: 'Are you sure registration asset ?',
        content: 'Model : ${model?.name}\nSerial Number : $sn\n',
        onCancelText: 'No',
        onConfirmText: 'Yes',
        onCancel: () => Navigator.pop(context),
        onConfirm: () {
          context.read<RegistrationBloc>().add(
            OnRegistrationAssetNonConsumable(
              Registration(
                assetModelId: model!.id,
                serialNumber: sn.isEmpty ? '' : sn,
                locationId: location?.id,
                colorId: colorId,
                isConsumable: 0,
                conditions: conditions,
                quantity: 1,
                remarks: desc,
                uom: 1,
                status: status,
                purchaseOrder: po,
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
