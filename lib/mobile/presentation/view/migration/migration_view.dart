import 'package:asset_management/domain/entities/asset/asset_entity.dart';
import 'package:asset_management/domain/entities/master/asset_category.dart';
import 'package:asset_management/domain/entities/master/asset_model.dart';
import 'package:asset_management/domain/entities/master/location.dart';
import 'package:asset_management/mobile/presentation/bloc/migration/migration_cubit.dart';
import 'package:asset_management/mobile/presentation/bloc/printer/printer_bloc.dart';
import 'package:asset_management/mobile/responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/core.dart';
import '../../../../../core/widgets/app_dropdown_search.dart';

class MigrationView extends StatefulWidget {
  const MigrationView({super.key});

  @override
  State<MigrationView> createState() => _MigrationViewState();
}

class _MigrationViewState extends State<MigrationView> {
  AssetModel? model;
  AssetCategory? category;
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
  void dispose() {
    description.dispose();
    assetIdOld.dispose();
    FocusManager.instance.primaryFocus?.unfocus();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobileLScaffold: _mobileMigration(),
      mobileMScaffold: _mobileMigration(isLarge: false),
    );
  }

  Widget _mobileMigration({bool isLarge = true}) {
    return Scaffold(
      appBar: AppBar(title: Text('Migration')),
      body: BlocBuilder<MigrationCubit, MigrationState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  AppSpace.vertical(12),
                  AppDropDownSearch<Location>(
                    title: "Location",
                    hintText: "Select Location",
                    borderRadius: 5,
                    fontSize: isLarge ? 14 : 12,
                    onFind: (_) async =>
                        await context.read<MigrationCubit>().getLocations(),
                    itemAsString: (item) => item.name ?? '',
                    selectedItem: location,
                    compareFn: (a, b) => a.name == b.name,
                    onChanged: (value) => setState(() {
                      location = value;
                    }),
                  ),
                  AppSpace.vertical(16),
                  AppDropDownSearch<AssetCategory>(
                    title: "Category",
                    hintText: "Select Category",
                    borderRadius: 5,
                    fontSize: isLarge ? 14 : 12,
                    itemAsString: (item) => item.name ?? '',
                    onFind: (_) async => await context
                        .read<MigrationCubit>()
                        .getAssetCategories(),
                    selectedItem: category,
                    compareFn: (a, b) => a.name == b.name,
                    onChanged: (value) => setState(() {
                      category = value;
                    }),
                  ),
                  AppSpace.vertical(16),
                  AppDropDownSearch<AssetModel>(
                    title: "Model",
                    hintText: "Select Model",
                    fontSize: isLarge ? 14 : 12,
                    borderRadius: 4,
                    onFind: category == null
                        ? null
                        : (value) async => await context
                              .read<MigrationCubit>()
                              .getAssetModels(category!.name!),
                    itemAsString: (item) => item.name ?? '',
                    selectedItem: model,
                    compareFn: (a, b) => a.name == b.name,
                    onChanged: (value) => setState(() {
                      model = value;
                    }),
                  ),
                  AppSpace.vertical(16),
                  AppDropDownSearch<String>(
                    title: 'Color',
                    hintText: 'Selected Color',
                    borderRadius: 5,
                    fontSize: isLarge ? 14 : 12,
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
                    borderRadius: 5,
                    fontSize: isLarge ? 14 : 12,
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
                    borderRadius: 5,
                    fontSize: isLarge ? 14 : 12,
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
                    fontSize: isLarge ? 14 : 12,
                    title: 'Description',
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                  ),
                  AppSpace.vertical(16),
                  AppTextField(
                    controller: assetIdOld,
                    hintText: 'Required',
                    title: 'Asset Id Old',
                    fontSize: isLarge ? 14 : 12,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.go,
                    onSubmitted: (_) => _onSubmit(isLarge),
                  ),
                  AppSpace.vertical(32),
                  BlocConsumer<MigrationCubit, MigrationState>(
                    listener: (context, state) {
                      assetIdOld.clear();
                      if (state.status == StatusMigration.failure) {
                        context.showSnackbar(
                          state.message!,
                          backgroundColor: AppColors.kRed,
                        );
                      }

                      if (state.status == StatusMigration.success &&
                          state.asset != null) {
                        final asset = state.asset;
                        context.read<PrinterBloc>().add(
                          OnPrintAssetId(asset!.assetCode!),
                        );
                        context.showDialogConfirm(
                          title: 'Successfully Migration',
                          fontSize: isLarge ? 16 : 14,
                          content:
                              'Asset Code : ${asset.assetCode}\nSerial Number : ${asset.serialNumber}\nLocation : ${asset.location}',
                          onCancel: () => context.popExt(),
                          onCancelText: 'Done',
                          onConfirm: () {
                            context.popExt();
                            context.read<PrinterBloc>().add(
                              OnPrintAssetId(asset.assetCode!),
                            );
                          },
                          onConfirmText: 'Reprint',
                        );
                      }
                    },
                    builder: (context, state) {
                      return AppButton(
                        title: state.status == StatusMigration.loading
                            ? 'Loading...'
                            : 'New Registration',
                        width: double.maxFinite,
                        fontSize: isLarge ? 16 : 14,
                        onPressed: state.status == StatusMigration.loading
                            ? null
                            : () => _onSubmit(isLarge),
                      );
                    },
                  ),
                  AppSpace.vertical(12),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  _onSubmit(bool isLarge) {
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
        fontSize: isLarge ? 14 : 12,
        onCancel: () => Navigator.pop(context),
        onConfirm: () {
          context.read<MigrationCubit>().onMigrateAsset(
            AssetEntity(
              assetModelId: model!.id,
              locationId: location?.id,
              colorId: colorId,
              assetIdOld: ast,
              conditions: conditions,
              quantity: 1,
              remarks: desc.isFilled() ? desc : null,
              uom: 1,
              status: status,
            ),
          );
          Navigator.pop(context);
        },
      );
    } else {
      context.showSnackbar(
        'Failed, please check field is empty',
        backgroundColor: AppColors.kRed,
        fontSize: isLarge ? 14 : 12,
      );
    }
  }
}
