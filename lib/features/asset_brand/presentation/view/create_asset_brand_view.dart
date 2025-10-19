import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/core.dart';
import '../../asset_brand_export.dart';

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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Asset Brand'),
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
                hintText: 'Example : DELL',
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                title: 'Name',
              ),
              AppSpace.vertical(16),
              AppTextField(
                controller: initC,
                hintText: 'Example : DLL',
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.go,
                title: 'Init',
                onSubmitted: (_) => _onSubmit(),
              ),
              AppSpace.vertical(32),
              BlocConsumer<AssetBrandBloc, AssetBrandState>(
                listener: (context, state) {
                  nameC.clear();
                  initC.clear();
                  if (state.status == StatusAssetBrand.failed) {
                    context.showSnackbar(
                      state.message ?? 'Failed to create asset brand',
                      backgroundColor: AppColors.kRed,
                    );
                  }

                  if (state.status == StatusAssetBrand.success) {
                    context.showSnackbar('Successfully create asset brand');
                  }
                },
                builder: (context, state) {
                  return AppButton(
                    title: state.status == StatusAssetBrand.loading
                        ? 'Loading...'
                        : 'Create',
                    width: double.maxFinite,

                    onPressed: state.status == StatusAssetBrand.loading
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
        title: 'Are your sure create new brand ?',
        content: 'Name : $name\nInit : $init',
        onCancelText: 'No',
        onConfirmText: 'Yes',
        onCancel: () => Navigator.pop(context),
        onConfirm: () {
          context.read<AssetBrandBloc>().add(
            OnCreateAssetBrand(AssetBrand(name: name, init: init)),
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
