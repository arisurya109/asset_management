import 'package:asset_management/core/extension/context_ext.dart';
import 'package:asset_management/core/extension/string_ext.dart';
import 'package:asset_management/core/utils/constant.dart';
import 'package:asset_management/core/widgets/app_button.dart';
import 'package:asset_management/core/widgets/app_dropdown.dart';
import 'package:asset_management/core/widgets/app_space.dart';
import 'package:asset_management/core/widgets/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/colors.dart';
import '../../asset_preparation.dart';

class AssetPreparationByIdView extends StatefulWidget {
  final AssetPreparation preparation;
  const AssetPreparationByIdView({super.key, required this.preparation});

  @override
  State<AssetPreparationByIdView> createState() =>
      _AssetPreparationByIdViewState();
}

class _AssetPreparationByIdViewState extends State<AssetPreparationByIdView> {
  late TextEditingController location;
  late TextEditingController box;
  late TextEditingController asset;
  String? type;

  @override
  void dispose() {
    asset.dispose();
    location.dispose();
    box.dispose();
    super.dispose();
  }

  @override
  void initState() {
    asset = TextEditingController();
    location = TextEditingController();
    box = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppSpace.vertical(8),
        AppDropDown(
          hintText: 'Selected Type',
          items: TypeAssets.types,
          title: 'Type',
          value: type,
          onSelected: (value) => setState(() {
            type = value;
          }),
        ),
        AppSpace.vertical(12),
        AppTextField(
          title: 'Location',
          hintText: 'For Example : LD.01.01.01',
          controller: location,
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.next,
        ),
        AppSpace.vertical(12),
        AppTextField(
          title: 'Box',
          hintText: 'For Example : BOX-JARINGAN',
          controller: box,
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.next,
        ),
        AppSpace.vertical(12),
        AppTextField(
          title: 'Asset',
          hintText: 'For Example : AST-CPU-2509140001',
          controller: asset,
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.go,
          onSubmitted: (_) => _onSubmit(),
        ),
        AppSpace.vertical(24),
        BlocConsumer<AssetPreparationDetailBloc, AssetPreparationDetailState>(
          listenWhen: (previous, current) {
            debugPrint(previous.status.toString());
            debugPrint(current.status.toString());
            debugPrint(current.message);
            if (previous.status != current.status && current.message != null) {
              return true;
            } else {
              return false;
            }
          },
          listener: (context, state) {
            asset.clear();
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
            state.copyWith(message: null);
          },
          builder: (context, state) {
            return AppButton(
              title: 'Add',
              width: double.maxFinite,
              onPressed:
                  widget.preparation.status == PreparationStatus.completed
                  ? null
                  : state.status == StatusPreparationDetail.loading
                  ? null
                  : _onSubmit,
            );
          },
        ),
      ],
    );
  }

  _onSubmit() {
    final newLocation = location.value.text.trim();
    final newBox = box.value.text.trim();
    final newAsset = asset.value.text.trim();
    final newType = type;
    if (!newType.isFilled()) {
      context.showSnackbar('Type cannot be empty');
    } else if (!newLocation.isFilled()) {
      context.showSnackbar('Location cannot be empty');
    } else if (!newAsset.isFilled()) {
      context.showSnackbar('Asset cannot be empty');
    } else {
      context.showDialogConfirm(
        title: 'Add Asset Preparation ?',
        content:
            'Asset : $newAsset\nType : $newType\nQuantity : 1\nLocation : $newLocation\nBox : $newBox',
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
                quantity: 1,
              ),
            ),
          );
          Navigator.pop(context);
        },
      );
    }
  }
}
