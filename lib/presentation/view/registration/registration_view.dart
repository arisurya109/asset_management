import 'package:asset_management/presentation/view/registration/registration_consumable_view.dart';
import 'package:asset_management/presentation/view/registration/registration_non_consumable_view.dart';
import 'package:flutter/material.dart';

import '../../../../../core/core.dart';

class RegistrationView extends StatefulWidget {
  const RegistrationView({super.key});

  @override
  State<RegistrationView> createState() => _RegistrationViewState();
}

class _RegistrationViewState extends State<RegistrationView> {
  List<String> segmentedTypeList = ['NON-CONSUMABLE', 'CONSUMABLE'];
  String selectedType = 'NON-CONSUMABLE';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Registration')),
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
                  ? RegistrationNonConsumableView()
                  : RegistrationConsumableView(),
            ],
          ),
        ),
      ),
    );
  }
}
