import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/asset_master/asset_master_bloc.dart';
import '../../domain/entities/asset_master.dart';
import '../../../../core/extension/context_ext.dart';
import '../../../../core/utils/colors.dart';
import '../../../../core/utils/constant.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_dropdown.dart';
import '../../../../core/widgets/app_space.dart';
import '../../../../core/widgets/app_text_field.dart';

class AssetMasterDetailView extends StatefulWidget {
  const AssetMasterDetailView({super.key});

  @override
  State<AssetMasterDetailView> createState() => _AssetMasterDetailViewState();
}

class _AssetMasterDetailViewState extends State<AssetMasterDetailView> {
  late TextEditingController nameC;
  late String type;

  @override
  void initState() {
    final asset = context.read<AssetMasterBloc>().state.asset;
    nameC = TextEditingController(text: asset!.name);
    type = asset.type!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DETAIL ASSET MASTER'),
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
        padding: EdgeInsetsGeometry.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              AppDropDown(
                hintText: 'Selected Type',
                title: 'Type',
                items: TypeAssets.types,
                value: type,
                onSelected: (value) => setState(() {
                  type = value!;
                }),
              ),
              AppSpace.vertical(12),
              AppTextField(
                title: 'Name',
                controller: nameC,
                hintText: 'For Example : Kabel LAN',
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.go,
                onSubmitted: (_) => _onUpdateAsset(),
              ),
              AppSpace.vertical(24),
              BlocConsumer<AssetMasterBloc, AssetMasterState>(
                listenWhen: (previous, current) {
                  if (previous.status != current.status) {
                    return true;
                  } else {
                    return false;
                  }
                },
                listener: (context, state) {
                  if (state.status == StatusAssetMaster.failed) {
                    context.showSnackbar(
                      state.message!,
                      backgroundColor: AppColors.kRed,
                    );
                  }
                  if (state.status == StatusAssetMaster.success) {
                    context.showSnackbar(
                      state.message!,
                      backgroundColor: AppColors.kBase,
                    );
                  }
                },
                builder: (context, state) {
                  return AppButton(
                    onPressed: state.status == StatusAssetMaster.loading
                        ? null
                        : _onUpdateAsset,
                    title: state.status == StatusAssetMaster.loading
                        ? 'Loading...'
                        : 'Update',
                    width: double.maxFinite,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onUpdateAsset() {
    final asset = context.read<AssetMasterBloc>().state.asset;

    final currentName = nameC.value.text.trim();
    final currentType = type;

    if (asset!.name != currentName || asset.type != currentType) {
      context.showDialogConfirm(
        title: 'Update Asset',
        content:
            'Are you sure want to update your asset?\nName : $currentName\nType : $currentType',
        onCancelText: 'Cancel',
        onConfirmText: 'Yes',
        onCancel: () => Navigator.pop(context),
        onConfirm: () {
          context.read<AssetMasterBloc>().add(
            OnUpdateAssetMaster(
              AssetMaster(id: asset.id, name: currentName, type: currentType),
            ),
          );
          Navigator.pop(context);
        },
      );
    } else {
      context.showSnackbar('No change in asset', backgroundColor: Colors.red);
    }
  }
}
