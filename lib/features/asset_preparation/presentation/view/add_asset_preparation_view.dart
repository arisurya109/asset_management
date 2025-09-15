import 'package:asset_management/core/extension/context_ext.dart';
import 'package:asset_management/core/extension/string_ext.dart';
import 'package:asset_management/core/widgets/app_button.dart';
import 'package:asset_management/core/widgets/app_dropdown.dart';
import 'package:asset_management/core/widgets/app_space.dart';
import 'package:asset_management/core/widgets/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/colors.dart';
import '../../../../core/utils/constant.dart';
import '../../asset_preparation.dart';

class AddAssetPreparationView extends StatefulWidget {
  const AddAssetPreparationView({super.key});

  @override
  State<AddAssetPreparationView> createState() =>
      _AddAssetPreparationViewState();
}

class _AddAssetPreparationViewState extends State<AddAssetPreparationView> {
  late TextEditingController nameStore;
  late TextEditingController codeStore;
  late TextEditingController initStore;
  String? typePreparation;

  @override
  void dispose() {
    nameStore.dispose();
    codeStore.dispose();
    initStore.dispose();
    super.dispose();
  }

  @override
  void initState() {
    nameStore = TextEditingController();
    codeStore = TextEditingController();
    initStore = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CREATE PREPARATION'),
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
        padding: EdgeInsetsGeometry.symmetric(horizontal: 16, vertical: 12),
        child: SingleChildScrollView(
          child: Column(
            children: [
              AppDropDown(
                hintText: 'Selected Type',
                title: 'Type',
                items: TypePreparations.types,
                value: typePreparation,
                onSelected: (value) => setState(() {
                  typePreparation = value;
                }),
              ),
              AppSpace.vertical(12),
              AppTextField(
                controller: nameStore,
                hintText: 'For Example : Lotte Shopping Avenue',
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                title: 'Name Store',
              ),
              AppSpace.vertical(12),
              AppTextField(
                controller: initStore,
                hintText: 'For Example : LSA',
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                title: 'Initial Store',
              ),
              AppSpace.vertical(12),
              AppTextField(
                controller: codeStore,
                hintText: 'For Example : 64',
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.go,
                title: 'Code Store',
                onSubmitted: (_) => _onSubmit(),
              ),
              AppSpace.vertical(24),
              BlocConsumer<AssetPreparationBloc, AssetPreparationState>(
                listenWhen: (previous, current) {
                  if (previous.status != current.status) {
                    return true;
                  } else {
                    return false;
                  }
                },
                listener: (context, state) {
                  setState(() {
                    typePreparation = null;
                    nameStore.clear();
                    initStore.clear();
                    codeStore.clear();
                  });
                  if (state.status == StatusPreparation.failed) {
                    context.showSnackbar(
                      state.message!,
                      backgroundColor: AppColors.kRed,
                    );
                  }
                  if (state.status == StatusPreparation.success) {
                    context.showSnackbar(
                      state.message!,
                      backgroundColor: AppColors.kBase,
                    );
                  }
                },
                builder: (context, state) {
                  return AppButton(
                    title: state.status == StatusPreparation.loading
                        ? 'Loading...'
                        : 'Create',
                    width: double.maxFinite,
                    onPressed: state.status == StatusPreparation.loading
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
    final type = typePreparation;
    final name = nameStore.value.text.trim();
    final initial = initStore.value.text.trim();
    final code = codeStore.value.text.trim();

    if (!type.isFilled()) {
      context.showSnackbar(
        'Type cannot be empty',
        backgroundColor: AppColors.kRed,
      );
    } else if (!name.isFilled()) {
      context.showSnackbar(
        'Name Store cannot be empty',
        backgroundColor: AppColors.kRed,
      );
    } else if (!initial.isFilled()) {
      context.showSnackbar(
        'Initial Store cannot be empty',
        backgroundColor: AppColors.kRed,
      );
    } else if (!code.isNumber()) {
      context.showSnackbar(
        'The store code cannot be empty and must be a number.',
        backgroundColor: AppColors.kRed,
      );
    } else {
      context.showDialogConfirm(
        title: 'Create Asset Preparation',
        content:
            'Are you sure, Create Asset Preparation Store ? \nType : $type\nName Store : $name\nInitial Store : $initial\nCode Store : $code',
        onCancelText: 'No',
        onCancel: () => Navigator.pop(context),
        onConfirmText: 'Ya',
        onConfirm: () {
          Navigator.pop(context);
          context.read<AssetPreparationBloc>().add(
            OnCreatePreparation(
              AssetPreparation(
                storeName: name,
                storeInitial: initial,
                type: type,
                status: PreparationStatus.created,
                storeCode: int.tryParse(code),
                createdAt: DateTime.now().toIso8601String(),
              ),
            ),
          );
        },
      );
    }
  }
}
