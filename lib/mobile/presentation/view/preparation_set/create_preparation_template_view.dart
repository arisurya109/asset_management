import 'package:asset_management/core/core.dart';
import 'package:asset_management/domain/entities/master/preparation_template.dart';
import 'package:asset_management/mobile/presentation/view/preparation_set/selected_preparation_item_view.dart';
import 'package:flutter/material.dart';

class CreatePreparationTemplateView extends StatefulWidget {
  const CreatePreparationTemplateView({super.key});

  @override
  State<CreatePreparationTemplateView> createState() =>
      _CreatePreparationTemplateViewState();
}

class _CreatePreparationTemplateViewState
    extends State<CreatePreparationTemplateView> {
  late TextEditingController nameC;
  late TextEditingController descC;

  @override
  void initState() {
    nameC = TextEditingController();
    descC = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    nameC.dispose();
    descC.dispose();
    super.dispose();
  }

  _selectedAsset() {
    final name = nameC.value.text.trim();
    final desc = descC.value.text.trim();

    if (!name.isFilled()) {
      context.showSnackbar(
        'Name cannot be empty',
        backgroundColor: AppColors.kRed,
      );
    } else {
      context.pushExt(
        SelectedPreparationItemView(
          params: PreparationTemplate(
            name: name,
            description: desc,
            isActive: 1,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Create Preparation Set')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              AppSpace.vertical(16),
              AppTextField(
                controller: nameC,
                hintText: 'Name',
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                title: 'Name',
              ),
              AppSpace.vertical(16),
              AppTextField(
                controller: descC,
                hintText: 'Description',
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                title: 'Description',
                onSubmitted: (_) => _selectedAsset(),
              ),
              AppSpace.vertical(48),
              AppButton(
                title: 'Selected Asset',
                width: context.deviceWidth,
                onPressed: _selectedAsset,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
