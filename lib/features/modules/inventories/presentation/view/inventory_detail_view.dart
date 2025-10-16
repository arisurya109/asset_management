import 'package:asset_management/features/modules/inventories/inventory_export.dart';
import 'package:flutter/material.dart';

import '../../../../../core/core.dart';

class InventoryDetailView extends StatelessWidget {
  final Inventory params;

  const InventoryDetailView({super.key, required this.params});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Asset Detail'),
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(height: 1, color: AppColors.kBase),
          ),
        ),
      ),
    );
  }
}
