import 'package:asset_management/domain/entities/master/asset_brand.dart';
import 'package:asset_management/presentation/bloc/master/master_bloc.dart';
import 'package:asset_management/responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/core.dart';

class CreateAssetBrandView extends StatefulWidget {
  const CreateAssetBrandView({super.key});

  @override
  State<CreateAssetBrandView> createState() => CreateAssetBrandViewState();
}

class CreateAssetBrandViewState extends State<CreateAssetBrandView> {
  late TextEditingController nameC;
  late TextEditingController initC;

  @override
  void initState() {
    nameC = TextEditingController();
    initC = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    nameC.dispose();
    initC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobileLScaffold: _mobileCreateBrand(),
      mobileMScaffold: _mobileCreateBrand(isLarge: false),
    );
  }

  Widget _mobileCreateBrand({bool isLarge = true}) {
    return Scaffold(
      appBar: AppBar(title: Text('Create Asset Brand'), elevation: 0),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              AppSpace.vertical(12),
              AppTextField(
                controller: nameC,
                hintText: 'Example : DELL',
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                title: 'Name',
                fontSize: isLarge ? 14 : 12,
              ),
              AppSpace.vertical(16),
              AppTextField(
                controller: initC,
                fontSize: isLarge ? 14 : 12,
                hintText: 'Example : DLL',
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.go,
                title: 'Init',
                onSubmitted: (_) => _onSubmit(isLarge),
              ),
              AppSpace.vertical(32),
              BlocConsumer<MasterBloc, MasterState>(
                listener: (context, state) {
                  nameC.clear();
                  initC.clear();
                  if (state.status == StatusMaster.failed) {
                    context.showSnackbar(
                      state.message ?? 'Failed to create asset brand',
                      backgroundColor: AppColors.kRed,
                      fontSize: isLarge ? 14 : 12,
                    );
                  }

                  if (state.status == StatusMaster.success) {
                    context.showSnackbar(
                      'Successfully create asset brand',
                      fontSize: isLarge ? 14 : 12,
                    );
                  }
                },
                builder: (context, state) {
                  return AppButton(
                    title: state.status == StatusMaster.loading
                        ? 'Loading...'
                        : 'Create',
                    width: double.maxFinite,
                    fontSize: isLarge ? 16 : 14,
                    onPressed: state.status == StatusMaster.loading
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
        title: 'Are your sure create new brand ?',
        content: 'Name : $name\nInit : $init',
        onCancelText: 'No',
        onConfirmText: 'Yes',
        fontSize: isLarge ? 14 : 12,
        onCancel: () => Navigator.pop(context),
        onConfirm: () {
          context.read<MasterBloc>().add(
            OnCreateBrandEvent(AssetBrand(name: name, init: init)),
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
