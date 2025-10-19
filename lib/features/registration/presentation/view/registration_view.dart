import 'package:flutter/material.dart';

import '../../../../../core/core.dart';
import '../../registration_export.dart';

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
      appBar: AppBar(
        title: Text('Registration'),
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
                  ? RegistrationNonConsumableView()
                  : RegistrationConsumableView(),
            ],
          ),
        ),
      ),
    );
  }
}
