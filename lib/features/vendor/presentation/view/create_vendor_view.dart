import 'package:asset_management/features/vendor/vendor_export.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/core.dart';

class CreateVendorView extends StatefulWidget {
  const CreateVendorView({super.key});

  @override
  State<CreateVendorView> createState() => _CreateVendorViewState();
}

class _CreateVendorViewState extends State<CreateVendorView> {
  late TextEditingController nameC;
  late TextEditingController initC;
  late TextEditingController phoneC;
  late TextEditingController descriptionC;

  @override
  void dispose() {
    _clearController();
    _disposeController();
    super.dispose();
  }

  @override
  void initState() {
    nameC = TextEditingController();
    initC = TextEditingController();
    phoneC = TextEditingController();
    descriptionC = TextEditingController();
    super.initState();
  }

  _clearController() {
    nameC.clear();
    initC.clear();
    phoneC.clear();
    descriptionC.clear();
  }

  _disposeController() {
    nameC.dispose();
    initC.dispose();
    phoneC.dispose();
    descriptionC.dispose();
  }

  _onSubmit() {
    final name = nameC.value.text.trim();
    final init = initC.value.text.trim();
    final phone = phoneC.value.text.trim();
    final description = descriptionC.value.text.trim();

    if (!name.isFilled()) {
      context.showSnackbar(
        'Name is not empty',
        backgroundColor: AppColors.kRed,
      );
    } else if (!init.isFilled()) {
      context.showSnackbar(
        'Init is not empty',
        backgroundColor: AppColors.kRed,
      );
    } else if (!phone.isNumber()) {
      context.showSnackbar(
        'Phone is not empty',
        backgroundColor: AppColors.kRed,
      );
    } else {
      context.showDialogConfirm(
        title: 'Are you sure create new vendor ?',
        content:
            'Name : $name\nInit : $init\nPhone : $phone\nDescription : $description',
        onCancelText: 'No',
        onConfirmText: 'Yes',
        onCancel: () => context.pop(),
        onConfirm: () => context.read<VendorBloc>().add(
          OnCreateVendor(
            Vendor(
              name: name,
              init: init,
              phone: phone,
              description: description,
            ),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Vendor'),
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
              AppSpace.vertical(16),
              AppTextField(
                controller: nameC,
                title: 'Name',
                hintText: 'Example : PT. Mitra Satu Solusindo',
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
              ),
              AppSpace.vertical(16),
              AppTextField(
                controller: initC,
                title: 'Init',
                hintText: 'Example : MSS',
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
              ),
              AppSpace.vertical(16),
              AppTextField(
                controller: phoneC,
                title: 'Phone',
                hintText: 'Example : 0800000000',
                keyboardType: TextInputType.phone,
                textInputAction: TextInputAction.next,
              ),
              AppSpace.vertical(16),
              AppTextField(
                controller: descriptionC,
                title: 'Description',
                hintText: 'Example : POS',
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.go,
                onSubmitted: (_) => _onSubmit(),
              ),
              AppSpace.vertical(32),
              BlocConsumer<VendorBloc, VendorState>(
                listener: (context, state) {
                  _clearController();
                  if (state.status == StatusVendor.failed) {
                    context.showSnackbar(
                      state.message ?? '',
                      backgroundColor: AppColors.kRed,
                    );
                  }

                  if (state.status == StatusVendor.success) {
                    context.showSnackbar('Successfully create new vendor');
                  }
                },
                builder: (context, state) {
                  return AppButton(
                    title: state.status == StatusVendor.loading
                        ? 'Loading...'
                        : 'Create',
                    width: double.maxFinite,
                    onPressed: state.status == StatusVendor.loading
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
}
