import 'package:asset_management/domain/entities/master/vendor.dart';
import 'package:asset_management/mobile/presentation/bloc/master/master_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/core.dart';

class CreateVendorView extends StatefulWidget {
  const CreateVendorView({super.key});

  @override
  State<CreateVendorView> createState() => CreateVendorViewState();
}

class CreateVendorViewState extends State<CreateVendorView> {
  late TextEditingController nameC;
  late TextEditingController initC;
  late TextEditingController phoneC;
  late TextEditingController descriptionC;

  @override
  void initState() {
    nameC = TextEditingController();
    initC = TextEditingController();
    phoneC = TextEditingController();
    descriptionC = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    nameC.dispose();
    initC.dispose();
    phoneC.dispose();
    descriptionC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Create Vendor'), elevation: 0),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              AppSpace.vertical(12),
              AppTextField(
                controller: nameC,
                hintText: 'Example : MITRA SATU',
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                title: 'Name',
              ),
              AppSpace.vertical(16),
              AppTextField(
                controller: initC,
                hintText: 'Example : MSS',
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                title: 'Init',
              ),
              AppSpace.vertical(16),
              AppTextField(
                controller: phoneC,
                hintText: 'Example : 000000000',
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                title: 'Phone',
              ),
              AppSpace.vertical(16),
              AppTextField(
                controller: descriptionC,
                hintText: 'Example : Vendor Backoffice',
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.go,
                title: 'Description',
                onSubmitted: (_) => _onSubmit(),
              ),
              AppSpace.vertical(32),
              BlocConsumer<MasterBloc, MasterState>(
                listener: (context, state) {
                  nameC.clear();
                  initC.clear();
                  phoneC.clear();
                  descriptionC.clear();
                  if (state.status == StatusMaster.failed) {
                    context.showSnackbar(
                      state.message ?? 'Failed to create vendor',
                      backgroundColor: AppColors.kRed,
                    );
                  }

                  if (state.status == StatusMaster.success) {
                    context.showSnackbar('Successfully create vendor');
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
    final phone = phoneC.value.text.trim();
    final description = descriptionC.value.text.trim();
    if (name.isFilled() && init.length == 3) {
      context.showDialogConfirm(
        title: 'Are your sure create new vendor ?',
        content: 'Name : $name\nInit : $init',
        onCancelText: 'No',
        onConfirmText: 'Yes',
        onCancel: () => Navigator.pop(context),
        onConfirm: () {
          context.read<MasterBloc>().add(
            OnCreateVendorEvent(
              Vendor(
                name: name,
                init: init,
                phone: phone,
                description: description,
              ),
            ),
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
