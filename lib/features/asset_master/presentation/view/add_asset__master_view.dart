import 'package:asset_management/core/extension/context_ext.dart';
import 'package:asset_management/core/utils/constant.dart';
import 'package:asset_management/core/widgets/app_button.dart';
import 'package:asset_management/core/widgets/app_dropdown.dart';
import 'package:asset_management/core/widgets/app_space.dart';
import 'package:asset_management/core/widgets/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/colors.dart';
import '../../domain/entities/asset_master.dart';
import '../bloc/asset_master/asset_master_bloc.dart';

class AddAssetMasterView extends StatefulWidget {
  const AddAssetMasterView({super.key});

  @override
  State<AddAssetMasterView> createState() => _AddAssetMasterViewState();
}

class _AddAssetMasterViewState extends State<AddAssetMasterView> {
  late TextEditingController nameC;
  String? selectedType;

  @override
  void dispose() {
    nameC.dispose();
    super.dispose();
  }

  @override
  void initState() {
    nameC = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ADD ASSET MASTER'),
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
                value: selectedType,
                onSelected: (value) => setState(() {
                  selectedType = value;
                }),
              ),
              AppSpace.vertical(12),
              AppTextField(
                title: 'Name',
                controller: nameC,
                hintText: 'For Example : Kabel LAN',
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.go,
                onSubmitted: (_) => _onSubmit(),
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
                  setState(() {
                    selectedType = null;
                    nameC.clear();
                  });
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
                        : _onSubmit,
                    title: state.status == StatusAssetMaster.loading
                        ? 'Loading...'
                        : 'Add',
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

  _onSubmit() {
    final type = selectedType;
    final asset = nameC.value.text.trim();

    if (type == null || type == '') {
      context.showSnackbar('Type cannot be empty', backgroundColor: Colors.red);
    } else if (asset == '' || asset.isEmpty) {
      context.showSnackbar('Nama cannot be empty');
    } else {
      context.showDialogConfirm(
        title: 'Create Asset ?',
        content: 'Name : $asset\nType : $type',
        onCancelText: 'Cancel',
        onCancel: () => Navigator.pop(context),
        onConfirmText: 'Yes',
        onConfirm: () {
          Navigator.pop(context);
          context.read<AssetMasterBloc>().add(
            OnInsertAssetMaster(AssetMaster(name: asset, type: type)),
          );
        },
      );
    }
  }
}
