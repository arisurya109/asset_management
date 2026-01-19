// ignore_for_file: use_build_context_synchronously, no_leading_underscores_for_local_identifiers

import 'package:asset_management/core/core.dart';
import 'package:asset_management/core/widgets/app_dropdown_search.dart';
import 'package:asset_management/domain/entities/asset/asset_entity.dart';
import 'package:asset_management/domain/entities/master/location.dart';
import 'package:asset_management/domain/entities/picking/picking_detail.dart';
import 'package:asset_management/domain/entities/picking/picking_request.dart';
import 'package:asset_management/mobile/presentation/bloc/picking_detail/picking_detail_bloc.dart';
import 'package:asset_management/mobile/presentation/components/app_text_field_locking.dart';
import 'package:asset_management/mobile/presentation/cubit/datas_cubit.dart';
import 'package:asset_management/mobile/presentation/view/picking/components/suggestion_card.dart';
import 'package:asset_management/mobile/responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class PickingDetailItemView extends StatefulWidget {
  int preparationId;
  PickingDetail params;

  PickingDetailItemView({
    super.key,
    required this.params,
    required this.preparationId,
  });

  @override
  State<PickingDetailItemView> createState() => _PickingDetailItemViewState();
}

class _PickingDetailItemViewState extends State<PickingDetailItemView> {
  bool isButtonClick = false;
  late TextEditingController _categoryC;
  late TextEditingController _modelC;
  late TextEditingController _quantityC;

  late TextEditingController _locationPickC;
  late TextEditingController _assetCodePickC;

  Location? _locationConsumablePick;
  AssetEntity? _assetConsumablePick;
  late TextEditingController _quantityPickC;

