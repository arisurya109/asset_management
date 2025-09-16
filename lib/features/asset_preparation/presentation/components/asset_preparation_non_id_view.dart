import 'package:asset_management/core/extension/context_ext.dart';
import 'package:asset_management/core/extension/string_ext.dart';
import 'package:asset_management/core/widgets/app_button.dart';
import 'package:asset_management/core/widgets/app_text_field.dart';
import 'package:asset_management/features/asset_preparation/asset_preparation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/colors.dart';
import '../../../../core/utils/constant.dart';
import '../../../../core/widgets/app_dropdown.dart';
import '../../../../core/widgets/app_space.dart';
import '../../../asset_master/presentation/bloc/asset_master/asset_master_bloc.dart';

class AssetPreparationNonIdView extends StatefulWidget {
  final AssetPreparation preparation;
  const AssetPreparationNonIdView({super.key, required this.preparation});

  @override
  State<AssetPreparationNonIdView> createState() =>
      _AssetPreparationNonIdViewState();
}

class _AssetPreparationNonIdViewState extends State<AssetPreparationNonIdView> {
  late TextEditingController quantity;
  late TextEditingController location;
  late TextEditingController box;
  String? asset;
  String? type;

  @override
  void dispose() {
    location.dispose();
    quantity.dispose();
    box.dispose();
    super.dispose();
  }

  @override
  void initState() {
    quantity = TextEditingController();
    location = TextEditingController();
    box = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppSpace.vertical(8),
        AppTextField(
          controller: location,
          hintText: 'For Example : LD.01.01.01',
          title: 'Location',
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.next,
        ),
        AppSpace.vertical(12),
        AppTextField(
          controller: box,
          hintText: 'For Example : BOX-JARINGAN',
          title: 'Box',
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.next,
        ),
        AppSpace.vertical(12),
        BlocBuilder<AssetMasterBloc, AssetMasterState>(
          builder: (context, state) {
            return AppDropDown(
              hintText: 'Selected Asset',
              items: state.assets?.map((e) => e.name).toList(),
              title: 'Asset',
              value: asset,
              onSelected: (value) => setState(() {
                asset = value;
                type = state.assets
                    ?.singleWhere((element) => element.name == asset)
                    .type;
              }),
            );
          },
        ),
        AppSpace.vertical(12),
        AppTextField(
          controller: quantity,
          hintText: 'For Example : 12',
          title: 'Quantity',
          keyboardType: TextInputType.number,
          textInputAction: TextInputAction.go,
          onSubmitted: (_) => _onSubmit(),
        ),
        AppSpace.vertical(24),
        BlocConsumer<AssetPreparationDetailBloc, AssetPreparationDetailState>(
          listenWhen: (previous, current) {
            if (previous.status != current.status && current.message != null) {
              return true;
            } else {
              return false;
            }
          },
          listener: (context, state) {
            setState(() {
              asset = null;
              type = null;
            });
            type = null;
            quantity.clear();
            if (state.status == StatusPreparationDetail.failed) {
              context.showSnackbar(
                state.message!,
                backgroundColor: AppColors.kRed,
              );
            }
            if (state.status == StatusPreparationDetail.created) {
              context.showSnackbar(
                state.message!,
                backgroundColor: AppColors.kBase,
              );
            }
          },
          builder: (context, state) {
            return AppButton(
              title: 'Add',
              onPressed:
                  widget.preparation.status == PreparationStatus.completed
                  ? null
                  : state.status == StatusPreparationDetail.loading
                  ? null
                  : _onSubmit,
              width: double.maxFinite,
            );
          },
        ),
      ],
    );
  }

  _onSubmit() {
    final newLocation = location.value.text.trim();
    final newBox = box.value.text.trim();
    final newQuantity = quantity.value.text.trim();
    final newAsset = asset?.trim();
    final newType = type?.trim();
    if (!newType.isFilled()) {
      context.showSnackbar(
        'Location cannot be empty',
        backgroundColor: AppColors.kRed,
      );
    } else if (!newAsset.isFilled()) {
      context.showSnackbar(
        'Asset cannot be empty',
        backgroundColor: AppColors.kRed,
      );
    } else if (!newQuantity.isFilled() && newQuantity.isNumber()) {
      context.showSnackbar(
        'Quantity cannot be empty',
        backgroundColor: AppColors.kRed,
      );
    } else {
      context.showDialogConfirm(
        title: 'Add Asset Preparation ?',
        content:
            'Asset : $asset\nType : $type\nQuantity : $newQuantity\nLocation : $newLocation\nBox : $newBox',
        onCancelText: 'Cancel',
        onConfirmText: 'Yes',
        onCancel: () => Navigator.pop(context),
        onConfirm: () {
          context.read<AssetPreparationDetailBloc>().add(
            OnInsertPreparationDetails(
              AssetPreparationDetail(
                preparationId: widget.preparation.id,
                asset: newAsset,
                location: newLocation,
                box: newBox,
                type: newType,
                quantity: int.parse(newQuantity),
              ),
            ),
          );
          Navigator.pop(context);
        },
      );
    }
  }
}
