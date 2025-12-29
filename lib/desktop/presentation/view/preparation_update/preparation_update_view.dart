import 'package:asset_management/core/core.dart';
import 'package:asset_management/core/widgets/app_dropdown_search.dart';
import 'package:asset_management/core/widgets/app_toast.dart';
import 'package:asset_management/desktop/presentation/components/app_body_desktop.dart';
import 'package:asset_management/desktop/presentation/components/app_header_desktop.dart';
import 'package:asset_management/desktop/presentation/components/app_text_field_search_desktop.dart';
import 'package:asset_management/desktop/presentation/cubit/preparation_update/preparation_update_cubit.dart';
import 'package:asset_management/domain/entities/asset/asset_entity.dart';
import 'package:asset_management/domain/entities/master/location.dart';
import 'package:asset_management/mobile/main_export.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PreparationUpdateView extends StatefulWidget {
  const PreparationUpdateView({super.key});

  @override
  State<PreparationUpdateView> createState() => _PreparationUpdateViewState();
}

class _PreparationUpdateViewState extends State<PreparationUpdateView> {
  late TextEditingController assetCodeC;
  late TextEditingController locationAssetC;
  late TextEditingController categoryAssetC;
  late TextEditingController modelAssetC;
  late TextEditingController quantityAssetC;
  late TextEditingController poAssetC;
  late TextEditingController typeAssetC;
  late FocusNode fnAssetCode;

  Location? toLocation;
  AssetEntity? selectedAsset;
  List<String> locations = ['LOC1', 'LOC2', 'LOC3'];

  bool _isSearchActiveAsset = false;

  @override
  void initState() {
    assetCodeC = TextEditingController();
    locationAssetC = TextEditingController();
    categoryAssetC = TextEditingController();
    modelAssetC = TextEditingController();
    quantityAssetC = TextEditingController();
    poAssetC = TextEditingController();
    typeAssetC = TextEditingController();
    fnAssetCode = FocusNode();
    super.initState();
  }

