import 'package:asset_management/features/asset_registration/presentation/view/asset_registration/asset_registration_consumable_view.dart';
import 'package:asset_management/features/asset_registration/presentation/view/asset_registration/asset_registration_non_consumable_view.dart';
import 'package:flutter/material.dart';

import '../../../../../core/core.dart';

class AssetRegistrationView extends StatefulWidget {
  const AssetRegistrationView({super.key});

  @override
  State<AssetRegistrationView> createState() => _AssetRegistrationViewState();
}

class _AssetRegistrationViewState extends State<AssetRegistrationView> {
  List<String> segmentedTypeList = ['NON-CONSUMABLE', 'CONSUMABLE'];
  String selectedType = 'NON-CONSUMABLE';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ASSET REGISTRATION'),
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
              AppSegmentedButton(
                options: segmentedTypeList,
                selected: selectedType,
                onSelectionChanged: (value) => setState(() {
                  selectedType = value.first;
                }),
              ),
              AppSpace.vertical(12),
              selectedType == 'NON-CONSUMABLE'
                  ? AssetRegistrationNonConsumableView()
                  : AssetRegistrationConsumableView(),
            ],
          ),
        ),
      ),
    );
  }
}
