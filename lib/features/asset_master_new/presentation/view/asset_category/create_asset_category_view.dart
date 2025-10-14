import 'package:asset_management/features/asset_master_new/asset_master_export.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/core.dart';
import '../../bloc/asset_category/asset_category_bloc.dart';

class CreateAssetCategoryView extends StatefulWidget {
  const CreateAssetCategoryView({super.key});

  @override
  State<CreateAssetCategoryView> createState() =>
      _CreateAssetCategoryViewState();
}

class _CreateAssetCategoryViewState extends State<CreateAssetCategoryView> {
  late TextEditingController nameC;
  late TextEditingController initC;

  @override
  void initState() {
    nameC = TextEditingController();
    initC = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CREATE ASSET CATEGORY'),
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
              AppTextField(
                controller: nameC,
                hintText: 'Example : Monitor',
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                title: 'Name',
              ),
              AppSpace.vertical(16),
              AppTextField(
                controller: initC,
                hintText: 'Example : MNT',
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.go,
                title: 'Init',
                onSubmitted: (_) => _onSubmit(),
              ),
              AppSpace.vertical(32),
              BlocConsumer<AssetCategoryBloc, AssetCategoryState>(
                listener: (context, state) {
                  nameC.clear();
                  initC.clear();
                  if (state.status == StatusAssetCategory.failed) {
                    context.showSnackbar(
                      state.message ?? 'Failed to create asset category',
                      backgroundColor: AppColors.kRed,
                    );
                  }

                  if (state.status == StatusAssetCategory.success) {
                    context.showSnackbar('Successfully create asset category');
                  }
                },
                builder: (context, state) {
                  return AppButton(
                    title: state.status == StatusAssetCategory.loading
                        ? 'Loading...'
                        : 'Create',
                    width: double.maxFinite,

                    onPressed: state.status == StatusAssetCategory.loading
                        ? null
                        : _onSubmit,
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
    final name = nameC.value.text.trim();
    final init = initC.value.text.trim();
    if (name.isFilled() && init.length == 3) {
      context.showDialogConfirm(
        title: 'Are your sure create new category ?',
        content: 'Name : $name\nInit : $init',
        onCancelText: 'No',
        onConfirmText: 'Yes',
        onCancel: () => Navigator.pop(context),
        onConfirm: () {
          context.read<AssetCategoryBloc>().add(
            OnCreateAssetCategory(AssetCategory(name: name, init: init)),
          );
          Navigator.pop(context);
        },
      );
    } else {
      context.showSnackbar(
        'Name cannot be empty & Init max length 3',
        backgroundColor: AppColors.kRed,
      );
    }
  }
}
