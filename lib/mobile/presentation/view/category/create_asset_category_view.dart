import 'package:asset_management/domain/entities/master/asset_category.dart';
import 'package:asset_management/mobile/presentation/bloc/category/category_bloc.dart';
import 'package:asset_management/mobile/responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/core.dart';

class CreateAssetCategoryView extends StatefulWidget {
  const CreateAssetCategoryView({super.key});

  @override
  State<CreateAssetCategoryView> createState() =>
      CreateAssetCategoryViewState();
}

class CreateAssetCategoryViewState extends State<CreateAssetCategoryView> {
  late TextEditingController nameC;
  late TextEditingController initC;
  late FocusNode nameFn;
  late FocusNode initFn;

  @override
  void initState() {
    nameC = TextEditingController();
    initC = TextEditingController();
    nameFn = FocusNode();
    initFn = FocusNode();
    nameFn.requestFocus();
    super.initState();
  }

  @override
  void dispose() {
    nameC.dispose();
    initC.dispose();
    nameFn.dispose();
    initFn.dispose();
    FocusManager.instance.primaryFocus?.unfocus();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobileLScaffold: _mobileCreateCategory(),
      mobileMScaffold: _mobileCreateCategory(isLarge: false),
    );
  }

  Widget _mobileCreateCategory({bool isLarge = true}) {
    return Scaffold(
      appBar: AppBar(title: Text('Create Asset Category'), elevation: 0),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              AppSpace.vertical(12),
              AppTextField(
                controller: nameC,
                hintText: 'Example : Computer',
                focusNode: nameFn,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                title: 'Name',
                fontSize: isLarge ? 14 : 12,
              ),
              AppSpace.vertical(16),
              AppTextField(
                controller: initC,
                focusNode: initFn,
                fontSize: isLarge ? 14 : 12,
                hintText: 'Example : CPU',
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.go,
                title: 'Init',
                onSubmitted: (_) => _onSubmit(isLarge),
              ),
              AppSpace.vertical(32),
              BlocConsumer<CategoryBloc, CategoryState>(
                listener: (context, state) {
                  nameC.clear();
                  initC.clear();
                  if (state.status == StatusCategory.failure) {
                    context.showSnackbar(
                      state.message ?? 'Failed to create asset category',
                      backgroundColor: AppColors.kRed,
                      fontSize: isLarge ? 14 : 12,
                    );
                  }
                  if (state.status == StatusCategory.success) {
                    context.showSnackbar(
                      'Successfully create asset category',
                      fontSize: isLarge ? 14 : 12,
                    );
                  }
                },
                builder: (context, state) {
                  return AppButton(
                    title: state.status == StatusCategory.loading
                        ? 'Loading...'
                        : 'Create',
                    width: double.maxFinite,
                    fontSize: isLarge ? 16 : 14,
                    onPressed: state.status == StatusCategory.loading
                        ? null
                        : () => _onSubmit(isLarge),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  _onSubmit(bool isLarge) {
    final name = nameC.value.text.trim();
    final init = initC.value.text.trim();
    if (name.isFilled() && init.length == 3) {
      context.showDialogConfirm(
        title: 'Are your sure create new category ?',
        content: 'Name : $name\nInit : $init',
        onCancelText: 'No',
        onConfirmText: 'Yes',
        fontSize: isLarge ? 14 : 12,
        onCancel: () => Navigator.pop(context),
        onConfirm: () {
          context.read<CategoryBloc>().add(
            OnCreateCategory(AssetCategory(name: name, init: init)),
          );
          Navigator.pop(context);
        },
      );
    } else {
      context.showSnackbar(
        'Name cannot be empty & Init max length 3',
        backgroundColor: AppColors.kRed,
        fontSize: isLarge ? 14 : 12,
      );
    }
  }
}
