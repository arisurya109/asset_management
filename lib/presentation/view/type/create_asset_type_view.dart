import 'package:asset_management/domain/entities/master/asset_type.dart';
import 'package:asset_management/presentation/bloc/master/master_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/core.dart';

class CreateAssetTypeView extends StatefulWidget {
  const CreateAssetTypeView({super.key});

  @override
  State<CreateAssetTypeView> createState() => CreateAssetTypeViewState();
}

class CreateAssetTypeViewState extends State<CreateAssetTypeView> {
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
    return Scaffold(
      appBar: AppBar(title: Text('Create Asset Type'), elevation: 0),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              AppSpace.vertical(12),
              AppTextField(
                controller: nameC,
                hintText: 'Example : BACKOFFICE',
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                title: 'Name',
              ),
              AppSpace.vertical(16),
              AppTextField(
                controller: initC,
                hintText: 'Example : OFC',
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.go,
                title: 'Init',
                onSubmitted: (_) => _onSubmit(),
              ),
              AppSpace.vertical(32),
              BlocConsumer<MasterBloc, MasterState>(
                listener: (context, state) {
                  nameC.clear();
                  initC.clear();
                  if (state.status == StatusMaster.failed) {
                    context.showSnackbar(
                      state.message ?? 'Failed to create asset type',
                      backgroundColor: AppColors.kRed,
                    );
                  }

                  if (state.status == StatusMaster.success) {
                    context.showSnackbar('Successfully create asset type');
                  }
                },
                builder: (context, state) {
                  return AppButton(
                    title: state.status == StatusMaster.loading
                        ? 'Loading...'
                        : 'Create',
                    width: double.maxFinite,

                    onPressed: state.status == StatusMaster.loading
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
        title: 'Are your sure create new type ?',
        content: 'Name : $name\nInit : $init',
        onCancelText: 'No',
        onConfirmText: 'Yes',
        onCancel: () => Navigator.pop(context),
        onConfirm: () {
          context.read<MasterBloc>().add(
            OnCreateTypeEvent(AssetType(name: name, init: init)),
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
