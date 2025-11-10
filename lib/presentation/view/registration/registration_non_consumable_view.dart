import 'package:asset_management/core/core.dart';
import 'package:asset_management/domain/entities/asset/asset_entity.dart';
import 'package:asset_management/domain/entities/master/asset_model.dart';
import 'package:asset_management/domain/entities/master/location.dart';
import 'package:asset_management/presentation/bloc/asset/asset_bloc.dart';
import 'package:asset_management/presentation/bloc/master/master_bloc.dart';
import 'package:asset_management/presentation/bloc/printer/printer_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/widgets/app_dropdown_search.dart';

class RegistrationNonConsumableView extends StatefulWidget {
  final bool isLarge;

  const RegistrationNonConsumableView({super.key, required this.isLarge});

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
  late TextEditingController description;

  @override
  void initState() {
    serialNumber = TextEditingController();
    purchaseOrderNumber = TextEditingController();
    description = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    serialNumber.dispose();
    purchaseOrderNumber.dispose();
    description.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MasterBloc, MasterState>(
      builder: (context, state) {
        return Column(
          children: [
            AppDropDownSearch<Location>(
              title: "Location",
              fontSize: widget.isLarge ? 12 : 10,
              hintText: "Select location",
              borderRadius: 5,
              items: state.locations!
                ..sort((a, b) => a.name!.compareTo(b.name!)),
              itemAsString: (item) => item.name ?? '',
              selectedItem: location,
              compareFn: (a, b) => a.name == b.name,
              onChanged: (value) {
                setState(() => location = value);
              },
            ),
            AppSpace.vertical(16),
            AppDropDownSearch<AssetModel>(
              title: "Model",
              hintText: "Select Model",
              fontSize: widget.isLarge ? 12 : 10,
              borderRadius: 5,
              items: state.models ?? [],
              itemAsString: (item) => item.name ?? '',
              selectedItem: model,
              compareFn: (a, b) => a.name == b.name,
              onChanged: (value) {
                setState(() => model = value);
              },
            ),
            AppSpace.vertical(16),
            AppDropDownSearch<String>(
              title: 'Color',
              hintText: "Selected Color",
              fontSize: widget.isLarge ? 12 : 10,
              borderRadius: 5,
              items: AssetsHelper.colors,
              itemAsString: (item) => item,
              selectedItem: colors,
              compareFn: (a, b) => a == b,
              onChanged: (value) => setState(() {
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
            AppDropDownSearch<String>(
              title: 'Condition',
              hintText: 'Selected Condition',
              fontSize: widget.isLarge ? 12 : 10,
              borderRadius: 5,
              items: AssetsHelper.conditions,
              itemAsString: (item) => item,
              selectedItem: conditions,
              compareFn: (a, b) => a == b,
              onChanged: (value) => setState(() {
                conditions = value;
              }),
            ),
            AppSpace.vertical(16),
            AppDropDownSearch<String>(
              title: 'Status',
              hintText: 'Selected Status',
              fontSize: widget.isLarge ? 12 : 10,
              borderRadius: 5,
              items: AssetsHelper.status,
              itemAsString: (item) => item,
              selectedItem: status,
              compareFn: (a, b) => a == b,
              onChanged: (value) => setState(() {
                status = value;
              }),
            ),
            AppSpace.vertical(16),
            AppTextField(
              controller: description,
              hintText: 'Optional',
              title: 'Description',
              fontSize: widget.isLarge ? 12 : 10,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
            ),
            AppSpace.vertical(16),
            AppTextField(
              controller: purchaseOrderNumber,
              hintText: 'Optional',
              title: 'Purchase Order Number',
              fontSize: widget.isLarge ? 12 : 10,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
            ),
            AppSpace.vertical(16),
            AppTextField(
              controller: serialNumber,
              hintText: 'Optional',
              title: 'Serial Number',
              fontSize: widget.isLarge ? 12 : 10,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.go,
              onSubmitted: (_) => _onSubmit(),
            ),
            AppSpace.vertical(32),
            BlocConsumer<AssetBloc, AssetState>(
              listener: (context, state) {
                serialNumber.clear();
                if (state.status == StatusAsset.failed) {
                  context.showSnackbar(
                    state.message!,
                    backgroundColor: AppColors.kRed,
                    fontSize: widget.isLarge ? 12 : 10,
                  );
                }

                if (state.status == StatusAsset.success &&
                    state.response != null) {
                  final asset = state.response;
                  context.read<PrinterBloc>().add(
                    OnPrintAssetId(state.response!.assetCode!),
                  );
                  context.showDialogConfirm(
                    title: 'Successfully Registration',
                    content:
                        'Asset Code : ${asset?.assetCode}\nSerial Number : ${asset?.serialNumber}\nLocation : ${asset?.location}',
                    onCancel: () => context.pop(),
                    onCancelText: 'Done',
                    fontSize: widget.isLarge ? 12 : 10,
                    onConfirm: () {
                      context.pop();
                      context.read<PrinterBloc>().add(
                        OnPrintAssetId(asset!.assetCode!),
                      );
                    },
                    onConfirmText: 'Reprint',
                  );
                }
              },
              builder: (context, state) {
                return AppButton(
                  fontSize: widget.isLarge ? 14 : 12,
                  title: state.status == StatusAsset.loading
                      ? 'Loading...'
                      : 'Registration',
                  width: double.maxFinite,
                  onPressed: state.status == StatusAsset.loading
                      ? null
                      : _onSubmit,
                );
              },
            ),
            AppSpace.vertical(24),
          ],
        );
      },
    );
  }

  _onSubmit() {
    final sn = serialNumber.value.text.trim();
    final po = purchaseOrderNumber.value.text.trim();
    final desc = description.value.text.trim();

    if (model != null &&
        colorId != null &&
        conditions != null &&
        status != null) {
      context.showDialogConfirm(
        title: 'Are you sure registration asset ?',
        content: 'Model : ${model?.name}\nSerial Number : $sn\n',
        onCancelText: 'No',
        onConfirmText: 'Yes',
        fontSize: widget.isLarge ? 12 : 10,
        onCancel: () => Navigator.pop(context),
        onConfirm: () {
          context.read<AssetBloc>().add(
            OnCreateAssetsEvent(
              AssetEntity(
                assetModelId: model!.id,
                serialNumber: sn.isEmpty ? '' : sn,
                locationId: location?.id,
                colorId: colorId,
                isMigration: 0,
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
        fontSize: widget.isLarge ? 12 : 10,
      );
    }
  }
}