  _clear() {
    locationAssetC.clear();
    categoryAssetC.clear();
    modelAssetC.clear();
    quantityAssetC.clear();
    poAssetC.clear();
    typeAssetC.clear();
    selectedAsset = null;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppHeaderDesktop(title: 'Preparation Update'),
        AppBodyDesktop(
          body: Container(
            width: 300,
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.kWhite,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppDropDownSearch<Location>(
                  title: '',
                  hintText: 'Selected Destination',
                  onFind: (String filter) async => await context
                      .read<PreparationUpdateCubit>()
                      .getLocationsForDropdown(),
                  borderRadius: 4,
                  compareFn: (value, value1) => value.name == value1.name,
                  itemAsString: (value) => value.name!,
                  fontSize: 10,
                  enabled: true,
                  onChanged: (value) => setState(() {
                    toLocation = value;
                    fnAssetCode.requestFocus();
                  }),
                  showSearchBox: true,
                  selectedItem: toLocation,
                ),
                AppSpace.vertical(16),
                AppTextFieldSearchDesktop(
                  width: 300,
                  hintText: 'Asset Code',
                  focusNode: fnAssetCode,
                  controller: assetCodeC,
                  suffixIcon: _isSearchActiveAsset
                      ? IconButton(
                          icon: const Icon(Icons.clear, size: 16),
                          onPressed: () {
                            setState(() {
                              assetCodeC.clear();
                              _isSearchActiveAsset = false;
                              _clear();
                            });
                          },
                        )
                      : null,
                  withSearchIcon: true,
                  onChanged: (value) {
                    if (value.isEmpty && _isSearchActiveAsset) {
                      setState(() {
                        _isSearchActiveAsset = false;
                        _clear();
                      });
                    }
                  },
                  onSubmitted: (value) async {
                    if (value.trim().isNotEmpty) {
                      setState(() => _isSearchActiveAsset = true);
                      final asset = await context
                          .read<PreparationUpdateCubit>()
                          .findAsset(value);

                      if (asset != null) {
                        setState(() {
                          selectedAsset = asset;
                          quantityAssetC.value = TextEditingValue(
                            text: '${asset.quantity} Unit',
                          );
                          categoryAssetC.value = TextEditingValue(
                            text: asset.category ?? '',
                          );
                          modelAssetC.value = TextEditingValue(
                            text: asset.model ?? '',
                          );
                          locationAssetC.value = TextEditingValue(
                            text: asset.locationDetail ?? asset.location ?? '',
                          );
                          typeAssetC.value = TextEditingValue(
                            text: asset.types ?? '',
                          );
                          poAssetC.value = TextEditingValue(
                            text: asset.purchaseOrder.isFilled()
                                ? asset.purchaseOrder!
                                : '-',
                          );
                        });
                        _btn();
                      } else {
                        setState(() => _clear());
                        AppToast.show(
                          context: context,
                          type: ToastType.error,
                          message: 'Asset not found',
                        );
                      }
                    }
                  },
                ),
                AppSpace.vertical(16),
                AppTextFieldSearchDesktop(
                  hintText: 'Quantity',
                  width: 300,
                  controller: quantityAssetC,
                  enabled: false,
                ),
                AppSpace.vertical(16),
                AppTextFieldSearchDesktop(
                  hintText: 'Type',
                  controller: typeAssetC,
                  enabled: false,
                  width: 300,
                ),
                AppSpace.vertical(16),
                AppTextFieldSearchDesktop(
                  hintText: 'Category',
                  controller: categoryAssetC,
                  enabled: false,
                  width: 300,
                ),
                AppSpace.vertical(16),
                AppTextFieldSearchDesktop(
                  hintText: 'Model',
                  controller: modelAssetC,
                  enabled: false,
                  width: 300,
                ),
                AppSpace.vertical(16),
                AppTextFieldSearchDesktop(
                  hintText: 'Location',
                  controller: locationAssetC,
                  enabled: false,
                  width: 300,
                ),
                AppSpace.vertical(16),
                AppTextFieldSearchDesktop(
                  hintText: 'PO',
                  controller: poAssetC,
                  enabled: false,
                  width: 300,
                ),
                AppSpace.vertical(32),
                BlocListener<PreparationUpdateCubit, PreparationUpdateState>(
                  listener: (context, state) {
                    if (state.status == StatusPreparationUpdate.loading) {
                      context.dialogLoadingDesktop();
                    }

                    if (state.status == StatusPreparationUpdate.failure) {
                      context.pop();
                      AppToast.show(
                        context: context,
                        type: ToastType.error,
                        message: state.message!,
                      );
                      fnAssetCode.requestFocus();
                    }

                    if (state.status == StatusPreparationUpdate.success) {
                      context.pop();
                      setState(() {
                        _clear();
                        assetCodeC.clear();
                        fnAssetCode.requestFocus();
                      });
                      AppToast.show(
                        context: context,
                        type: ToastType.success,
                        message: state.message!,
                      );
                    }
                  },
                  child: AppButton(
                    title: 'Update',
                    onPressed: () => _btn(),
                    height: 35,
                    width: 300,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  _btn() {
    if (toLocation == null) {
      AppToast.show(
        context: context,
        type: ToastType.warning,
        message: 'Please selected destination',
      );
    } else if (selectedAsset == null) {
      AppToast.show(
        context: context,
        type: ToastType.warning,
        message: 'Not Found Asset',
      );
    } else {
      context.showDialogConfirm(
        title: 'Update',
        content: 'Are your sure update ?',
        onCancelText: 'Cancel',
        onConfirm: () {
          context.read<PreparationUpdateCubit>().updatePreparationAsset(
            asetId: selectedAsset!.id!,
            movementType: 'PREPARATION',
            fromL: selectedAsset!.locationId!,
            toL: toLocation!.id!,
            qty: selectedAsset!.quantity!,
          );
          context.pop();
        },
        onConfirmText: 'Yes',
        onCancel: () {
          context.pop();
          fnAssetCode.requestFocus();
        },
      );
    }
  }
}