  late FocusNode _locationPickFn;
  late FocusNode _assetCodePickFn;
  late FocusNode _quantityPickFn;
  @override
  void initState() {
    _categoryC = TextEditingController(text: widget.params.category);
    _modelC = TextEditingController(text: widget.params.model);
    _quantityC = TextEditingController(
      text: widget.params.isConsumable == 1
          ? '${widget.params.quantity} PCS'
          : '${widget.params.quantity} UNIT',
    );
    _locationPickC = TextEditingController();
    _assetCodePickC = TextEditingController();
    _quantityPickC = TextEditingController();
    _locationPickFn = FocusNode();
    _assetCodePickFn = FocusNode();
    _quantityPickFn = FocusNode();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _locationPickFn.requestFocus();
    });
    super.initState();
  }

  @override
  void dispose() {
    _categoryC.dispose();
    _modelC.dispose();
    _quantityC.dispose();
    _locationPickC.dispose();
    _assetCodePickC.dispose();
    _quantityPickC.dispose();
    _locationPickFn.dispose();
    _assetCodePickFn.dispose();
    _quantityPickFn.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobileLScaffold: _mobilePickingDetailItem(),
      mobileMScaffold: _mobilePickingDetailItem(isLarge: false),
    );
  }

  Widget _mobilePickingDetailItem({bool isLarge = true}) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: EdgeInsets.fromLTRB(16, 12, 16, 12),
        child: _buildActionButton(isLarge),
      ),
      appBar: AppBar(title: Text('Picking Detail Item')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 5, 16, 12),
        children: [
          _buildReadOnlySection(isLarge),
          Divider(height: 40, color: AppColors.kBase),
          _buildScanningSection(isLarge, widget.params.isConsumable == 1),
        ],
      ),
    );
  }

  Widget _buildActionButton(bool isLarge) {
    return BlocConsumer<PickingDetailBloc, PickingDetailState>(
      listener: (context, state) {
        if (state.status == StatusPickingDetail.loading) {
          context.dialogLoading();
        }

        if (state.status == StatusPickingDetail.failure) {
          setState(() {
            isButtonClick = !isButtonClick;
          });
          context.popExt();
          context.showSnackbar(
            state.message ?? '',
            backgroundColor: AppColors.kRed,
            fontSize: isLarge ? 14 : 12,
          );
          context.read<PickingDetailBloc>().add(OnSetInitialStatus());
        }

        if (state.status == StatusPickingDetail.addSuccess) {
          context.popExt();
          context.showSnackbar(
            state.message ?? '',
            fontSize: isLarge ? 14 : 12,
          );
          if (widget.params.isConsumable == 1) {
            setState(() {
              widget.params = state.response!.items!
                  .where((element) => element.id == widget.params.id)
                  .first;
              _quantityC = TextEditingController(
                text: widget.params.isConsumable == 1
                    ? '${widget.params.quantity} PCS'
                    : '${widget.params.quantity} UNIT',
              );
              isButtonClick = !isButtonClick;
              _quantityPickC.clear();
            });
          } else if (widget.params.isConsumable == 0) {
            setState(() {
              widget.params = state.response!.items!
                  .where((element) => element.id == widget.params.id)
                  .first;
              _quantityC = TextEditingController(
                text: widget.params.isConsumable == 1
                    ? '${widget.params.quantity} PCS'
                    : '${widget.params.quantity} UNIT',
              );
              isButtonClick = !isButtonClick;
              _assetCodePickC.clear();
              _assetCodePickFn.requestFocus();
            });
          }

          context.read<PickingDetailBloc>().add(OnSetInitialStatus());
        }

        if (state.status == StatusPickingDetail.completedSuccess) {
          context.popExt();
          context.showSnackbar(
            state.message ?? '',
            fontSize: isLarge ? 14 : 12,
          );
          context.read<PickingDetailBloc>().add(OnSetInitialStatus());
          context.popExt();
        }
      },
      builder: (context, state) {
        return AppButton(
          title: isButtonClick ? 'Waiting...' : 'PICK',
          height: 28,
          width: context.deviceWidth,
          fontSize: isLarge ? 14 : 12,
          onPressed: isButtonClick
              ? null
              : widget.params.isConsumable == 1
              ? () => _pickAssetConsumable(isLarge)
              : () => _assetNonConsumable(isLarge),
        );
      },
    );
  }

  Widget _buildScanningSection(bool isLarge, bool isConsumable) {
    return isConsumable
        ? Column(
            children: [
              AppDropDownSearch<Location>(
                title: '',
                borderRadius: 4,
                hintText: 'Selected Location',
                fontSize: isLarge ? 14 : 12,
                selectedItem: _locationConsumablePick,
                onChanged: (value) {
                  if (_locationConsumablePick != value) {
                    setState(() {
                      _locationConsumablePick = value;
                      _assetConsumablePick = null;
                    });
                  }
                },
                compareFn: (value, value1) => value.name == value1.name,
                itemAsString: (value) => value.name ?? '',
                onFind: (_) async =>
                    await context.read<DatasCubit>().getLocationsPicking(),
              ),
              AppSpace.vertical(16),
              AppDropDownSearch<AssetEntity>(
                title: '',
                borderRadius: 4,
                hintText: 'Selected Asset',
                fontSize: isLarge ? 14 : 12,
                selectedItem: _assetConsumablePick,
                onChanged: (value) {
                  if (_assetConsumablePick != value) {
                    setState(() {
                      _assetConsumablePick = value;
                      _quantityPickFn.requestFocus();
                    });
                  }
                },
                compareFn: (value, value1) => value.model == value1.model,
                itemAsString: (value) => value.model ?? '',
                onFind: _locationConsumablePick == null
                    ? null
                    : (_) async => await context
                          .read<DatasCubit>()
                          .getAssetByLocation(_locationConsumablePick!.name!),
              ),
              AppSpace.vertical(16),
              AppTextFieldLocking(
                controller: _quantityPickC,
                focusNode: _quantityPickFn,
                fontSize: isLarge ? 14 : 12,
                hintText: 'Quantity',
                textInputAction: TextInputAction.go,
                onSubmitted: (_) => _pickAssetConsumable(isLarge),
              ),
            ],
          )
        : Column(
            children: [
              AppTextFieldLocking(
                controller: _locationPickC,
                focusNode: _locationPickFn,
                fontSize: isLarge ? 14 : 12,
                hintText: 'Location',
                textInputAction: TextInputAction.next,
                onSubmitted: (_) => _assetCodePickFn.requestFocus(),
              ),
              AppSpace.vertical(16),
              AppTextFieldLocking(
                controller: _assetCodePickC,
                focusNode: _assetCodePickFn,
                fontSize: isLarge ? 14 : 12,
                hintText: 'Asset Code',
                textInputAction: TextInputAction.go,
                onSubmitted: (_) => _assetNonConsumable(isLarge),
              ),
            ],
          );
  }

  Widget _buildReadOnlySection(bool isLarge) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppTextFieldLocking(
          controller: _categoryC,
          fontSize: isLarge ? 14 : 12,
          readOnly: true,
        ),
        AppSpace.vertical(16),
        AppTextFieldLocking(
          controller: _modelC,
          fontSize: isLarge ? 14 : 12,
          readOnly: true,
        ),
        AppSpace.vertical(16),
        AppTextFieldLocking(
          controller: _quantityC,
          fontSize: isLarge ? 14 : 12,
          readOnly: true,
        ),
        AppSpace.vertical(16),
        SizedBox(
          height: 70,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemCount: widget.params.suggestion?.length,
            itemBuilder: (context, index) {
              final suggestion = widget.params.suggestion?[index];
              return SuggestionCard(
                suggestion: suggestion,
                isLarge: isLarge,
                isConsumable: widget.params.isConsumable == 1,
              );
            },
          ),
        ),
      ],
    );
  }

  _pickAssetConsumable(bool isLarge) async {
    setState(() {
      isButtonClick = !isButtonClick;
    });
    final _location = _locationConsumablePick;
    final _asset = _assetConsumablePick;
    final _quantity = _quantityPickC.value.text.trim();

    if (_location == null) {
      setState(() {
        isButtonClick = !isButtonClick;
      });
      context.showSnackbar(
        'Location cannot empty',
        backgroundColor: AppColors.kRed,
        fontSize: isLarge ? 14 : 12,
      );
    } else if (_asset == null) {
      setState(() {
        isButtonClick = !isButtonClick;
      });
      context.showSnackbar(
        'Asset cannot empty',
        backgroundColor: AppColors.kRed,
        fontSize: isLarge ? 14 : 12,
      );
    } else if (!_quantity.isNumber()) {
      setState(() {
        isButtonClick = !isButtonClick;
      });
      context.showSnackbar(
        'Quantity not number',
        backgroundColor: AppColors.kRed,
        fontSize: isLarge ? 14 : 12,
      );
    } else if (int.parse(_quantity) > widget.params.quantity!) {
      setState(() {
        isButtonClick = !isButtonClick;
      });
      context.showSnackbar(
        'Quantity exceeds demand',
        backgroundColor: AppColors.kRed,
        fontSize: isLarge ? 14 : 12,
      );
    } else {
      context.showDialogConfirm(
        title: 'Pick Asset ?',
        content:
            'Asset : ${_asset.model}\nQuantity : $_quantity\nLocation : ${_location.name}',
        fontSize: isLarge ? 14 : 12,
        onCancelText: 'No',
        onConfirmText: 'Yes',
        onCancel: () {
          setState(() {
            isButtonClick = !isButtonClick;
          });
          context.popExt();
        },
        onConfirm: () {
          context.read<PickingDetailBloc>().add(
            OnPickAssetEvent(
              PickingRequest(
                preparationId: widget.preparationId,
                assetId: _asset.id,
                locationId: _location.id,
                preparationDetailId: widget.params.id,
                quantity: int.parse(_quantity),
              ),
            ),
          );
          context.popExt();
        },
      );
    }
  }

  _assetNonConsumable(bool isLarge) async {
    setState(() {
      isButtonClick = !isButtonClick;
    });
    final _location = _locationPickC.value.text.trim();
    final _asset = _assetCodePickC.value.text.trim();

    if (!_location.isFilled()) {
      setState(() {
        isButtonClick = !isButtonClick;
      });
      context.showSnackbar(
        'Location cannot empty',
        backgroundColor: AppColors.kRed,
        fontSize: isLarge ? 14 : 12,
      );
    } else if (!_asset.isFilled()) {
      setState(() {
        isButtonClick = !isButtonClick;
      });
      context.showSnackbar(
        'Asset Code cannot empty',
        backgroundColor: AppColors.kRed,
        fontSize: isLarge ? 14 : 12,
      );
    } else {
      final locations = await context.read<DatasCubit>().getLocations();

      final asset = await context.read<DatasCubit>().getAssetByQuery(_asset);

      final location = locations
          .where((element) => element.name == _location)
          .firstOrNull;

      if (location == null) {
        setState(() {
          isButtonClick = !isButtonClick;
        });
        context.showSnackbar(
          'Location not found',
          backgroundColor: AppColors.kRed,
          fontSize: isLarge ? 14 : 12,
        );
      } else if (asset == null) {
        setState(() {
          isButtonClick = !isButtonClick;
        });
        context.showSnackbar(
          'Asset not found',
          backgroundColor: AppColors.kRed,
          fontSize: isLarge ? 14 : 12,
        );
      } else {
        context.showDialogConfirm(
          title: 'Pick Asset ?',
          content:
              'Asset Code : ${asset.assetCode}\nCondition : ${asset.conditions}\nPO : ${asset.purchaseOrder}\nLocation : ${location.name}',
          fontSize: isLarge ? 14 : 12,
          onCancelText: 'No',
          onConfirmText: 'Yes',
          onCancel: () {
            setState(() {
              isButtonClick = !isButtonClick;
            });
            context.popExt();
          },
          onConfirm: () {
            context.read<PickingDetailBloc>().add(
              OnPickAssetEvent(
                PickingRequest(
                  assetId: asset.id,
                  preparationId: widget.preparationId,
                  locationId: location.id,
                  preparationDetailId: widget.params.id,
                  quantity: 1,
                ),
              ),
            );
            context.popExt();
          },
        );
      }
    }
  }
}
