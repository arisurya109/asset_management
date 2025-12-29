import 'package:asset_management/mobile/presentation/view/registration/registration_consumable_view.dart';
import 'package:asset_management/mobile/presentation/view/registration/registration_non_consumable_view.dart';
import 'package:asset_management/mobile/responsive_layout.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/core.dart';

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
    return ResponsiveLayout(
      mobileLScaffold: _mobileRegistration(),
      mobileMScaffold: _mobileRegistration(isLarge: false),
    );
  }

  Widget _mobileRegistration({bool isLarge = true}) {
    return Scaffold(
      appBar: AppBar(title: Text('Registration')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              AppSpace.vertical(12),
              AppSegmentedButton(
                fontSize: isLarge ? 14 : 12,
                options: segmentedTypeList,
                selected: selectedType,
                onSelectionChanged: (value) => setState(() {
                  selectedType = value.first;
                }),
              ),
              AppSpace.vertical(12),
              selectedType == 'NON-CONSUMABLE'
                  ? RegistrationNonConsumableView(isLarge: isLarge)
                  : RegistrationConsumableView(isLarge: isLarge),
            ],
          ),
        ),
      ),
    );
  }
}
