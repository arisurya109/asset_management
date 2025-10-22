import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/core.dart';
import '../../../../core/widgets/app_dropdown_search.dart';
import '../../../asset_model/asset_model_export.dart';
import '../../../location/location_export.dart';
import '../../migration_export.dart';

class MigrationView extends StatefulWidget {
  const MigrationView({super.key});

  @override
  State<MigrationView> createState() => _MigrationViewState();
}

class _MigrationViewState extends State<MigrationView> {
  AssetModel? model;
  Location? location;
  String? status;
  String? conditions;
  String? colors;
  int? colorId;

  late TextEditingController description;
  late TextEditingController assetIdOld;

  @override
  void initState() {
    description = TextEditingController();
    assetIdOld = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Migration'),
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(height: 1, color: AppColors.kBase),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              AppSpace.vertical(12),
              BlocBuilder<LocationBloc, LocationState>(
                builder: (context, state) {
                  return AppDropDownSearch<Location>(
                    title: "Location",
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
                controller: description,
                hintText: 'Optional',
                title: 'Description',
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
              ),
              AppSpace.vertical(16),
              AppTextField(
                controller: assetIdOld,
                hintText: 'Required',
                title: 'Asset Id Old',
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.go,
                onSubmitted: (_) => _onSubmit(),
              ),
              AppSpace.vertical(32),
              BlocConsumer<MigrationBloc, MigrationState>(
                listener: (context, state) {
                  assetIdOld.clear();
                  if (state.status == StatusMigration.failed) {
                    context.showSnackbar(
                      state.message!,
                      backgroundColor: AppColors.kRed,
                    );
                  }

                  if (state.status == StatusMigration.success) {
                    context.showSnackbar('Successfully create new asset');
                  }
                },
                builder: (context, state) {
                  return AppButton(
                    title: state.status == StatusMigration.loading
                        ? 'Loading...'
                        : 'New Registration',
                    width: double.maxFinite,
                    onPressed: state.status == StatusMigration.loading
                        ? null
                        : _onSubmit,
                  );
                },
              ),
              AppSpace.vertical(12),
            ],
          ),
        ),
      ),
    );
  }

  _onSubmit() {
    final desc = description.value.text.trim();
    final ast = assetIdOld.value.text.trim();

    if (model != null &&
        colorId != null &&
        conditions != null &&
        status != null &&
        ast.isFilled()) {
      context.showDialogConfirm(
        title: 'Are you sure migration asset ?',
        content: 'Model : ${model?.name}\nAsset Id Old : $ast',
        onCancelText: 'No',
        onConfirmText: 'Yes',
        onCancel: () => Navigator.pop(context),
        onConfirm: () {
          context.read<MigrationBloc>().add(
            OnMigrationAssetIdOld(
              Migration(
                assetModelId: model!.id,
                locationId: location?.id,
                colorId: colorId,
                assetIdOld: ast,
                isConsumable: 0,
                conditions: conditions,
                quantity: 1,
                remarks: desc,
                uom: 1,
                status: status,
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
